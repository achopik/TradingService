from django.views.decorators.debug import sensitive_post_parameters

from registration.serializers import (
    UserRegisterSerializer,
    PasswordResetConfirmSerializer,
    PasswordResetSerializer,

)

from registration.tokens import check_token, activate_user_profile
from registration.tasks import send_confirmation_mail

from rest_framework import status, generics
from rest_framework.response import Response


class UserRegisterView(generics.CreateAPIView):

    serializer_class = UserRegisterSerializer

    def create(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        self.perform_create(serializer)
        send_confirmation_mail.delay(serializer.data["id"])
        headers = self.get_success_headers(serializer.data)

        return Response(
            {
                "message": "User has been created successfully! Check your email.",
                "user": serializer.data,
            },
            status=status.HTTP_201_CREATED,
            headers=headers,
        )


class ActivationView(generics.RetrieveAPIView):

    def get(self, request, *args, **kwargs):
        message = {
            "detail": "Registration confirmation error. Please, try again",
        }
        token = kwargs['token']
        res = check_token(token)
        if res:
            message["detail"] = "Registration complete. Please login"
            activate_user_profile(res)

        return Response(
            message,
            status=status.HTTP_200_OK
        )


class PasswordResetView(generics.CreateAPIView):

    serializer_class = PasswordResetSerializer

    def post(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)

        serializer.is_valid(raise_exception=True)
        serializer.save()

        return Response(
            {"detail": "Password reset e-mail has been sent."},
            status=status.HTTP_200_OK
        )


class PasswordResetConfirmView(generics.CreateAPIView):

    serializer_class = PasswordResetConfirmSerializer

    def post(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        serializer.save()
        return Response(
            {"detail": "Password has been changed"}
        )

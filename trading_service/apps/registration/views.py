from django.contrib.auth.models import User
from django.shortcuts import render
from django.views import View

from registration.serializers import UserRegisterSerializer
from registration.tasks import send_confirmation_mail
from registration.tokens import check_token

from rest_framework import mixins, status, viewsets
from rest_framework.response import Response


class UserRegisterViewSet(
    mixins.CreateModelMixin,
    mixins.RetrieveModelMixin,
    viewsets.GenericViewSet,
):

    serializer_class = UserRegisterSerializer
    queryset = User.objects.all()

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


class ActivationView(View):

    def get(self, request, token):
        context = {
            "message": "Registration confirmation error. " "Please, try again",
        }
        res = check_token(token)
        if res:
            context["message"] = "Registration complete. Please login"

        return render(request, "registration/login.html", context)

from django.contrib.auth.forms import SetPasswordForm
from django.contrib.auth.models import User

from rest_framework import serializers
from rest_framework.validators import ValidationError

from .tasks import send_password_reset_mail
from .tokens import check_token


class UserRegisterSerializer(serializers.ModelSerializer):

    class Meta:
        model = User
        fields = (
            "id",
            "username",
            "password",
            "first_name",
            "last_name",
            "email"
        )

    def validate_email(self, value):
        if User.objects.filter(email=value).exists():
            raise serializers.ValidationError(
                "Account with given email already exists"
            )
        return value



class PasswordResetSerializer(serializers.Serializer):

    email = serializers.EmailField()

    def validate_email(self, value):
        if not User.objects.filter(email=value).exists():
            raise serializers.ValidationError("No account with given email")
        return value

    def save(self, **kwargs):
        email = self.data['email']
        user = User.objects.get(email=email)
        send_password_reset_mail.delay(user.id)


class PasswordResetConfirmSerializer(serializers.Serializer):

    new_password1 = serializers.CharField(max_length=128)
    new_password2 = serializers.CharField(max_length=128)
    password_form = SetPasswordForm

    def validate(self, attrs):

        try:
            token = self.context.get('view').kwargs['token']
            uid = check_token(token)
            user = User.objects.get(id=uid)
        except (TypeError, ValueError, OverflowError, User.DoesNotExist):
            raise ValidationError({'token': ['Invalid value']})

        self.form = self.password_form(user=user, data=attrs)
        if not self.form.is_valid():
            raise serializers.ValidationError(self.form.errors)

        return attrs

    def save(self):
        return self.form.save()

from django import forms
from django.contrib.auth.forms import UserCreationForm
from django.contrib.auth.models import User


class RegistrationForm(UserCreationForm):
    first_name = forms.CharField(
        max_length=40,
        required=False,
        help_text="Optional field"
    )
    last_name = forms.CharField(
        max_length=40,
        required=False,
        help_text="Optional field",
    )
    email = forms.EmailField(
        max_length=255,
        help_text="Enter an existing email address"
    )

    class Meta:
        model = User
        fields = (
            'username',
            'first_name',
            'last_name',
            'email',
            'password1',
            'password2',
        )

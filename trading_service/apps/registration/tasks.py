from celery import shared_task

from django.conf import settings
from django.contrib.auth.models import User
from django.core.mail import EmailMessage
from django.shortcuts import reverse
from django.template.loader import get_template
from django.utils.encoding import force_bytes, force_text
from django.utils.http import urlsafe_base64_decode, urlsafe_base64_encode

from registration.tokens import profile_activation_token


@shared_task
def send_confirmation_mail(user_id):
    user = User.objects.get(id=user_id)
    token = profile_activation_token.make_token(user)
    uid = urlsafe_base64_encode(force_bytes(user_id))
    url = "http://localhost:8000" + reverse(
        "activate", kwargs={"uidb64": uid, "token": token}
    )
    message = get_template("registration/activation_email.html").render(
        {"activation_url": url}
    )

    mail = EmailMessage(
        "Trading Service Email Confirmation",
        message,
        to=[user.email],
        from_email=settings.EMAIL_HOST_USER,
    )
    mail.content_subtype = "html"
    mail.send()


@shared_task
def check_user_verification(uidb64, token):

    user_id = force_text(urlsafe_base64_decode(uidb64))
    user = User.objects.get(pk=user_id)

    if user and profile_activation_token.check_token(user, token):
        user.profile.is_confirmed = True
        user.save()
        return True

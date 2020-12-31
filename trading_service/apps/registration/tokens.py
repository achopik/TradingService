from typing import Optional, Union

from django.contrib.auth.models import User

from rest_framework_simplejwt.exceptions import TokenError
from rest_framework_simplejwt.tokens import AccessToken


def check_token(token) -> Optional[int]:
    """
    Returns user id and confirms user if token is valid and user exists
    """

    uid = _get_user_id(token)
    user = User.objects.get(id=uid)
    if uid and user:
        user.profile.is_confirmed = True
        user.profile.save()
        return uid


def create_token(user) -> str:
    token = AccessToken.for_user(user)
    return str(token)


def _get_user_id(token) -> Union[int, bool]:
    try:
        user_id = AccessToken(token, verify=True).get('user_id')
        return user_id

    except TokenError:
        return False

from django.contrib.auth.models import User
from django.urls import reverse
from rest_framework import status


from rest_framework.test import (
    APITestCase,
    APIClient,
)

USER_DATA = {
    "username": "test",
    "password": "test1",
}


user = User.objects.create(USER_DATA).save()
client = APIClient()
client.login(**USER_DATA)
print(**USER_DATA)


class TokenTest(APITestCase):
    def __init__(self):
        self.client.login(**USER_DATA)
        super(TokenTest, self).__init__()

    def test_get_token_test(self):
        self.client.post()


class CurrencyTests(APITestCase):
    def test_get_currency_list(self):
        """
        Checks if we can get list of currencies
        """
        url = reverse("token_obtain_pair")
        response = self.client.post(
            url, {"username": "trainee", "password": "trainee1"}, format="json"
        )
        print(response.content)
        self.assertEqual(response.status_code, status.HTTP_200_OK)

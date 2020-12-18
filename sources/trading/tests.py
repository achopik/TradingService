from django.urls import reverse

from rest_framework import status
from rest_framework.test import APITestCase


class CurrencyTests(APITestCase):
    def test_get_currency_list(self):
        """
        Checks if we can get list of currencies without errors
        """
        url = reverse("currency-list")
        response = self.client.get(url)
        self.assertEqual(response.status_code, status.HTTP_200_OK)

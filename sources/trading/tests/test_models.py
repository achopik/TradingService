from django.urls import reverse

import pytest

from rest_framework import status
from rest_framework.test import APITestCase


pytestmark = pytest.mark.django_db


@pytest.mark.usefixtures("currency_obj")
class CurrencyTests(APITestCase):

    def test_currency_endpoint_available(self):
        """
        Checks if we can get Currency endpoint without errors
        """
        url = reverse("currency-list")
        response = self.client.get(url)
        self.assertEqual(response.status_code, status.HTTP_200_OK)

    def test_currency_list(self):
        """
        Checks if currency list endpoint sends data
        """
        url = reverse("currency-list")
        response = self.client.get(url)
        print(response.data)
        self.assertGreater(len(response.data[0]), 2)


@pytest.mark.usefixtures("item_obj")
class ItemTest(APITestCase):

    def test_item_endpoint_available(self):
        """
        Checks if we can use Item endpoint without errors
        """
        url = reverse("item-list")
        response = self.client.get(url)
        self.assertEqual(response.status_code, status.HTTP_200_OK)

    def test_get_item_list(self):
        """
        Checks if item list endpoint sends data
        """

        url = reverse("item-list")
        response = self.client.get(url)
        self.assertGreater(len(response.data[0]), 4)


@pytest.mark.usefixtures("watchlist_obj")
class WatchListTest(APITestCase):

    def test_watchlist_endpoint_available(self):
        """
        Checks if we can use WatchList endpoint without errors
        """
        url = reverse("watchlist-detail", args=['1'])
        response = self.client.get(url)
        self.assertEqual(response.status_code, status.HTTP_200_OK)

    def test_watchlist_retrieval(self):
        """
        Checks if endpoint "watchlist detail" sends data
        """

        url = reverse("watchlist-detail", args=['1'])
        response = self.client.get(url)
        self.assertGreater(len(response.data), 1)


@pytest.mark.usefixtures("price_obj")
class PriceTest(APITestCase):

    def test_price_endpoint_available(self):
        """
        Checks if we can use Price endpoint without errors
        """
        url = reverse("price-list")
        response = self.client.get(url)
        self.assertEqual(response.status_code, status.HTTP_200_OK)

    def test_price_list(self):
        """
        Checks if endpoint "price list" sends data
        """

        url = reverse("price-list")
        response = self.client.get(url)
        print(response.data)
        self.assertGreater(len(response.data[0]), 3)



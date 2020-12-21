from django.urls import reverse

import pytest

from rest_framework import status
from rest_framework.test import APITestCase


pytestmark = pytest.mark.django_db


@pytest.mark.usefixtures("currency_obj")
class CurrencyTests(APITestCase):

    url = reverse("currency-list")

    def test_currency_endpoint_available(self):
        """
        Checks if we can get Currency endpoint without errors
        """
        response = self.client.get(self.url)
        self.assertEqual(response.status_code, status.HTTP_200_OK)

    def test_currency_list(self):
        """
        Checks if currency list endpoint sends data
        """
        response = self.client.get(self.url)
        self.assertGreater(len(response.data[0]), 2)


@pytest.mark.usefixtures("item_obj")
class ItemTest(APITestCase):

    url = reverse("item-list")

    def test_item_endpoint_available(self):
        """
        Checks if we can use Item endpoint without errors
        """
        response = self.client.get(self.url)
        self.assertEqual(response.status_code, status.HTTP_200_OK)

    def test_get_item_list(self):
        """
        Checks if item list endpoint sends data
        """
        response = self.client.get(self.url)
        self.assertGreater(len(response.data[0]), 4)


@pytest.mark.usefixtures("watchlist_obj")
class WatchListTest(APITestCase):

    url = reverse("watchlist-detail", args=['1'])

    def test_watchlist_endpoint_available(self):
        """
        Checks if we can use WatchList endpoint without errors
        """
        response = self.client.get(self.url)
        self.assertEqual(response.status_code, status.HTTP_200_OK)

    def test_watchlist_detail(self):
        """
        Checks if endpoint "watchlist detail" sends data
        """
        response = self.client.get(self.url)
        self.assertGreater(len(response.data), 1)


@pytest.mark.usefixtures("price_obj")
class PriceTest(APITestCase):

    url = reverse("price-list")

    def test_price_endpoint_available(self):
        """
        Checks if we can use Price endpoint without errors
        """

        response = self.client.get(self.url)
        self.assertEqual(response.status_code, status.HTTP_200_OK)

    def test_price_list(self):
        """
        Checks if endpoint "price list" sends data
        """

        response = self.client.get(self.url)
        self.assertGreater(len(response.data[0]), 3)


@pytest.mark.usefixtures("inventory_obj")
class InventoryTest(APITestCase):

    url = reverse("inventory-detail", args=['1'])

    def test_inventory_endpoint_available(self):
        """
        Checks if we can use Inventory endpoint without errors
        """
        response = self.client.get(self.url)
        self.assertEqual(response.status_code, status.HTTP_200_OK)

    def test_inventory_detail(self):
        """
        Checks if endpoint "inventory detail" sends data
        """
        response = self.client.get(self.url)
        self.assertGreater(len(response.data), 1)


@pytest.mark.usefixtures("balance_obj")
class BalanceTest(APITestCase):

    url = reverse("balance-detail", args=['1'])

    def test_inventory_endpoint_available(self):
        """
        Checks if we can use Balance endpoint without errors
        """
        response = self.client.get(self.url)
        self.assertEqual(response.status_code, status.HTTP_200_OK)

    def test_inventory_detail(self):
        """
        Checks if endpoint "balance list" sends data
        """
        response = self.client.get(self.url)
        self.assertGreater(len(response.data), 1)


@pytest.mark.usefixtures("offer_obj")
class OfferTest(APITestCase):

    url = reverse("offer-list")

    def test_offer_endpoint_available(self):
        """
        Checks if we can use Balance endpoint without errors
        """
        response = self.client.get(self.url)
        self.assertEqual(response.status_code, status.HTTP_200_OK)

    def test_inventory_list(self):
        """
        Checks if endpoint "balance list" sends data
        """
        response = self.client.get(self.url)
        self.assertGreater(len(response.data[0]), 3)

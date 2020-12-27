import pytest
from django.test import TestCase
from trading.models import Balance, Inventory, Offer, OrderType, Trade, User
from trading.trader.db_requests import (
    _change_offer_quantity,
    _check_balance,
    _check_inventory,
    _create_trade,
    find_pair_offer,
)
from trading.trader.trade_worker import (
    _currency_transaction,
    _item_transaction,
    _offer_transaction,
    perform_trade,
)

pytestmark = pytest.mark.django_db


@pytest.mark.usefixtures("sell_buy_offers")
class TestDBRequests(TestCase):
    def test_find_pair_offer(self):
        self.assertEqual(find_pair_offer(1), 2)

    def test_find_pair_offer_reversed(self):
        self.assertEqual(find_pair_offer(2), 1)

    def test_seller_balance(self):
        self.assertEqual(_check_balance(2, 1), 0)

    def test_buyer_balance(self):
        self.assertEqual(_check_balance(1, 1), 1000)

    def test_currency_transaction(self):
        _currency_transaction(1, 2, 1, 200)
        self.assertEqual(_check_balance(2, 1), 200)

    def test_item_transaction(self):
        _item_transaction(2, 1, 1, 5)
        self.assertEqual(_check_inventory(1, 1), 15)

    def test_change_offer_quantity(self):
        quantity_before = Offer.objects.first().quantity
        _change_offer_quantity(Offer.objects.first().id, 1)
        self.assertEqual(Offer.objects.first().quantity, quantity_before + 1)

    def test_offer_transaction(self):
        first_offer = Offer.objects.first()
        second_offer = Offer.objects.last()
        _offer_transaction(first_offer.id, second_offer.id, 5)
        self.assertEqual(Offer.objects.exclude(is_active=False).first(), None)

    def test_pair_searching_with_inactive_offers(self):
        last_offer = Offer.objects.last()
        last_offer.is_active = False
        last_offer.save()
        self.assertEqual(find_pair_offer(Offer.objects.first().id), None)


@pytest.mark.usefixtures("sell_buy_offers")
class TestTradeCreation(TestCase):
    def test_trade_creation(self):
        seller_offer = Offer.objects.get(order_type="SELL")
        buyer_offer = Offer.objects.get(order_type="BUY")
        seller_inventory = Inventory.objects.create(
            user_id=seller_offer.user_id, item_id=seller_offer.item_id, quantity=7
        )
        _create_trade(seller_offer.id, buyer_offer.id)
        self.assertIsNotNone(Trade.objects.get(seller_offer_id=seller_offer.id))


@pytest.mark.usefixtures("sell_buy_offers")
class TestTradePerforming(TestCase):
    def test_perform_trade_creates_trade(self):
        seller_offer = Offer.objects.get(order_type="SELL")
        buyer_offer = Offer.objects.get(order_type="BUY")

        seller_inventory = Inventory.objects.create(
            user_id=seller_offer.user_id, item_id=seller_offer.item_id, quantity=7
        )
        buyer_balance = Balance.objects.create(
            user_id=buyer_offer.user_id,
            currency_id=buyer_offer.item.currency_id,
            amount=1000
        )
        print(seller_offer, buyer_offer)
        print(seller_offer.user.balance_set.first(), seller_offer.user.inventory_set.first().quantity)
        perform_trade(seller_offer.id, buyer_offer.id)
        self.assertIsNotNone(Trade.objects.first())

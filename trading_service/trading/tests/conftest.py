from mixer.backend.django import mixer

import pytest

from trading.models import (
    Balance,
    Currency,
    Inventory,
    Item,
    Offer,
    Price,
    User,
    WatchList,
)


@pytest.fixture(autouse=True)
def enable_db_access_for_all_tests(db):
    pass


@pytest.fixture(scope="class")
def currency_obj():
    return mixer.blend(Currency)


@pytest.fixture(scope="class")
def item_obj(currency_obj):
    return mixer.blend(Item, currency=currency_obj)


@pytest.fixture(scope="class")
def user_obj():
    return mixer.blend(User)


@pytest.fixture(scope="class")
def watchlist_obj(user_obj, item_obj):
    return mixer.blend(WatchList, user=user_obj, item=item_obj)


@pytest.fixture(scope="class")
def price_obj(item_obj, currency_obj):
    return mixer.blend(Price, item=item_obj, currency=currency_obj)


@pytest.fixture(scope="class")
def inventory_obj(item_obj, user_obj):
    return mixer.blend(Inventory, item=item_obj, user=user_obj, quantity=10)


@pytest.fixture(scope="class")
def balance_obj(currency_obj, user_obj):
    return mixer.blend(Balance, currency=currency_obj, user=user_obj, amount=1000)


@pytest.fixture(scope="class")
def offer_obj(item_obj, user_obj):
    return mixer.blend(Offer, item=item_obj, user=user_obj, order_type="BUY")


@pytest.fixture(scope="class")
def seller_buyer(inventory_obj, balance_obj):
    seller = mixer.blend(User, username="seller", password="seller01", id=1)
    buyer = mixer.blend(User, username="buyer", password="buyer01", id=2)
    inventory_obj.user = seller
    balance_obj.user = buyer
    return seller, buyer


@pytest.fixture(scope="class")
def sell_buy_offers(seller_buyer, item_obj):
    seller_offer = mixer.blend(
        Offer,
        order_type="SELL",
        user=seller_buyer[0],
        entry_quantity=10,
        quantity=5,
        price=10,
        item=item_obj,
    )
    buyer_offer = mixer.blend(
        Offer,
        order_type="BUY",
        user=seller_buyer[1],
        entry_quantity=10,
        quantity=5,
        price=10,
        item=item_obj,
    )
    return seller_offer, buyer_offer

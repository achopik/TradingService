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
    WatchList
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
    return mixer.blend(Inventory, item=item_obj, user=user_obj)


@pytest.fixture(scope="class")
def balance_obj(currency_obj, user_obj):
    return mixer.blend(Balance, currency=currency_obj, user=user_obj)


@pytest.fixture(scope="class")
def offer_obj(item_obj, user_obj):
    return mixer.blend(Offer, item=item_obj, user=user_obj, order_type="SELL")

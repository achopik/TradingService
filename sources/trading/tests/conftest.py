from mixer.backend.django import mixer

import pytest

from trading.models import (
    Currency,
    Item,
    Offer,
    Price,
    WatchList,
    User
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

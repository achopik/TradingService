from datetime import datetime
from typing import Optional

from django.contrib.auth.models import User

from trading.models import Balance, Currency, Inventory, Item, Offer, Price, Trade


def _check_balance(user_id: int, currency_id: int) -> float:
    return Balance.objects.get_or_create(
        user=User.objects.get(pk=user_id),
        currency=Currency.objects.get(pk=currency_id),
    )[0].amount


def _change_balance(user_id: int, currency_id: int, delta: float) -> Optional[float]:
    """
    Changes amount of certain user's currency for 'delta' value.
    If amount will be < 0, returns None
    """

    balance = Balance.objects.get_or_create(
        user=User.objects.get(pk=user_id),
        currency=Currency.objects.get(pk=currency_id),
    )[0]
    if balance.amount + delta >= 0:
        balance.amount += delta
        balance.save()
        return balance.amount


def _check_inventory(user_id: int, item_id: int) -> int:
    quantity = Inventory.objects.get_or_create(
        user=User.objects.get(pk=user_id),
        item=Item.objects.get(pk=item_id),
    )[0].quantity
    return quantity


def _change_inventory(user_id: int, item_id: int, delta: int) -> Optional[int]:
    """
    Changes item amount for 'delta' value.
    If amount will be < 0, returns None
    """

    inventory = Inventory.objects.get_or_create(
        user=User.objects.get(pk=user_id),
        item=Item.objects.get(pk=item_id),
    )[0]
    if inventory.quantity + delta >= 0:
        inventory.quantity += delta
        inventory.save()
        return inventory.quantity


def _check_offer(offer_id: int):
    offer = Offer.objects.get(pk=offer_id)
    if offer.quantity == offer.entry_quantity:
        offer.is_active = False
        offer.save()


def _change_offer_quantity(offer_id: int, delta: int):
    offer = Offer.objects.get(pk=offer_id)
    offer.quantity += delta
    offer.save()


def _change_price(item_id: int, new_price: float):

    item = Item.objects.get(pk=item_id)
    price = Price.objects.create(
        item=item, currency=item.currency, price=new_price, date=datetime.now()
    )
    price.save()


def _create_trade(seller_offer_id: int, buyer_offer_id: int):
    """
    Creates a trade using sell and buy offers
    """

    seller_offer = Offer.objects.get(pk=seller_offer_id)
    buyer_offer = Offer.objects.get(pk=buyer_offer_id)

    trade = Trade.objects.create(seller_offer=seller_offer, buyer_offer=buyer_offer)
    trade.seller = seller_offer.user
    trade.buyer = buyer_offer.user
    trade.item = seller_offer.item
    trade.unit_price = seller_offer.unit_price
    trade.quantity = min(
        (seller_offer.entry_quantity - seller_offer.actual_quantity),
        (buyer_offer.entry_quantity - buyer_offer.actual_quantity),
    )
    trade.save()

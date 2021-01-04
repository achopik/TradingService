from datetime import datetime
from typing import Optional, Union

from django.db.models import Q

from trading.models import (
    Balance,
    Inventory,
    Item,
    Offer,
    OrderType,
    Price,
    Trade,
)


def find_pair_offer(first_offer_id: int) -> Union[int, bool]:
    """
    Finds pair offer of the opposite type for trade performing
    """

    first_offer = Offer.objects.get(id=first_offer_id)
    second_offer = (
        Offer.objects.filter(
            ~Q(order_type=first_offer.order_type),
            Q(is_active=True),
            ~Q(user=first_offer.user)
        )
    )
    try:
        second_offer = second_offer.order_by("price")
        if first_offer.order_type == OrderType.SELL.name:
            second_offer.first()
            if second_offer.price >= first_offer.price:
                return second_offer.id

        else:
            second_offer = second_offer.last()
            if second_offer.price <= first_offer.price:
                return second_offer.id

    except AttributeError:
        """
        If pair does not exist, return False
        """
        return False


def _create_trade(seller_offer_id: int, buyer_offer_id: int) -> Union[int, bool]:
    """
    Creates a trade using sell and buy offers
    Returns trade id, if creation was successful, else False
    """

    seller_offer = Offer.objects.get(pk=seller_offer_id)
    buyer_offer = Offer.objects.get(pk=buyer_offer_id)
    quantity = min(
        (seller_offer.entry_quantity - seller_offer.quantity),
        (buyer_offer.entry_quantity - buyer_offer.quantity),
    )

    trade = Trade.objects.create(
        seller_offer=seller_offer,
        buyer_offer=buyer_offer,
        seller=seller_offer.user,
        buyer=buyer_offer.user,
        item=seller_offer.item,
        unit_price=(seller_offer.price + buyer_offer.price) / 2,
        quantity=quantity,
    )

    amount = trade.quantity * trade.unit_price

    if (_check_balance(trade.buyer.id, trade.item.currency.id) >= amount or
            _check_inventory(trade.seller.id, trade.item.id) >= trade.quantity):
        """
        Deletes trade if user has not enough money / items
        """
        trade.delete()
        return False

    trade.save()
    return trade.id


def _check_balance(user_id: int, currency_id: int) -> float:
    return Balance.objects.get_or_create(
        user_id=user_id,
        currency_id=currency_id,
    )[0].amount


def _change_balance(user_id: int, currency_id: int, delta: float) -> Optional[float]:
    """
    Changes amount of certain user's currency for 'delta' value.
    If amount will be < 0, returns None
    """

    balance = Balance.objects.get_or_create(
        user_id=user_id,
        currency_id=currency_id,
    )[0]
    if balance.amount + delta >= 0:
        balance.amount += delta
        balance.save()
        return balance.amount


def _check_inventory(user_id: int, item_id: int) -> int:
    quantity = Inventory.objects.get_or_create(
        user_id=user_id,
        item_id=item_id,
    )[0].quantity
    return quantity


def _change_inventory(user_id: int, item_id: int, delta: int) -> Optional[int]:
    """
    Changes item amount for 'delta' value.
    If amount will be < 0, returns None
    """

    inventory = Inventory.objects.get_or_create(
        user_id=user_id,
        item_id=item_id,
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

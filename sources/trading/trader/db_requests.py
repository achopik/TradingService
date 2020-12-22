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


def _create_trade(seller_offer_id: int, buyer_offer_id: int) -> Optional[int]:
    """
    Creates a trade using sell and buy offers
    Returns trade id, if creation was successful, else None
    """

    seller_offer = Offer.objects.get(pk=seller_offer_id)
    buyer_offer = Offer.objects.get(pk=buyer_offer_id)

    trade = Trade.objects.create(seller_offer=seller_offer, buyer_offer=buyer_offer)
    trade.seller = seller_offer.user
    trade.buyer = buyer_offer.user
    trade.item = seller_offer.item
    trade.unit_price = sum(seller_offer.price, buyer_offer.price) / 2
    trade.quantity = min(
        (seller_offer.entry_quantity - seller_offer.actual_quantity),
        (buyer_offer.entry_quantity - buyer_offer.actual_quantity),
    )
    amount = trade.quantity * trade.unit_price
    try:
        assert (
            _check_balance(trade.buyer.id, trade.item.currency.id) >= amount
        ), "Buyer has not enough currency"

        assert (
            _check_inventory(trade.seller.id, trade.item.id) >= trade.quantity
        ), "Seller has not enough items in inventory"
    except AssertionError:
        trade.delete()
        return
    trade.save()
    return trade.id


# ВАЖНАЯ ФУНКЦИЯ, СЛЕДИТЬ ЗА ОТБОРОМ ДАННЫХ #


def find_pair_offer(first_offer_id: int):

    first_offer = Offer.objects.get(id=first_offer_id)
    second_offer = Offer.objects.exclude(
        order_type=first_offer.order_type,
        is_active=False,
        user=first_offer.user
    )
    if first_offer.order_type == 'SELL':
        second_offer = second_offer.order_by('price').first()
        print(second_offer)
        if second_offer.price >= first_offer.price:
            return second_offer.id
    else:
        second_offer = second_offer.order_by('-price').first()
        print(second_offer)
        if second_offer.price <= first_offer.price:
            return second_offer.id

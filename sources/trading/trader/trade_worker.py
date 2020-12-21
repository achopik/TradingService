from trading.models import Trade
from trading.trader.db_requests import (
    _change_balance,
    _change_inventory,
    _change_offer_quantity,
    _check_balance,
    _check_inventory,
    _check_offer,
    _create_trade
)


def perform_trade(trade_id: int):
    """
    Performs all needed transactions for trade
    """

    trade = Trade.objects.get(pk=trade_id)
    seller = trade.seller
    buyer = trade.buyer
    seller_offer = trade.seller_offer
    buyer_offer = trade.buyer_offer
    amount = trade.unit_price * trade.quantity
    print(trade.quantity, trade.seller_offer.is_active)

    # assert (
    #     seller_offer.is_active and buyer_offer.is_active
    # ), "Can't proceed trade containing inactive offers"
    #
    # assert (
    #     _check_balance(buyer.id, trade.item.currency.id) >= amount
    # ), "Buyer has not enough currency"
    #
    # assert (
    #     _check_inventory(seller.id, trade.item.id) >= trade.quantity
    # ), "Seller has not enough items in inventory"

    _currency_transaction(buyer.id, seller.id, trade.item.currency.id, amount)
    _item_transaction(seller.id, buyer.id, trade.item.currency.id, trade.quantity)
    _offer_transaction(seller_offer.id, buyer_offer.id, trade.quantity)


def _currency_transaction(
    _from_user_id: int, _to_user_id: int, currency_id: int, delta: float
):
    """
    Performs money transaction by delta value in given currency
    """

    _change_balance(_from_user_id, currency_id, -delta)
    _change_balance(_to_user_id, currency_id, delta)


def _item_transaction(_from_user_id: int, _to_user_id: int, item_id: int, delta: int):
    """
    Performs item transaction by delta value for a given item
    """
    _change_inventory(_from_user_id, item_id, -delta)
    _change_inventory(_to_user_id, item_id, delta)


def _offer_transaction(_from_offer_id: int, _to_offer_id: int, delta: int):
    """
    Changes seller and buyer offers quantity
    """

    _change_offer_quantity(_from_offer_id, -delta)
    _change_offer_quantity(_to_offer_id, delta)
    _check_offer(_from_offer_id)
    _check_offer(_to_offer_id)

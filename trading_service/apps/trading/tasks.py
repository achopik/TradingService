from celery import shared_task

from trading.models import Offer, OrderType, Trade, Item
from trading.statistics.item_statistics import (
    update_item_statistics
)
from trading.trader.db_requests import find_pair_offer
from trading.trader.trade_worker import perform_trade


@shared_task()
def search_offers():
    for offer in Offer.objects.filter(is_active=True):

        second_offer_id = find_pair_offer(offer.id)
        if not second_offer_id:
            continue
        try:
            if offer.order_type == OrderType.SELL.name:
                perform_trade(offer.id, second_offer_id)
            else:
                perform_trade(second_offer_id, offer.id)
        except Trade.DoesNotExist:
            continue


@shared_task()
def update_offer_stats():
    for item in Item.objects.all:
        update_item_statistics(item.id)

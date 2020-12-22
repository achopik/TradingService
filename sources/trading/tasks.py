import celery

from trading.models import Offer, OrderType
from trading.trader.db_requests import find_pair_offer
from trading.trader.trade_worker import perform_trade


@celery.shared_task()
def search_offers():
    for offer in Offer.objects.exclude(is_active=False):
        if find_pair_offer(offer.id):
            second_offer_id = find_pair_offer(offer.id)
            if offer.order_type == OrderType.SELL:
                perform_trade(offer.id, second_offer_id)
            else:
                perform_trade(second_offer_id, offer.id)

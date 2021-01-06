from django.db.models import Avg, Max, Min, Q

from trading.models import Offer


def get_item_statistics(item_id: int):
    statistics = _get_all_item_price_values(item_id)

    if None in statistics.values():
        for key in statistics.keys():
            statistics[key] = 0
    return statistics


def _get_all_item_price_values(item_id: int) -> dict:
    return (
        Offer.objects
        .filter(Q(is_active=True), Q(item_id=item_id))
        .aggregate(Avg('price'), Min('price'), Max('price'))
    )

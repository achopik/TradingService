from django.db.models import Avg, Min, Max, Q
from trading.models import Item, Offer, ItemStats


def update_item_statistics(item_id: int):
    stats = ItemStats.create(item_id=item_id)
    calculations = _get_all_item_price_values(item_id)

    if calculations:
        stats.average_price = calculations['price__avg']
        stats.minimum_price = calculations['price__min']
        stats.maximum_price = calculations['price__max']

    stats.save()


def safe_aggregation(fn):
    """
    Decorator handles DoesNotExist exception for offer-searching functions
    """
    def wrapper():
        try:
            return fn()
        except Offer.DoesNotExist:
            return 0

    return wrapper


@safe_aggregation
def _get_all_item_price_values(item_id: int) -> dict:
    return (
        Offer.objects
        .filter(Q(is_active=True), Q(item_id=item_id))
        .aggregate(Avg('price'), Min('price'), Max('price'))
    )

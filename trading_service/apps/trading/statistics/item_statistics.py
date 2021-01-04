from django.db.models import Avg, Max, Min, Q

from trading.models import Item, ItemStats, Offer


def update_item_statistics(item_id: int):
    stats = ItemStats.objects.create(item=Item.objects.get(id=item_id))
    calculations = _get_all_item_price_values(item_id)

    if None not in calculations.values():
        stats.average_price = calculations['price__avg']
        stats.minimum_price = calculations['price__min']
        stats.maximum_price = calculations['price__max']

    stats.save()


def _get_all_item_price_values(item_id: int) -> dict:
    return (
        Offer.objects
        .filter(Q(is_active=True), Q(item_id=item_id))
        .aggregate(Avg('price'), Min('price'), Max('price'))
    )

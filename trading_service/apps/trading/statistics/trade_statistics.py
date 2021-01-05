from django.db.models import Avg, DecimalField, Q, Sum

from trading.models import Trade


def get_trade_info(user_id: int, from_date=None, to_date=None, item_id=None) -> dict:
    """
    Creates dict containing all statistics for authenticated user
    """

    statistics = {}
    statistics.update(_get_trade_sum_for_user(user_id, from_date, to_date))
    statistics.update({
        "trades_count": _count_all_trades(from_date, to_date)
    })

    if item_id:
        statistics.update(_count_sold_item(user_id, item_id, from_date, to_date))

    return statistics


def _get_trade_sum_for_user(user_id: int, from_date=None, to_date=None) -> dict:
    """
    Returns total trade sum for a certain user.
    If time periods aren't empty, filters trades against it
    """

    trades = Trade.objects.filter(Q(seller_id=user_id) | Q(buyer_id=user_id))
    if from_date:
        trades = trades.filter(creation_time__gte=from_date)
    if to_date:
        trades = trades.filter(creation_time__lte=to_date)

    trades = trades.aggregate(
        total_price=Sum("quantity", output_field=DecimalField()) * Avg("unit_price"),
    )

    return trades


def _count_all_trades(from_date=None, to_date=None) -> float:
    """
    Returns number of trades for a given period,
    for all time if periods are None
    """

    trades = Trade.objects
    if from_date:
        trades.filter(creation_time__gte=from_date)
    if to_date:
        trades = trades.filter(creation_time__lte=to_date)

    return trades.count()


def _count_sold_item(user_id, item_id: int, from_date=None, to_date=None) -> dict:
    """
    Returns number of a certain item sold by a certain user
    If period is not None, filters against it.
    """

    trades = Trade.objects.filter(seller_id=user_id, item_id=item_id)
    if from_date:
        trades.filter(creation_time__gte=from_date)
    if to_date:
        trades = trades.filter(creation_time__lte=to_date)

    trades = trades.aggregate(
        item_sold=Sum('quantity')
    )
    return trades

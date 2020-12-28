from rest_framework import mixins, viewsets
from rest_framework import validators


from trading.models import (
    Balance,
    Currency,
    Inventory,
    Item,
    Offer,
    Price,
    Trade,
    WatchList,
)
from trading.serializers import (
    BalanceSerializer,
    CurrencySerializer,
    InventorySerializer,
    ItemSerializer,
    OfferSerializer,
    PriceSerializer,
    TradeSerializer,
    WatchListSerializer,
)


class CurrencyViewSet(
    mixins.CreateModelMixin,
    mixins.ListModelMixin,
    mixins.UpdateModelMixin,
    viewsets.GenericViewSet,
):

    queryset = Currency.objects.all()
    serializer_class = CurrencySerializer


class ItemViewSet(
    mixins.CreateModelMixin,
    mixins.ListModelMixin,
    mixins.RetrieveModelMixin,
    viewsets.GenericViewSet,
):

    queryset = Item.objects.all()
    serializer_class = ItemSerializer


class PriceViewSet(
    mixins.ListModelMixin,
    mixins.RetrieveModelMixin,
    viewsets.GenericViewSet,
):

    queryset = Price.objects.all()
    serializer_class = PriceSerializer


class WatchListViewSet(
    mixins.RetrieveModelMixin,
    mixins.CreateModelMixin,
    mixins.UpdateModelMixin,
    viewsets.GenericViewSet,
):

    queryset = WatchList.objects.all()
    serializer_class = WatchListSerializer


class OfferViewSet(
    mixins.CreateModelMixin,
    mixins.UpdateModelMixin,
    mixins.ListModelMixin,
    mixins.RetrieveModelMixin,
    viewsets.GenericViewSet,
):

    queryset = Offer.objects.all()
    serializer_class = OfferSerializer


class InventoryViewSet(
    mixins.RetrieveModelMixin,
    mixins.UpdateModelMixin,
    viewsets.GenericViewSet,
):

    queryset = Inventory.objects.all()
    serializer_class = InventorySerializer


class TradeViewSet(
    mixins.ListModelMixin,
    mixins.RetrieveModelMixin,
    viewsets.GenericViewSet,
):

    queryset = Trade.objects.all()
    serializer_class = TradeSerializer


class BalanceViewSet(
    mixins.RetrieveModelMixin,
    mixins.UpdateModelMixin,
    viewsets.GenericViewSet,
):

    queryset = Balance.objects.all()
    serializer_class = BalanceSerializer

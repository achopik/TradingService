from rest_framework import mixins, permissions, viewsets

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
    ItemCreateSerializer,
    ItemSerializer,
    OfferCreateSerializer,
    OfferSerializer,
    PriceSerializer,
    TradeSerializer,
    WatchListCreateSerializer,
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

    def get_serializer_class(self):
        if self.action == "retrieve" or self.action == "list":
            return ItemSerializer
        return ItemCreateSerializer


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

    def get_serializer_class(self):

        if self.action == "retrieve":
            return WatchListSerializer
        return WatchListCreateSerializer


class OfferViewSet(
    mixins.CreateModelMixin,
    mixins.UpdateModelMixin,
    mixins.ListModelMixin,
    mixins.RetrieveModelMixin,
    viewsets.GenericViewSet,
):

    queryset = Offer.objects.all()

    def get_serializer_class(self):
        if self.action == "retrieve" or self.action == "list":
            return OfferSerializer
        return OfferCreateSerializer


class InventoryViewSet(
    mixins.RetrieveModelMixin,
    mixins.UpdateModelMixin,
    viewsets.GenericViewSet,
):

    queryset = Inventory.objects.all()
    serializer_class = InventorySerializer
    permission_classes = (permissions.IsAdminUser, )


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
    permission_classes = (permissions.IsAdminUser,)

from rest_framework import mixins, permissions, status, viewsets
from rest_framework.response import Response

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
    PrivateStatsSerializer,
    TradeSerializer,
    WatchListCreateSerializer,
    WatchListSerializer,
)
from trading.statistics.item_statistics import get_item_statistics


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


class ItemStatisticsViewSet(
    viewsets.GenericViewSet
):

    def retrieve(self, request, *args, **kwargs):
        stats = get_item_statistics(kwargs['pk'])
        return Response({
            'statiscs': stats},
            status=status.HTTP_200_OK
        )


class UserStatisticsViewSet(
    viewsets.GenericViewSet,
):

    serializer_class = PrivateStatsSerializer
    permission_classes = (permissions.IsAuthenticated, )

    def create(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        return Response(
            serializer.create(serializer.data),
            status=status.HTTP_200_OK,
        )

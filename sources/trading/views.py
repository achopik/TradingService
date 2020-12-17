from rest_framework import mixins
from rest_framework import viewsets

from trading.serializers import (
    CurrencySerializer,
    TradeSerializer,
    ItemSerializer,
    WatchListSerializer,
    OfferSerializer,
    InventorySerializer,
    PriceSerializer,
    BalanceSerializer
)

from trading.models import (
    Currency,
    Item,
    Trade,
    WatchList,
    Offer,
    Inventory,
    Price,
    Balance
)


class BaseViewSet(mixins.ListModelMixin,
                  mixins.CreateModelMixin,
                  mixins.RetrieveModelMixin,
                  mixins.UpdateModelMixin,
                  mixins.DestroyModelMixin,
                  viewsets.GenericViewSet):
    """ Provides basic behavior for all API endpoints """
    pass


class CurrencyViewSet(BaseViewSet):

    queryset = Currency.objects.all()
    serializer_class = CurrencySerializer


class ItemViewSet(BaseViewSet):

    queryset = Item.objects.all()
    serializer_class = ItemSerializer


class PriceViewSet(BaseViewSet):

    queryset = Price.objects.all()
    serializer_class = PriceSerializer


class WatchListViewSet(BaseViewSet):

    queryset = WatchList.objects.all()
    serializer_class = WatchListSerializer


class OfferViewSet(BaseViewSet):

    queryset = Offer.objects.all()
    serializer_class = OfferSerializer


class InventoryViewSet(BaseViewSet):

    queryset = Inventory.objects.all()
    serializer_class = InventorySerializer


class TradeViewSet(BaseViewSet):

    queryset = Trade.objects.all()
    serializer_class = TradeSerializer


class BalanceViewSet(BaseViewSet):

    queryset = Balance.objects.all()
    serializer_class = BalanceSerializer

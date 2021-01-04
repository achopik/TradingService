from rest_framework import serializers

from trading.models import (
    Balance,
    Currency,
    Inventory,
    Item,
    Offer,
    Price,
    Trade,
    User,
    WatchList,
    ItemStats,
)
from trading.validators import validate_offer


class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ("id", "username", "email")


class CurrencySerializer(serializers.ModelSerializer):
    class Meta:
        model = Currency
        fields = "__all__"


class ItemSerializer(serializers.ModelSerializer):

    currency = CurrencySerializer(read_only=True)

    class Meta:
        model = Item
        fields = "__all__"


class ItemCreateSerializer(serializers.ModelSerializer):

    class Meta:
        model = Item
        fields = "__all__"


class PriceSerializer(serializers.ModelSerializer):

    item = ItemSerializer(read_only=True)
    currency = CurrencySerializer(read_only=True)

    class Meta:
        model = Price
        fields = "__all__"


class WatchListSerializer(serializers.ModelSerializer):

    user = UserSerializer(read_only=True)
    item = ItemSerializer(many=True, read_only=True)

    class Meta:
        model = WatchList
        fields = "__all__"


class WatchListCreateSerializer(serializers.ModelSerializer):

    class Meta:
        model = WatchList
        fields = "__all__"


class BaseSerializer(serializers.ModelSerializer):

    user = UserSerializer(read_only=True)
    item = ItemSerializer(read_only=True)


class OfferSerializer(BaseSerializer):
    class Meta:
        model = Offer
        fields = "__all__"


class OfferCreateSerializer(serializers.ModelSerializer):
    class Meta:
        model = Offer
        exclude = ("is_active", )

    def validate(self, attrs):
        """
        Checks if user has enough money or items
        """

        validate_offer(attrs)
        return attrs


class InventorySerializer(BaseSerializer):
    class Meta:
        model = Inventory
        fields = "__all__"


class TradeSerializer(serializers.ModelSerializer):

    item = ItemSerializer(read_only=True)

    class Meta:
        model = Trade
        fields = "__all__"


class BalanceSerializer(serializers.ModelSerializer):

    user = UserSerializer(read_only=True)
    currency = CurrencySerializer(read_only=True)

    class Meta:
        model = Balance
        fields = "__all__"


class ItemStatsSerializer(serializers.ModelSerializer):

    item = ItemSerializer(read_only=True)

    class Meta:
        model = ItemStats
        fields = "__all__"

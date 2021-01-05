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
)
from trading.statistics.trade_statistics import get_trade_info
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


class PrivateStatsSerializer(serializers.Serializer):

    item_id = serializers.IntegerField(
        help_text="Item id for statistics",
        allow_null=True
    )
    from_date = serializers.DateTimeField(allow_null=True)
    to_date = serializers.DateTimeField(allow_null=True)

    def validate(self, attrs):
        try:
            Item.objects.get(id=attrs['item_id'])
        except Item.DoesNotExist:
            raise serializers.ValidationError(
                "Item with given id does not exist"
            )
        if attrs['from_date'] and attrs['to_date']:
            if attrs['from_date'] > attrs['to_date']:
                raise serializers.ValidationError(
                    "Enter valid time period or leave it blank"
                )

        return attrs

    def save(self, **kwargs):
        pass  # No need to save something

    def update(self, instance, validated_data):
        pass  # No instances to update

    def create(self, validated_data):
        user_id = self.context.get('request').user.id
        return get_trade_info(
            user_id,
            validated_data['from_date'],
            validated_data['to_date'],
            validated_data['item_id'],
        )

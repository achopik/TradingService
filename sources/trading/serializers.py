
from rest_framework import serializers
from trading.models import (
    Currency,
    Item,
    Price,
    WatchList,
    Trade,
    Offer,
    Inventory,
    User,
    Balance
)

# Сериализаторы ещё перепишу

class CurrencySerializer(serializers.ModelSerializer):

    class Meta:
        model = Currency
        fields = '__all__'


class ItemSerializer(serializers.ModelSerializer):

    currency = serializers.SlugRelatedField(
        queryset=Currency.objects.all(),
        slug_field='code',
        many=False
    )

    class Meta:
        model = Item
        fields = '__all__'


class PriceSerializer(serializers.ModelSerializer):

    item = serializers.SlugRelatedField(
        queryset=Item.objects.all(),
        slug_field='code',
        many=False
    )
    currency = serializers.SlugRelatedField(
        queryset=Currency.objects.all(),
        slug_field='code',
        many=False
    )

    class Meta:
        model = Price
        fields = '__all__'


class BaseSerializer(serializers.ModelSerializer):
    user = serializers.SlugRelatedField(
        queryset=User.objects.all(),
        slug_field='id',
        many=False
    )
    item = serializers.SlugRelatedField(
        queryset=Item.objects.all(),
        slug_field='name',
        many=False
    )


class WatchListSerializer(serializers.ModelSerializer):

    user = serializers.SlugRelatedField(
        queryset=User.objects.all(),
        slug_field='id',
        many=False
    )
    item = ItemSerializer(
        many=True,
        read_only=True
    )

    class Meta:
        model = WatchList
        fields = '__all__'


class OfferSerializer(BaseSerializer):

    class Meta:
        model = Offer
        fields = '__all__'


class InventorySerializer(BaseSerializer):

    class Meta:
        model = Inventory
        fields = '__all__'


class TradeSerializer(serializers.ModelSerializer):

    item = serializers.SlugRelatedField(
        queryset=Item.objects.all(),
        slug_field='code',
        many=False
    )

    class Meta:
        model = Trade
        fields = '__all__'


class BalanceSerializer(serializers.ModelSerializer):

    user = serializers.SlugRelatedField(
        queryset=User.objects.all(),
        slug_field='id',
        many=False
    )
    currency = serializers.SlugRelatedField(
        queryset=Currency.objects.all(),
        slug_field='code',
        many=False
    )

    class Meta:
        model = Balance
        fields = '__all__'

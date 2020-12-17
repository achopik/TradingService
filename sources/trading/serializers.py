
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


class UserSerializer(serializers.ModelSerializer):

    class Meta:
        model = User
        fields = ('id', 'username')


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

    user = UserSerializer(read_only=True)
    user_id = serializers.SlugRelatedField(
        source='user',
        queryset=User.objects.all(),
        slug_field='id',
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

    item = ItemSerializer(read_only=True)
    item_code = serializers.SlugRelatedField(
        source='item',
        queryset=Item.objects.all(),
        slug_field='id',
    )

    class Meta:
        model = Trade
        fields = '__all__'


class BalanceSerializer(serializers.ModelSerializer):

    user = UserSerializer(read_only=True)
    user_name = serializers.SlugRelatedField(
        source='user',
        slug_field='id',
        queryset=User.objects.all(),
        write_only=True
    )
    currency = CurrencySerializer(read_only=True)
    currency_code = serializers.SlugRelatedField(
        source='currency',
        queryset=Currency.objects.all(),
        slug_field='id',
        write_only=True
    )

    class Meta:
        model = Balance
        fields = '__all__'

from rest_framework import serializers

from trading.models import (
    Balance,
    Inventory,
    OrderType
)


def validate_offer(data):
    order_type = data['order_type']
    validate_quantity(data)

    if order_type == OrderType.SELL.name:
        validate_inventory(data)
    else:
        validate_balance(data)


def validate_quantity(data):
    entry_quantity = data['entry_quantity']
    if entry_quantity == 0:
        raise serializers.ValidationError(
            "Entry quantity can't be less or equal zero"
        )


def validate_balance(data):

    user = data['user']
    currency = data['item'].currency
    balance = Balance.objects.get_or_create(user=user, currency=currency)[0]
    if balance.amount < data['price'] * data['entry_quantity']:
        raise serializers.ValidationError("Buyer has not enough money")


def validate_inventory(data):

    user = data['user']
    inventory = Inventory.objects.get_or_create(user=user, item=data['item'])[0]
    if inventory.quantity < data['entry_quantity']:
        raise serializers.ValidationError("Seller has not enough items")

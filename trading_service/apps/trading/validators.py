from rest_framework import serializers

from trading.models import (
    Balance,
    Inventory,
)


def validate_offer(data):
    order_type = data['order_type']
    if order_type == "SELL":
        validate_inventory(data)
    else:
        validate_balance(data)
    validate_quantity(data)


def validate_quantity(data):
    quantity = data['quantity']
    entry_quantity = data['entry_quantity']
    if entry_quantity == 0:
        raise serializers.ValidationError(
            "Entry quantity can't be less or equal zero"
        )

    elif entry_quantity < quantity:
        raise serializers.ValidationError(
            "Actual quantity can't be greater than entry quantity"
        )


def validate_balance(data):

    user = data['user']
    currency = data['item'].currency
    balance = Balance.objects.get_or_create(user=user, currency=currency)[0]
    if balance.amount < data['price'] * data['entry_quantity'] - data['quantity']:
        raise serializers.ValidationError("Buyer has not enough money")


def validate_inventory(data):

    user = data['user']
    inventory = Inventory.objects.get_or_create(user=user, item=data['item'])[0]
    if inventory.quantity < data['entry_quantity'] - data['quantity']:
        raise serializers.ValidationError("Seller has not enough items")

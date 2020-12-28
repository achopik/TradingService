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


def validate_balance(data):

    user = data['user']
    currency = data['item'].currency
    balance = Balance.objects.get_or_create(user=user, currency=currency)[0]
    if balance.amount < data['price'] * data['entry_quantity'] - data['quantity']:
        raise serializers.ValidationError


def validate_inventory(data):

    user = data['user']
    inventory = Inventory.objects.get_or_create(user=user, item=data['item'])[0]
    if inventory.quantity < data['entry_quantity'] - data['quantity']:
        raise serializers.ValidationError

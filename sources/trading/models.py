from enum import Enum

from django.db import models
from django.contrib.auth.models import User


class OrderType(Enum):
    """ Choices for offers """

    S = 'Sell'
    B = 'Buy'

    @classmethod
    def choices(cls):
        return tuple((i.name, i.value) for i in cls)


class CodeBase(models.Model):
    """ Base class for Currency and Item models """

    name = models.CharField(max_length=200, blank=False, unique=True)
    code = models.CharField(max_length=10, blank=False, unique=True)

    class Meta:
        abstract = True


class Currency(CodeBase):
    """ Representation of a certain Currency (USD, EUR, etc.) """

    def __str__(self):
        return self.code

    class Meta:
        verbose_name = 'Currency'
        verbose_name_plural = 'Currencies'


class Item(CodeBase):
    """ Stock model """

    price = models.DecimalField(max_digits=7, decimal_places=2)
    currency = models.ForeignKey(Currency, blank=True, on_delete=models.SET_DEFAULT, default=1)
    details = models.TextField("Details", blank=True, null=True, max_length=512)

    def __str__(self):
        return self.code


class Price(models.Model):
    """ Price of a particular Item """

    item = models.ForeignKey(Item,
                             on_delete=models.CASCADE,
                             related_name='prices',
                             related_query_name='prices')

    currency = models.ForeignKey(Currency,
                                 on_delete=models.SET_DEFAULT,
                                 blank=True,
                                 default=1)

    price = models.DecimalField(max_digits=7, decimal_places=2)

    date = models.DateTimeField(unique=True, blank=True)

    def __str__(self):
        return f'{self.price} {self.currency.code}'


class WatchList(models.Model):
    """ User's favorites """

    user = models.ForeignKey(User, blank=False, on_delete=models.CASCADE)
    item = models.ManyToManyField(Item, related_name='watchlist', blank=True)


class Offer(models.Model):
    """ Info about a certain Offer """

    def __str__(self):
        return f"{self.order_type}: {self.item}"

    item = models.ForeignKey(Item, blank=False, on_delete=models.CASCADE)
    entry_quantity = models.PositiveIntegerField("Requested quantity")
    quantity = models.PositiveIntegerField("Actual quantity")
    order_type = models.CharField(choices=OrderType.choices(), default=OrderType.S, max_length=2)
    price = models.DecimalField(max_digits=7, decimal_places=2)
    is_active = models.BooleanField(default=True)


class Balance(models.Model):
    """ Shows the amount of certain currency for user """
    user = models.ForeignKey(User, blank=False, null=False, on_delete=models.CASCADE)
    currency = models.ForeignKey(Currency, blank=False, null=True, on_delete=models.SET_NULL)
    amount = models.DecimalField(max_digits=30, decimal_places=3, default=0)



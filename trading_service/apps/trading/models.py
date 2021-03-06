from enum import Enum

from django.contrib.auth.models import User
from django.db import models
from django.dispatch import receiver


class OrderType(Enum):
    """ Choices for offers """

    SELL = "Sell"
    BUY = "Buy"

    @classmethod
    def choices(cls):
        return tuple((i.name, i.value) for i in cls)


class CodeBase(models.Model):
    """ Base class for Currency and Item models """

    name = models.CharField(max_length=200, unique=True)
    code = models.CharField(max_length=10, unique=True)

    class Meta:
        abstract = True


class Currency(CodeBase):
    """ Representation of a certain Currency (USD, EUR, etc.) """

    def __str__(self):
        return self.code

    class Meta:
        verbose_name = "Currency"
        verbose_name_plural = "Currencies"


class Item(CodeBase):
    """ Stock model """

    price = models.DecimalField(max_digits=7, decimal_places=2)
    currency = models.ForeignKey(
        Currency, blank=True, null=True, on_delete=models.SET_NULL
    )
    details = models.TextField("Details", blank=True, null=True, max_length=512)

    def __str__(self):
        return self.code


class Price(models.Model):
    """ Price of a particular Item """

    item = models.ForeignKey(
        Item,
        on_delete=models.CASCADE,
        related_name="prices",
        related_query_name="prices",
    )

    currency = models.ForeignKey(
        Currency, on_delete=models.SET_NULL, blank=True, null=True
    )

    price = models.DecimalField(max_digits=7, decimal_places=2)

    date = models.DateTimeField(unique=True, blank=True, auto_now_add=True)

    def __str__(self):
        return f"{self.price} {self.currency.code}"


class WatchList(models.Model):
    """ User's favorites """

    user = models.OneToOneField(User, on_delete=models.CASCADE)
    item = models.ManyToManyField(Item, blank=True, related_name="watchlist")


class Offer(models.Model):
    """ Info about a certain Offer """

    def __str__(self):
        return f"{self.order_type}: {self.item}"

    user = models.ForeignKey(User, on_delete=models.CASCADE)
    item = models.ForeignKey(Item, on_delete=models.CASCADE)
    entry_quantity = models.PositiveIntegerField("Requested quantity")
    quantity = models.PositiveIntegerField("Actual quantity", default=0)
    order_type = models.CharField(
        choices=OrderType.choices(), default=OrderType.SELL, max_length=6
    )
    price = models.DecimalField(max_digits=7, decimal_places=2)
    is_active = models.BooleanField(default=False)


class Balance(models.Model):
    """ Shows the amount of certain currency for user """

    user = models.ForeignKey(User, on_delete=models.CASCADE)
    currency = models.ForeignKey(Currency, null=True, on_delete=models.SET_NULL)
    amount = models.DecimalField(max_digits=30, decimal_places=3, default=0)


class Inventory(models.Model):
    """ Shows the number of stocks a particular user has """

    user = models.ForeignKey(User, blank=False, on_delete=models.CASCADE)
    item = models.ForeignKey(Item, blank=False, on_delete=models.CASCADE)
    quantity = models.PositiveIntegerField("Stocks quantity", default=0)

    class Meta:
        verbose_name = "Inventory"
        verbose_name_plural = "Inventories"


class Trade(models.Model):
    """ Info about a certain transaction """

    item = models.ForeignKey(Item, blank=True, null=True, on_delete=models.SET_NULL)
    seller = models.ForeignKey(
        User,
        blank=True,
        null=True,
        on_delete=models.SET_NULL,
        related_name="seller_trade",
        related_query_name="seller_trade",
    )
    buyer = models.ForeignKey(
        User,
        blank=True,
        null=True,
        on_delete=models.SET_NULL,
        related_name="buyer_trade",
        related_query_name="buyer_trade",
    )
    quantity = models.PositiveIntegerField()
    unit_price = models.DecimalField(max_digits=7, decimal_places=2)
    description = models.TextField(blank=True, null=True)
    creation_time = models.DateTimeField(auto_now_add=True)
    seller_offer = models.ForeignKey(
        Offer,
        blank=True,
        null=True,
        on_delete=models.SET_NULL,
        related_name="seller_trade",
        related_query_name="seller_trade",
    )
    buyer_offer = models.ForeignKey(
        Offer,
        blank=True,
        null=True,
        on_delete=models.SET_NULL,
        related_name="buyer_trade",
        related_query_name="buyer_trade",
    )


@receiver(models.signals.pre_save, sender=Offer)
def update_offer(sender, instance, **kwargs):

    if not instance.user.profile.is_confirmed:
        instance.is_active = False
    elif instance.quantuty != instance.entry_quantity:
        instance.is_active = True

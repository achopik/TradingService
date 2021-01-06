from django.contrib import admin

from trading.models import (
    Balance,
    Currency,
    Inventory,
    Item,
    Offer,
    Price,
    Trade,
    WatchList,
)

admin.site.register(Balance)
admin.site.register(Currency)
admin.site.register(Inventory)
admin.site.register(Item)
admin.site.register(Offer)
admin.site.register(Price)
admin.site.register(Trade)
admin.site.register(WatchList)

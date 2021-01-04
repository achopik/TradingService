from django.urls import path

from rest_framework.routers import SimpleRouter

import rest_framework_simplejwt.views as jwt_views

from trading.views import (
    BalanceViewSet,
    CurrencyViewSet,
    InventoryViewSet,
    ItemStatisticsViewSet,
    ItemViewSet,
    OfferViewSet,
    PriceViewSet,
    TradeViewSet,
    WatchListViewSet,
)

router = SimpleRouter()
router.register("currency", CurrencyViewSet)
router.register("item", ItemViewSet)
router.register("watchlist", WatchListViewSet)
router.register("price", PriceViewSet)
router.register("inventory", InventoryViewSet)
router.register("offer", OfferViewSet)
router.register("trade", TradeViewSet)
router.register("balance", BalanceViewSet)
router.register("item/statistics", ItemStatisticsViewSet)


urlpatterns = [
    path("token/", jwt_views.TokenObtainPairView.as_view(), name="token_obtain_pair"),
    path("token/refresh/", jwt_views.TokenRefreshView.as_view(), name="token_refresh"),
] + router.urls

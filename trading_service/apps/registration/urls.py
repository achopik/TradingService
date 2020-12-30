from django.urls import path

from rest_framework.routers import SimpleRouter
import rest_framework_simplejwt.views as jwt_views

from registration.views import UserRegisterViewSet, ActivationView


router = SimpleRouter()
router.register("register", UserRegisterViewSet)

# flake8: noqa: E501
urlpatterns = [
    path("token/", jwt_views.TokenObtainPairView.as_view(), name="token_obtain_pair"),
    path("token/refresh/", jwt_views.TokenRefreshView.as_view(), name="token_refresh"),
    path("activate/<str:token>/", ActivationView.as_view(), name="activate"),
] + router.urls

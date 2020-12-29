from django.urls import path

from registration.views import ActivationView, RegistrationView

# flake8: noqa: E501
urlpatterns = [

    path('register/', RegistrationView.as_view(), name='register'),
    path('activate/<str:uidb64>/<str:token>/', ActivationView.as_view(), name='activate'),

]

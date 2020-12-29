from django.urls import path

from .views import RegistrationView, ActivationView


urlpatterns = [

    path('register/', RegistrationView.as_view(), name='register'),
    path('activate/<str:uidb64>/<str:token>/', ActivationView.as_view(), name='activate'),

]
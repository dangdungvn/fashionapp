from django.urls import path
from . import views

urlpatterns = [
    path("toggle/", views.ToggleWishlist.as_view(), name="add-remove-from-wishlist"),
    path("me/", views.GetWishlist.as_view(), name="get-wishlist"),
]

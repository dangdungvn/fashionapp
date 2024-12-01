from django.contrib import admin
from django.urls import path, include

urlpatterns = [
    path("admin/", admin.site.urls),
    path("auth/", include("djoser.urls")),
    path("auth/", include("djoser.urls.authtoken")),
    path("api/products/", include("core.urls")),
    path("api/wishlist/", include("wishlist.urls")),
    path("api/cart/", include("cart.urls")),
    path("api/address/", include("extras.urls")),
    path("api/orders/", include("order.urls")),
    path("api/notifications/", include("notification.urls")),
    path("api/rating/", include("rating.urls")),
]

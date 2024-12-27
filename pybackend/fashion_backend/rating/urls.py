from django.urls import path
from . import views

urlpatterns = [
    path("review/", views.AddReview.as_view(), name="add review"),
    path("get/", views.GetProductRating.as_view(), name="get product rating"),
]

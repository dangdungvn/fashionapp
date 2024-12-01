from django.urls import path
from . import views

urlpatterns = [path("review/", views.AddReview.as_view(), name="add review")]

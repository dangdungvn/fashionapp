from django.urls import path
from . import views

urlpatterns = [
    path('update/', views.UpdateNotificationStatus.as_view(), name='update-notification'),
    path('count/', views.GetNotificationCount.as_view(), name='get-count'),
    path('me/', views.NotificationListView.as_view(), name='get-notifications'),
    
]

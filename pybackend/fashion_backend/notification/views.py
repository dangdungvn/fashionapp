from rest_framework.response import Response
from rest_framework.views import APIView
from . import models, serializers
from rest_framework.permissions import IsAuthenticated
from rest_framework import status

class NotificationListView(APIView):

    def get(self, request):
        notifications = models.Notification.objects.filter(userId=request.user,isRead=False).order_by('-created_at')
        serializer = serializers.NotificationSerializer(notifications, many=True)
        return Response(serializer.data, status=status.HTTP_200_OK)
    
class GetNotificationCount(APIView):
    def get(self, request):
        unread_count = models.Notification.objects.filter(userId=request.user,isRead=False).count()
        return Response({"unread_count": unread_count}, status=status.HTTP_200_OK)

class UpdateNotificationStatus(APIView):
    permission_classes = [IsAuthenticated]
    def patch(self, request):
        notification_id = request.query_params.get("id")
        if not notification_id:
            return Response({"message": "Notification id is required"}, status=status.HTTP_400_BAD_REQUEST)
        try:
            notification = models.Notification.objects.get(id=notification_id)
            notification.isRead = True
            notification.save()
            return Response({"message": "Notification updated successfully"}, status=status.HTTP_200_OK)
        except models.Notification.DoesNotExist:
            return Response({"message": "Notification not found"}, status=status.HTTP_404_NOT_FOUND)

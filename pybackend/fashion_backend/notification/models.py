from django.db import models
from django.contrib.auth.models import User
from order.models import Order

class Notification(models.Model):
    orderId = models.ForeignKey(Order, on_delete=models.CASCADE)
    title = models.CharField(max_length=50)
    message = models.CharField(max_length=255)
    created_at = models.DateTimeField(auto_now_add=True,blank=True)
    isRead = models.BooleanField(default=False)
    userId = models.ForeignKey(User, on_delete=models.CASCADE)
    updated_at = models.DateTimeField(auto_now=True, blank=True)

    def __str__(self):
        return "{} | {}".format(self.userId.username,self.userId.id)

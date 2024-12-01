from django.db import models
from django.contrib.auth.models import User
from extras.models import Address


# Create your models here.
class Order(models.Model):
    PENDING = "pending"
    DELIVERED = "delivered"
    CANCELLED = "cancelled"
    ORDERSTATUS = (
        (PENDING, "Pending"),
        (DELIVERED, "Delivered"),
        (CANCELLED, "Cancelled"),
    )

    PAID = "paid"
    FAILED = "failed"
    PAYMENTSTATUS = (
        (PAID, "Paid"),
        (FAILED, "Failed"),
    )
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    customer_id = models.CharField(max_length=255)
    address = models.ForeignKey(Address, on_delete=models.PROTECT)
    order_products = models.JSONField(default=list)
    rated = models.JSONField(default=list)
    total_quantity = models.IntegerField()
    subtotal = models.FloatField()
    total = models.FloatField()
    delivery_status = models.CharField(
        max_length=255, choices=ORDERSTATUS, default=PENDING
    )
    payment_status = models.CharField(max_length=255)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"Order {self.id} by {self.user.username} to {self.address.address}"

from django.db import models
from django.contrib.auth.models import User
from core.models import Product
from django.utils import timezone

# Create your models here.


class Rating(models.Model):
    rating = models.FloatField(blank=False)
    review = models.CharField(max_length=255, blank=False)
    product = models.ForeignKey(Product, on_delete=models.CASCADE)
    userId = models.ForeignKey(User, on_delete=models.CASCADE)
    order = models.IntegerField(blank=False)
    created_at = models.DateTimeField(default=timezone.now)

    def __str__(self):
        return "{} | {}".format(self.userId.username, self.product.title)

from django.db import models
from django.contrib.auth.models import User
from core.models import Product


# Create your models here.
class WishList(models.Model):
    product = models.ForeignKey(Product, on_delete=models.CASCADE)
    userId = models.ForeignKey(User, on_delete=models.CASCADE)

    def __str__(self):
        return "{}/{}".format(self.userId.username, self.product.title)

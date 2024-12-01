from django.db import models
from django.utils import timezone


class Category(models.Model):
    title = models.CharField(max_length=255, unique=True)
    imageUrl = models.URLField(blank=False)

    def __str__(self) -> str:
        return self.title


class Brand(models.Model):
    title = models.CharField(max_length=255, unique=True)
    imageUrl = models.URLField(blank=False)

    def __str__(self) -> str:
        return self.title


class Product(models.Model):
    title = models.CharField(max_length=255)
    price = models.FloatField(default=0, blank=False)
    description = models.TextField(max_length=550)
    is_featured = models.BooleanField(default=False)
    clothesType = models.CharField(max_length=255, default="unisex")
    ratings = models.FloatField(default=1.0, blank=False)
    category = models.ForeignKey(Category, on_delete=models.CASCADE)
    brand = models.ForeignKey(Brand, on_delete=models.CASCADE)
    colors = models.JSONField(blank=True)
    sizes = models.JSONField(blank=True)
    imageUrls = models.JSONField(blank=True)
    created_at = models.DateTimeField(default=timezone.now, blank=False)

    def __str__(self):
        return self.title


# Create your models here.

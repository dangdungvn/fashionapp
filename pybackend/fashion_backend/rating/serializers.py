from rest_framework import serializers
from . import models
from core.serializers import ProductSerializer
from django.contrib.auth.models import User


class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ["id", "username", "email"]


class RatingSerializer(serializers.ModelSerializer):
    userId = UserSerializer(read_only=True)

    class Meta:
        model = models.Rating
        exclude = ["product", "order"]

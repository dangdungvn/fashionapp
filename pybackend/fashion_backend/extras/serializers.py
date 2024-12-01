from rest_framework import serializers
from . import models

class AddressSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.Address
        fields = "__all__"

class ExtrasSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.Extras
        fields = "__all__"


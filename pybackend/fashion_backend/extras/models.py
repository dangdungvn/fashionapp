from django.db import models
from django.contrib.auth.models import User
# Create your models here.
class Address(models.Model):
    HOME = "home"
    OFFICE = "office"
    SCHOOL = "school"

    ADDRESSTYPE = (
        (HOME, "Home"),
        (OFFICE, "Office"),
        (SCHOOL, "School"),
    )
    lat = models.FloatField()
    lng = models.FloatField()
    isDefault = models.BooleanField(default=False)
    address = models.CharField(max_length=255, blank=False)
    phone = models.CharField(max_length=255, blank=False)
    userId = models.ForeignKey(User, on_delete=models.CASCADE)
    addressType = models.CharField(choices=ADDRESSTYPE, max_length=10, default=HOME)
    
    def __str__(self):
        return "{}/{}".format(self.userId.username, self.addressType, self.phone)
    
class Extras(models.Model):
    isVerified = models.BooleanField(default=False)
    otp = models.CharField(max_length=6, default="")
    userId = models.ForeignKey(User, on_delete=models.CASCADE)
    
    def __str__(self):
        return "{}|{}".format(self.userId.username, self.id)

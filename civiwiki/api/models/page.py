from __future__ import unicode_literals
from django.db import models
import datetime

# Create your models here.
class Page(models.Model):
    owner = models.ForeignKey('Account')
    title = models.CharField(max_length=63, default='')
    body = models.TextField(max_length=4095)
    profile_image = models.CharField(max_length=255)
    cover_image = models.CharField(max_length=255)
    contributors = models.
    def retrieve(self, user):
        return self.find(user=user)[0]

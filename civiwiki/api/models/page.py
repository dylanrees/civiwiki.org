from __future__ import unicode_literals
from django.db import models
import datetime

# Create your models here.
class Page(models.Model):
    owner = models.ForeignKey('Account', related_name='page_owner')
    title = models.CharField(max_length=63, default='')
    description = models.TextField(max_length=4095)
    profile_image = models.CharField(max_length=255)
    cover_image = models.CharField(max_length=255)
    contributors = models.ManyToManyField('Account', related_name='page_member')
    admins = models.ManyToManyField('Account', related_name='page_admin')
    def retrieve(self, user):
        return self.find(user=user)[0]

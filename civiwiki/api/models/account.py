from __future__ import unicode_literals
from django.db import models
import datetime
from django.contrib.auth.models import User

# Create your models here.
class Account(models.Model):
    '''
    This is a DUMMY user model until I can think of a good
    way to implement this.
    '''
    objects = models.Manager()
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    first_name = models.CharField(max_length=63, default='')
    last_name = models.CharField(max_length=63, default='')
    email = models.CharField(max_length=63, unique=True)
    last_login = models.CharField(max_length=63, default=datetime.datetime.now())
    about_me = models.CharField(max_length=511, default='')
    valid = models.BooleanField(default=False)
    profile_image = models.CharField(max_length=255)
    cover_image = models.CharField(max_length=255)
    statistics = models.TextField(default='No statistics at this time.')
    pinned = models.ManyToManyField('Civi')
    history = models.TextField(default='[]')
    friends = models.TextField(default='[]')
    awards = models.TextField(default='[]')

    def retrieve(self, user):
        return self.find(user=user)[0]

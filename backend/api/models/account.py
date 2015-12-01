from __future__ import unicode_literals
from django.db import models
import datetime

# Create your models here.
class Account(models.Model):
    '''
    This is a DUMMY user model until I can think of a good
    way to implement this.
    '''
    objects = models.Manager()
    username = models.CharField(max_length=63, default='', unique=True)
    first_name = models.CharField(max_length=63, default='')
    last_name = models.CharField(max_length=63, default='')
    email = models.CharField(max_length=63, unique=True)
    last_login = models.CharField(max_length=63, default=datetime.datetime.now())
    password = models.CharField(max_length=63, default='')
    about_me = models.CharField(max_length=511, default='')
    valid = models.BooleanField(default=False)
    profile_image = models.ImageField(upload_to='profile', default='profile/generic-profile.png')
    cover_image = models.ImageField(upload_to='cover', default='cover/generic-cover.jpg')
    secret_key = models.CharField(max_length=255, default='')
    statistics = models.TextField(default='No statistics at this time.')
    pinned = models.ManyToManyField('Civi')
    history = models.TextField(default='[]')
    friends = models.TextField(default='[]')
    awards = models.TextField(default='[]')

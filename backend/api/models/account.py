from __future__ import unicode_literals
from django.db import models

# Create your models here.
class Account(models.Model):
    '''
    This is a DUMMY user model until I can think of a good
    way to implement this.
    '''
    objects = models.Manager()
    name = models.CharField(max_length=63)
    about_me = models.CharField(max_length=511, default='')
    pinned = models.ManyToManyField('Civi')

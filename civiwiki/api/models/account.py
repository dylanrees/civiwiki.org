from __future__ import unicode_literals
from django.db import models

# Create your models here.
class Account(models.Model):
    '''
    This is the model schema for the primary object in the application
    '''
    objects = models.Manager()

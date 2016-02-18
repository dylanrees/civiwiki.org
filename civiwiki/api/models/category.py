from __future__ import unicode_literals
from django.db import models

# Create your models here.
class Category(models.Model):
    '''
    Category holds all topics of a similar genre
    '''
    objects = models.Manager()
    name = models.CharField(max_length=63, default='')

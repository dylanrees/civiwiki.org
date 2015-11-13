from __future__ import unicode_literals
from django.db import models

# Create your models here.
class Category(models.Model):
    '''
    Category holds all articles of a similar genre
    '''
    objects = models.Manager()
    name = models.CharField(max_length=31, default='')
    articles = models.ForeignKey('Article') # make this a list of articles

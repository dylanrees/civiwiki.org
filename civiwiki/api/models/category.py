from __future__ import unicode_literals
from django.db import models

# Create your models here.
class CategoryManager(models.Manager):
   def serialize(self, account, filter=None):
      data ={
         "name": Category.name,
         "all_objects": Category.objects,
      }
      return json.dumps(data)
class Category(models.Model):
    '''
    Category holds all topics of a similar genre
    '''
    objects = models.Manager()
    name = models.CharField(max_length=63, default='')

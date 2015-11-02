from __future__ import unicode_literals
from django.db import models

# Create your models here.
class Civi(models.Model):
    '''
    This is the model schema for the primary object in
    the application. Hold an id field and does not hold
    references to other objects. Maybe not the fastest
    implementation but it simplifies things such as searching.
    '''
    CATEGORIES = (
        ('I', 'Issue'),
        ('C', 'Cause'),
        ('S', 'Solution')
    )
    objects = models.Manager()
    author = models.ForeignKey('Account')
    title = models.CharField(max_length=63, default='')
    body = models.TextField(max_length=4095)
    rating = models.IntegerField()
    # This Charfield doesn't link to anything
    # this is just a textual representation of the civi's
    # hashtags, separate objects are also created which handle
    # processing
    category = models.CharField(max_length=16, choices=CATEGORIES)

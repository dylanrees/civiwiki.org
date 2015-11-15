from __future__ import unicode_literals
from django.db import models
from hashtag import Hashtag

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
    author = models.ForeignKey('Account', default=None, null=True)
    article = models.ForeignKey('Article', default=None, null=True)
    hashtags = models.ManyToManyField(Hashtag)

    title = models.CharField(max_length=63, default='')
    body = models.TextField(max_length=4095)

    votes_negative2 = models.IntegerField(default=0, null=True)
    votes_negative1 = models.IntegerField(default=0, null=True)
    votes_neutral = models.IntegerField(default=0, null=True)
    votes_positive1 = models.IntegerField(default=0, null=True)
    votes_positive2 = models.IntegerField(default=0, null=True)

    visits = models.IntegerField(default=0, null=True)

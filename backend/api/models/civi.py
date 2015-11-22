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
    type = models.CharField(max_length=2, default='I')#Possible values of I, C, or S for
    #issue, cause, and solution
    REFERENCE = models.ForeignKey('Civi', related_name='REFERENCE_REL', default='', null=True)
    AT = models.ForeignKey('Civi', related_name='AT_REL', default='', null=True)
    AND_NEGATIVE = models.ForeignKey('Civi', related_name='AND_NEGATIVE_REL', default='', null=True)
    AND_POSITIVE = models.ForeignKey('Civi', related_name='AND_POSITIVE_REL', default='', null=True)

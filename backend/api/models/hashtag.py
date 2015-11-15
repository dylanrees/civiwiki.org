from __future__ import unicode_literals
from django.db import models

# Create your models here.
class Hashtag(models.Model):
    '''
    Hashtags store the civis that they appear in, their text,
    and the vote distribution of the civis they appear in.
    '''
    objects = models.Manager()
    title = models.CharField(max_length=31, default='')
    votes_negative2 = models.IntegerField(default=0, null=True)
    votes_negative1 = models.IntegerField(default=0, null=True)
    votes_neutral = models.IntegerField(default=0, null=True)
    votes_positive1 = models.IntegerField(default=0, null=True)
    votes_positive2 = models.IntegerField(default=0, null=True)

    
    

from __future__ import unicode_literals
from django.db import models

# Create your models here.
class Hashtag(models.Model):
    '''
    Hashtags store the civis that they appear in, their text,
    and the vote distribution of the civis they appear in.
    '''
    objects = models.Manager()
    civi = models.ForeignKey('Civi')#make this a list of civis
    title = models.CharField(max_length=31, default='')

    #vote distribution
    

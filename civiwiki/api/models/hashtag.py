from __future__ import unicode_literals
from django.db import models

# Create your models here.
class HashtagManager(models.Manager):
   def serialize(self, account, filter=None):
      data ={
         "title": Hashtag.title,
         "votes_n1": Hashtag.votes_negative1,
         "votes_n2": Hashtag.votes_negative2,
         "votes_neutral": Hashtag.votes_neutral,
         "votes_p1": Hashtag.votes_positive1,
         "votes_p2": Hashtag.votes_positive2,
         "all_objects": Hashtag.objects,
      }
      return json.dumps(data)
class Hashtag(models.Model):
    '''
    Hashtags store the civis that they appear in, their text,
    and the vote distribution of the civis they appear in.
    '''
    objects = models.Manager()
    title = models.CharField(max_length=63, default='')
    votes_negative2 = models.IntegerField(default=0, null=True)
    votes_negative1 = models.IntegerField(default=0, null=True)
    votes_neutral = models.IntegerField(default=0, null=True)
    votes_positive1 = models.IntegerField(default=0, null=True)
    votes_positive2 = models.IntegerField(default=0, null=True)

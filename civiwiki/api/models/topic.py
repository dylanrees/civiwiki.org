from __future__ import unicode_literals
from django.db import models
from category import Category
import json
# Create your models here.
class TopicManager(models.Manager):
   def serialize(self, topic):
      data ={
         "category": Category.objects.summarize(topic.category),
         "topic": topic.topic,
         "bill": topic.bill,
      }
      return json.dumps(data)
class Topic(models.Model):
    '''
    Comments hold an id reference to the Civi they
    are associated with. As well as their author and
    the text.
    '''
    objects = TopicManager()
    category = models.ForeignKey('Category', default=None, null=True)
    topic = models.CharField(max_length=63, default='')
    bill = models.URLField(null=True, default='')

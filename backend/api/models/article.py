from __future__ import unicode_literals
from django.db import models

# Create your models here.
class Article(models.Model):
    '''
    Comments hold an id reference to the Civi they
    are associated with. As well as their author and
    the text.
    '''
    objects = models.Manager()
    category = models.ForeignKey('Category')
    topic = models.CharField(max_length=31, default='')
    bill = models.URLField(null=True, default='')

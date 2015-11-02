from __future__ import unicode_literals
from django.db import models

# Create your models here.
class Hashtag(models.Model):
    '''
    Comments hold an id reference to the Civi they
    are associated with. As well as their author and
    the text.
    '''
    objects = models.Manager()
    civi = models.ForeignKey('Civi')
    title = models.CharField(max_length=31, default='')

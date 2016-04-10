from __future__ import unicode_literals
from django.db import models

class CommentManager(models.Manager):
   def serialize(self, comment):
      data ={
         "civi": Civi.objects.summarize(comment.civi),
         "author": Account.objects.summarize(comment.author),
         "comment": comment.comment,
      }
      return json.dumps(data)
# Create your models here.
class Comment(models.Model):
    '''
    Comments hold an id reference to the Civi they
    are associated with. As well as their author and
    the text.
    '''
    objects = CommentManager()
    civi = models.ForeignKey('Civi')
    author = models.ForeignKey('Account')
    comment = models.CharField(max_length=511, default="")

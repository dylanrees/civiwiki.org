from __future__ import unicode_literals
from django.db import models

class AttachmentManager(models.Manager):
   def serialize(self, attachment):
      data ={
         "attachment": attachment.attachment,
         "civi": attachment.bill,
      }
      return json.dumps(data)
# Create your models here.
class Attachment(models.Model):
    '''
    Attachments hold an id reference to the Civi they
    are associated with. As well as a file path to an image
    or video

    ! This is a big security issue at the moment
        the arbitray upload of files needs to have
        precautions in our server set up when that
        happens, as well as in our frontend/backend
        checking.
    '''
    objects = AttachmentManager()
    civi = models.ForeignKey('Civi')
    attachment = models.FileField()

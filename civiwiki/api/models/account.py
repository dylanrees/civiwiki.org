from __future__ import unicode_literals
from django.db import models
import datetime
from django.contrib.auth.models import User
from django.contrib.postgres.fields import ArrayField

# Create your models here.
class Account(models.Model):
    '''
    Holds meta information about an Account, not used to login.
    '''
    objects = models.Manager()
    user = models.ForeignKey(User, on_delete=models.CASCADE, null=True)
    first_name = models.CharField(max_length=63, default='')
    last_name = models.CharField(max_length=63, default='')
    email = models.CharField(max_length=63, unique=True)
    last_login = models.DateTimeField(auto_now=True)
    about_me = models.CharField(max_length=511, default='')
    valid = models.BooleanField(default=False)
    profile_image = models.CharField(max_length=255)
    cover_image = models.CharField(max_length=255)
    statistics = models.TextField(default='No statistics at this time.')
    civi_pins = ArrayField(models.CharField(max_length=127, null=True), default=[], blank=True)
    civi_history = ArrayField(models.CharField(max_length=127, null=True), size=10, default=[], blank=True)
    friend_list = ArrayField(models.CharField(max_length=127, null=True), default=[], blank=True)
    award_list = ArrayField(models.CharField(max_length=127, null=True), default=[], blank=True)

    def retrieve(self, user):
        return self.find(user=user)[0]

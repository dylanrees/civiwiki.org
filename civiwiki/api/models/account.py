from __future__ import unicode_literals
from django.db import models
import json
import datetime
from django.contrib.auth.models import User
from django.contrib.postgres.fields import ArrayField
from civi import Civi

# Create your models here.
class AccountManager(models.Manager):

    def summarize(self, account):
        return {
            "first_name": account.first_name,
            "last_name": account.last_name,
            "profile_image": account.profile_image,
            "id": account.id
        }

    def serialize(self, account, filter=None):
        data = {
            "username": account.user.username,
            "first_name": account.first_name,
            "last_name": account.last_name,
            "email": account.email,
            "last_login": str(account.last_login),
            "about_me": account.about_me,
            "valid": account.valid,
            "profile_image": account.profile_image,
            "cover_image": account.cover_image,
            "statistics": account.statistics,
            "interests": account.interests,
            "pins": [{'id':c.id, 'title':c.title} for c in Civi.objects.filter(pk__in=account.civi_pins)],
            "history": [{'id':c.id, 'title':c.title} for c in Civi.objects.filter(pk__in=account.civi_history)],
            "friend_requests": [{'name': a.user.username, 'profile_image': a.profile_image, 'id': a.id} for a in self.filter(pk__in=account.friend_requests)],
            "awards": [award for a in account.award_list],
            "zip_code": account.zip_code,
            "country": account.country,
            "state": account.state,
            "city": account.city,
            "country": account.country,
            "address1": account.address1,
            "address2": account.address2,
            "groups": [{'name':group.title, 'id':group.id} for group in account.groups.all()],
            "friends": [{'name': a.user.username, 'profile_image': a.profile_image, 'id': a.id} for a in account.friends.all()]
        }
        if filter and filter in data:
            return json.dumps({filter: data[filter]})
        return json.dumps(data)

    def getObjects(self, account, attribute):
        if attribute == "friends":
            return [f for f in account.friends.all()]
        elif attribute == "groups":
            return [p for p in account.groups.all()]
        elif attribute == "friend_requests":
            return [f for f in account.objects.filter(pk_in=account.friend_requests)]
        elif attribute == "history":
            return [c for c in Civi.objects.filter(pk__in=account.civi_history)]
        elif attribute == "pins":
            return [c for c in Civi.objects.filter(pk__in=account.civi_pins)]
        else:
            return False

    def retrieve(self, user):
        return self.find(user=user)[0]

class Account(models.Model):
    '''
    Holds meta information about an Account, not used to login.
    '''
    objects = AccountManager()
    user = models.ForeignKey(User, on_delete=models.CASCADE, null=True)
    first_name = models.CharField(max_length=63, default='')
    last_name = models.CharField(max_length=63, default='')
    email = models.CharField(max_length=63, unique=True)
    last_login = models.DateTimeField(auto_now=True)
    about_me = models.CharField(max_length=511, default='', null=True)
    valid = models.BooleanField(default=False)
    profile_image = models.CharField(max_length=255, null=True)
    cover_image = models.CharField(max_length=255, null=True)
    statistics = models.TextField(default='No statistics at this time.')
    interests = ArrayField(models.CharField(max_length=127, null=True), default=[], blank=True)
    civi_pins = ArrayField(models.CharField(max_length=127, null=True), default=[], blank=True)
    civi_history = ArrayField(models.CharField(max_length=127, null=True), size=10, default=[], blank=True)
    friend_requests = ArrayField(models.CharField(max_length=127, null=True), default=[], blank=True)
    award_list = ArrayField(models.CharField(max_length=127, null=True), default=[], blank=True)
    zip_code = models.CharField(max_length=6, null=True)
    country = models.CharField(max_length=46, null=True)
    state = models.CharField(max_length=63, null=True)
    city = models.CharField(max_length=63, null=True)
    address1 = models.CharField(max_length=255, null=True)
    address2 = models.CharField(max_length=255, null=True)
    groups = models.ManyToManyField('Group', related_name='user_groups')
    friends = models.ManyToManyField('Account', related_name='friended_account')

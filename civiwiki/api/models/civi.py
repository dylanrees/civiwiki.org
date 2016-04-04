from __future__ import unicode_literals
from django.db import models
from hashtag import Hashtag
from django.contrib.postgres.fields import ArrayField

# Create your models here.
class Civi(models.Model):
    '''
    This is the model schema for the primary object in
    the application. Hold an id field and does not hold
    references to other objects. Maybe not the fastest
    implementation but it simplifies things such as searching.
    '''
    objects = models.Manager()
    group = models.ForeignKey('Group', default=None, null=True)
    creator = models.ForeignKey('Account', default=None, null=True)
    category = models.ForeignKey('Category', default=None, null=True)
    topic = models.ForeignKey('Topic', default=None, null=True)
    hashtags = models.ManyToManyField(Hashtag)

    title = models.CharField(max_length=63, default='')
    body = models.TextField(max_length=4095)

    votes_negative2 = models.IntegerField(default=0, null=True)
    votes_negative1 = models.IntegerField(default=0, null=True)
    votes_neutral = models.IntegerField(default=0, null=True)
    votes_positive1 = models.IntegerField(default=0, null=True)
    votes_positive2 = models.IntegerField(default=0, null=True)

    visits = models.IntegerField(default=0, null=True)
    type = models.CharField(max_length=2, default='I')#Possible values of I, C, or S for
    #issue, cause, and solution
    reference = ArrayField(models.CharField(max_length=127, null=True), default=[], blank=True)
    at = ArrayField(models.CharField(max_length=127, null=True), default=[], blank=True)
    and_negative = ArrayField(models.CharField(max_length=127, null=True), default=[], blank=True)
    and_positive = ArrayField(models.CharField(max_length=127, null=True), default=[], blank=True)

    def string(self):
        result = {
            "title": self.title,
            "body": self.body,
            "author": self.author.title,
            "visits": self.visits,
            "topic": self.topic.topic,
            "type": self.type,
            "id": self.id,
            "REF": self.reference_id,
            "AT": self.at_id,
            "AND_NEGATIVE": self.and_negative_id,
            "AND_POSITIVE": self.and_positive_id
	    }
        return result

    NEG2_WEIGHT = 2
    NEG1_WEIGHT = 1
    NEUTRAL_WEIGHT = 0
    POS1_WEIGHT = 1
    POS2_WEIGHT = 2
    SCALE_POLARITY = 2

    RANK_CUTOFF = -1

    def calcPolarity(self):
        '''
        :param civi: Calculates polarity of the inputted civi
        :return: polarity score
        '''
        score = self.votes_negative2 * self.NEG2_WEIGHT + self.votes_negative1 * self.NEG1_WEIGHT
        score += self.votes_positive1 * self.POS1_WEIGHT + self.votes_positive2 * self.POS2_WEIGHT
        score /= self.visits*1.0
        score /= self.SCALE_POLARITY #Scaling polarity so it is a value between 0 and 1 rather than 0 and 2
        return score


    def aveVote(self):
        '''
        Returns average vote of civi
        :param civi:
        :return:
        '''
        ave = self.votes_negative1 + self.votes_negative2 + self.votes_positive2 + self.votes_positive1
        ave /= self.visits
        return ave

    # def topNCivis(civis, N):
    #     '''
    #     Returns the top ranked N civis that are passed in
    #     :param civis:
    #     :return:
    #     '''
    #     # averages=aveVotes(civis)
    #     # for thing in averages:
    #     # 	if thing[ave] < -1.0:

    def rank(self):
        '''
        Ranks civis on a 0 to 1 scale based on polarity score,
        sets rank of civis with average votes to 0 (not polar)
        :return:
        '''
        result = self.calcPolarity()
        if self.aveVote() <= self.RANK_CUTOFF:
            result = 0.0
        return result

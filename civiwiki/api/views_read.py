from django.shortcuts import render
from django.http import JsonResponse, HttpResponseBadRequest
from django.db.models import Q
from models import Account, Topic, Attachment, Category, Civi, Comment, Hashtag
import sys, json, random, hashlib


# Create your views here.
def topTen(request):
	'''
		Given an topic ID, returns the top ten Civis of type Issue
		(the chain heads)
	'''
	topic_id = request.POST.get('id', 1)
	result = [Civi.objects.summarize(c) for c in Civi.objects.filter(topic_id=int(topic_id), type='I')]

	if len(result) > 10:
		del result[10:]

	return JsonResponse({"result":result})

def getCategories(request):
	'''
		Returns to user list of all Categories
	'''
	result = [{'id': c.id, 'name': c.name} for c in Category.objects.all()]
	return JsonResponse({"result":result})

def getTopics(request):
	'''
		Takes in a category ID, returns a list of results
	'''
	category_id = request.POST.get('id', '')
	result = [{'id':a.id, 'topic': a.topic, 'bill': a.bill} for a in Topic.objects.filter(category_id=int(category_id))]

	return JsonResponse({"result":result})

def getUser(request):
	try:
		id = request.POST.get("user_id", False)
		result = [{'id':a.id,
					'about_me': a.about_me,
					'last_name':a.last_name,
				   	'first_name':a.first_name,
					'email':a.email,
					'cover': a.cover_image,
					'profile': a.profile_image,
					'statistics': a.statistics,
					'friend_requests': [Account.objects.summarize(tmp) for tmp in Account.objects.filter(id__in=a.friend_requests)],
					'friends': [Account.objects.summarize(tmp) for tmp in a.friends.all()],
					'history': a.civi_history,
					'pinned': a.civi_pins,
					'awards': a.award_list,
					'interests': a.interests,
					'groups': [p.id for p in a.groups.all()]
					} for a in Account.objects.filter(id=id)]
		return JsonResponse({"result":result})
	except Exception as e:
		return HttpResponseBadRequest(reason=str(e))

def getIdByUsername(request):
	'''
	takes in username and responds with an accountid

	image fields are going to be urls in which you can access as base.com/media/<image_url>

	:param request: with username
	:return: user object
	'''
	try:
		username = request.POST.get("username", False)
		id = Account.objects.get(user__username=username).id
		return JsonResponse({"result": id})
	except Exception as e:
		return HttpResponseBadRequest(reason="No user with that name exists.")

def getCivi(request):
	id = request.POST.get('id', -1)
	c = Civi.objects.filter(id=id)
	if len(c):
		if c[0].type == 'I':
			return JsonResponse({'result':getCiviChain(c[0])})
		else:
			return JsonResponse({'result': c[0].string()})

	else:
		return JsonResponse({'result': 'No Civi Returned matching that ID'})

def getBlock(request):
	topic_id = request.POST.get('topic_id', -1)
	civi = Civi.objects.filter(topic_id=topic_id, type='I')
	c_tuples = sorted([
		(c,((2 * c.votes_positive2 + c.votes_positive1) - (2 * c.votes_negative2 + c.votes_negative1))/c.visits) for c in civi
	], key=lambda c: c[1])


	if len(c_tuples) > 1:
		del c_tuples[1:]

	it = c_tuples[0][0]
	result = []
	result.append(it.string())

	if it.AT != None:
		result.append(it.AT.string())
		if it.AT.AND_POSITIVE != None: result.append(it.AT.AND_POSITIVE.string())
		if it.AT.AND_NEGATIVE != None: result.append(it.AT.AND_NEGATIVE.string())
		if it.AT.AT != None:
			result.append(it.AT.AT.string())
			if it.AT.AT.AND_POSITIVE != None: result.append(it.AT.AT.AND_POSITIVE.string())
			if it.AT.AT.AND_NEGATIVE != None: result.append(it.AT.AT.AND_NEGATIVE.string())


	if it.AND_POSITIVE != None: result.append(it.AND_POSITIVE.string())
	if it.AND_NEGATIVE != None: result.append(it.AND_NEGATIVE.string())



	return JsonResponse({"result":result})

def getCiviChain(it):

	result = []
	result.append(it.string())

	if it.AT != None:
		result.append(it.AT.string())
		if it.AT.AND_POSITIVE != None: result.append(it.AT.AND_POSITIVE.string())
		if it.AT.AND_NEGATIVE != None: result.append(it.AT.AND_NEGATIVE.string())
		if it.AT.AT != None:
			result.append(it.AT.AT.string())
			if it.AT.AT.AND_POSITIVE != None: result.append(it.AT.AT.AND_POSITIVE.string())
			if it.AT.AT.AND_NEGATIVE != None: result.append(it.AT.AT.AND_NEGATIVE.string())


	if it.AND_POSITIVE != None: result.append(it.AND_POSITIVE.string())
	if it.AND_NEGATIVE != None: result.append(it.AND_NEGATIVE.string())

	return result

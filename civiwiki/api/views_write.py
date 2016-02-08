from django.shortcuts import render
from django.http import JsonResponse
from django.db.models import Q
from models import Account, Article, Attachment, Category, Civi, Comment, Hashtag
import sys, json, pdb, random, hashlib

def addCivi(request):
	'''
	takes in civi info and adds it to the database
	:param request:
	:return:
	'''
	civi = Civi()
	civi.id = Civi.objects.all().order_by("-id")[0].id + 1

	civi.author_id = request.POST.get('author_id', '')
	civi.article_id = request.POST.get('article_id', '')


	civi.title = request.POST.get('title', '')
	civi.body = request.POST.get('body', '')

	civi.type = request.POST.get('type', '')

	civi.REFERENCE_id = request.POST.get('reference_id', '')
	civi.AT_id = request.POST.get('at_id', '')
	civi.AND_NEGATIVE_id = request.POST.get('and_negative_id', '')
	civi.AND_POSITIVE_id = request.POST.get('and_positive_id', '')

	civi.save()

	hashtags = request.POST.get('hashtags', '')
	split = [x.strip() for x in hashtags.split(',')]
	for str in split:
		if len(Hashtag.objects.filter(title=str)) == 0:
			hash = Hashtag(title=str)
			hash.save()
		else:
			hash = Hashtag.objects.filter(title=str)[0]#get the first element

		civi.hashtags.add(hash.id)

	civi.save()


	return JsonResponse({'result': 'success'})

def reportVote(request):
	'''
	reports a users vote on a given civi
	:param request:
	:return:
	'''
	civi_id = int(request.POST.get('civi_id', ''))
	vote = int(request.POST.get('vote', ''))
	civi = Civi.objects.get(id=civi_id)
	civi.visits += 1
	if(vote == -2):
		civi.votes_negative2 += 1
	elif(vote == -1):
		civi.votes_negative1 += 1
	elif(vote == 0):
		civi.votes_neutral += 1
	elif(vote == 1):
		civi.votes_positive1 += 1
	elif(vote == 2):
		civi.votes_positive2 += 1
	else:
		return JsonResponse({'result':'failure: invalid vote'})

	civi.save()

	return JsonResponse({'result': 'success'})

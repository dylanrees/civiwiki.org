from django.shortcuts import render
from django.conf import settings
from django.http import JsonResponse, HttpResponse
from django.db.models import Q
from models import Account, Article, Attachment, Category, Civi, Comment, Hashtag, Page
import os, sys, json, pdb, random, hashlib

def addPage(request):

	account = Account.objects.get(user=request.user.id)
	pi = request.FILES.get('profile_image', False)
	ci = request.FILES.get('cover_image', False)
	if pi:
		url = "{media}/{type}/{username}.png".format(media=settings.MEDIA_ROOT, type='profile',username=account.user.username)
		with open( url , 'wb+') as destination:
			for chunk in pi.chunks():
				destination.write(chunk)
		profile_image = "{media}/{type}/{username}.png".format(media=settings.MEDIA_URL, type='profile',username=account.user.username)
	else:
		profile_image = "{media}/{type}/{username}.png".format(media=settings.MEDIA_URL, type='profile',username='generic')


	if ci:
		url = "{media}/{type}/{username}.png".format(media=settings.MEDIA_ROOT, type='cover',username=account.user.username)
		with open( url , 'wb+') as destination:
			for chunk in ci.chunks():
				destination.write(chunk)

		cover_image = "{media}/{type}/{username}.png".format(media=settings.MEDIA_URL, type='cover',username=account.user.username)
	else:
		cover_image = "{media}/{type}/{username}.png".format(media=settings.MEDIA_URL, type='cover',username='generic')



	try:
		page = Page(owner=account,
					title=request.POST.get('title',''),
					body=request.POST.get('description',''),
					profile_image=profile_image,
					cover_image=cover_image)
		page.save()
		return HttpResponse('success', status_code=200)
	except Exception as e:
		return HttpResponse(e, status_code=500)

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

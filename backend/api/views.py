from django.shortcuts import render
from django.http import JsonResponse
from models import Account, Article, Attachment, Category, Civi, Comment, Hashtag
import json

# Create your views here.
def foo(request):
	'''
		Given an article ID, returns the top ten Civis of type Issue
		(the chain heads)
	'''
	article_id = 6 #TODO: Link this up to a post request
	civi = Civi.objects.filter(article_id=article_id, type='I')
	c_tuples = sorted([
		(c,((2 * c.votes_positive2 + c.votes_positive1) - (2 * c.votes_negative2 + c.votes_negative1))/c.visits) for c in civi
	], key=lambda c: c[1])

	result = [{
		"title": c[0].title,
		"body": c[0].body,
		"author": c[0].author.name,
		"visits": c[0].visits,
		"article": c[0].article.topic
	} for c in c_tuples]

	if len(result) > 10:
		del result[10:]

	return JsonResponse({"result":result})

def getCategories(request):
	'''
		Returns to user list of all Categories
	'''
	result = [{'id': c.id, 'name': c.name} for c in Category.objects.all()]
	return JsonResponse({"result":result})

def getArticles(request):
	'''
		Takes in a category ID, returns a list of results
	'''
	category_id = 1
	result = [{'id':a.id, 'topic': a.topic, 'bill': a.bill} for a in Article.objects.filter(category_id=category_id)]
	return JsonResponse({"result":result})

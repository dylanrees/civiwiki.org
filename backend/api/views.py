from django.shortcuts import render
from django.http import JsonResponse
from models import Account, Article, Attachment, Category, Civi, Comment, Hashtag

# Create your views here.
def foo(request):
	civi = Civi.objects.filter(author_id=1).first()

	return JsonResponse({'title': civi.title,
							'body': civi.body,
							'author': civi.author.name,
							'totalVisits': civi.visits,
							'article': civi.article.topic})
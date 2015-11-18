from django.shortcuts import render
from django.http import JsonResponse
from models import Account, Article, Attachment, Category, Civi, Comment, Hashtag

# Create your views here.
def foo(request):
	civiTitle = request.POST['title'] if 'title' in request.POST else 'TestCivi1'
	civi = Civi.objects.get(title=civiTitle)



	return JsonResponse({'title': civi.title,
							'body': civi.body,
							'author': civi.author.name,
							'totalVisits': civi.visits,
							'article': civi.article.topic})
from django.http import HttpResponseRedirect
from django.template.response import TemplateResponse
from django.contrib.auth.decorators import login_required
from models import Category, Account
import views_write
import json

def login_view(request):
	if request.user.is_authenticated():
		if request.user.is_active:
			return HttpResponseRedirect('/')
		else:
			return HttpResponseRedirect('/beta')

	return TemplateResponse(request, 'login.html', {})

def beta_view(request):
	return TemplateResponse(request, 'beta_blocker.html', {})

@login_required
def home_view(request):

	if not request.user.is_active:
		return HttpResponseRedirect('/beta')
	
	return TemplateResponse(request, 'home.html', {})

@login_required
def create_group(request):

	if not request.user.is_active:
		return HttpResponseRedirect('/beta')

	return TemplateResponse(request, 'newgroup.html', {})


def does_not_exist(request):
	return TemplateResponse(request, '404.html', {})

def support_us_view(request):
	return TemplateResponse(request, 'supportus.html', {})

def dbview(request):
	result = [{'id': c.id, 'name': c.name} for c in Category.objects.all()]

	return TemplateResponse(request, 'dbview.html', {'categories': json.dumps(result)})

def about_view(request):
	return TemplateResponse(request, 'about.html', {})

def account_home(request):
	user_data = Account.objects.filter(user_id=request.user.id)[0].__dict__
	# dummy = "dummy"
	# views_write.createCivi("my civi", "a a", "prototyping", "software development", "my prototyping", "sup man", "some type")
	views_write.createCivi(request)
	views_write.pinCivi(request)
	return TemplateResponse(request, 'account_home.html', {'user_data': json.dumps({k: str(v) for k, v in user_data.items()})})

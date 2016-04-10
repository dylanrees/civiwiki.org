from django.http import HttpResponseRedirect
from django.template.response import TemplateResponse
from django.contrib.auth.decorators import login_required
from models import Category, Account
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

	return TemplateResponse(request, 'dbview.html', {'results': json.dumps(result)})

def about_view(request):
	return TemplateResponse(request, 'about.html', {})

@login_required
def account_home(request):
	acc = Account.objects.get(user_id=request.user.id)
	return TemplateResponse(request, 'account_home.html', {'results': json.dumps(Account.objects.serialize(acc))})

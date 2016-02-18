from django.template.response import TemplateResponse
from django.contrib.auth.decorators import login_required

def login_view(request):
	return TemplateResponse(request, 'login.html', {})

@login_required
def home_view(request):
	return TemplateResponse(request, 'home.html', {})

@login_required
def create_page(request):
	return TemplateResponse(request, 'newpage.html', {})

def does_not_exist(request):
	return TemplateResponse(request, '404.html', {})

def support_us_view(request):
	return TemplateResponse(request, 'supportus.html', {})

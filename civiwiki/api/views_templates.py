from django.template.response import TemplateResponse
from django.contrib.auth.decorators import login_required

def login_view(request):
	return TemplateResponse(request, 'login.html', {})

def database_view(request):
	return TemplateResponse(request, 'database.html', {})

@login_required
def home_view(request):
	return TemplateResponse(request, 'home.html', {})

@login_required
def create_page(request):
	return TemplateResponse(request, 'newpage.html', {})

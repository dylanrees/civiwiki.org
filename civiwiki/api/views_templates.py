from django.template.response import TemplateResponse
from django.contrib.auth.decorators import login_required

def login_view(request):
	return TemplateResponse(request, 'login.html', {})

@login_required
def home_view(request):
	return TemplateResponse(request, 'home.html', {})

def privacyPolicy(request):	
	return TemplateResponse(request, 'privacy_policy.html', {})

def userAgreement(request):
	return TemplateResponse(request, 'user_agreement.html', {})

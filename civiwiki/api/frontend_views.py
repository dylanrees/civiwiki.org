from django.template.response import TemplateResponse
from django.contrib.auth.decorators import login_required

def login_view(request):
	return TemplateResponse(request, 'login.html', {})

@login_required
def blah_view(request):
	return TemplateResponse(request, 'blah.html', {})

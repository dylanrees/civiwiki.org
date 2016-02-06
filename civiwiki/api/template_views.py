from django.template.response import TemplateResponse


def hello_view(request):
	return TemplateResponse(request, 'hello.html', {})
def support_us_view(request):
	return TemplateResponse(request, 'supportus.html', {})
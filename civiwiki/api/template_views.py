from django.template.response import TemplateResponse


def hello_view(request):
	return TemplateResponse(request, 'hello.html', {})

from django.template.response import TemplateResponse


def database_view(request):
	return TemplateResponse(request, 'database.html', {})

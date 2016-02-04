from django.contrib.auth.models import User
from models import Account

def login(request):
	'''
	returns secret key from inserted username and password
	'''
	username = request.POST.get('username', '')
	password = request.POST.get('password', '')
	user = authenticate(username=username, password=password)
	if user is not None:
		if user.is_active:
			login(request, user)
			# Redirect to a success page.
		else:
			# Return a 'disabled account' error message
			return JsonResponse({'status_code': 400, 'error': 'inactive account'})
	else:
	# Return an 'invalid login' error message.
		return JsonResponse({'status_code': 400, 'error': 'invalid username / password combination'})

def register(request):
	username = request.POST.get('username', '')
	password = request.POST.get('password', '')
	email = request.POST.get('email', '')
	first_name = request.POST.get('first_name', '')
	last_name = request.POST.get('last_name', '')
	try:
		user = User.objects.create_user(username, email, password)
		account = Account(user=user, email=email, first_name=first_name, last_name=last_name)
		account.save()

		login(request, user)
		return JsonResponse({'status_code': 200})
	except:
		return JsonResponse({'status_code': 500})

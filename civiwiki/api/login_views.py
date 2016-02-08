from django.contrib.auth.models import User
from models import Account
from django.http import JsonResponse, HttpResponseRedirect
from django.shortcuts import redirect
from django.contrib.auth import authenticate, logout, login

def cw_login(request):
	'''
	returns secret key from inserted username and password
	'''
	username = request.POST.get('username', '')
	password = request.POST.get('password', '')
	user = authenticate(username=username, password=password)
	if user is not None:
		if user.is_active:
			u = login(request, user)

			# Redirect to a success page.
			return JsonResponse({'status_code': 200})
		else:
			# Return a 'disabled account' error message
			return JsonResponse({'status_code': 400, 'error': 'inactive account'})
	else:
	# Return an 'invalid login' error message.
		return JsonResponse({'status_code': 400, 'error': 'invalid username / password combination'})

def cw_logout(request):
	logout(request)
	return HttpResponseRedirect('/')

def cw_register(request):
	username = request.POST.get('username', '')
	password = request.POST.get('password', '')
	email = request.POST.get('email', '')
	first_name = request.POST.get('first_name', '')
	last_name = request.POST.get('last_name', '')
	try:
		user = User.objects.create_user(username, email, password)
		account = Account(user=user, email=email, first_name=first_name, last_name=last_name)
		account.save()
		print account.first_name, account.last_name, account.email
		login(request, user)
		return JsonResponse({'status_code': 200})
	except Exception as e:
		print e
		return JsonResponse({'status_code': 500})

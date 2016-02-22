from django.contrib.auth.models import User
from django.db import IntegrityError
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
	remember = request.POST.get('remember', 'false')

	user = authenticate(username=username, password=password)
	if user is not None:
		if user.is_active:
			if remember == 'false':
				request.session.set_expiry(0)

			u = login(request, user)

			# Redirect to a success page.
			return JsonResponse({'status_code': 200})
		else:
			# Return a 'disabled account' error message
			return JsonResponse({'status_code': 401, 'error': 'inactive account'})
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
	email_unique = not User.objects.filter(email=email).exists()
	user_unique = not User.objects.filter(username=username).exists()
	if email_unique and user_unique:
		User.objects.create_user(username, email, password)
		user = authenticate(username=username, password=password)
		user.is_active = False
		user.save()
		account = Account(user=user, email=email, first_name=first_name, last_name=last_name)
		account.save()
		login(request, user)
		return JsonResponse({'status_code': 200})
	else:
		conflict = ''
		if not user_unique:
			conflict = 'Sorry, this username is taken.'
		elif not email_unique:
			conflict = 'An account exists for this email address.'
		return JsonResponse({'status_code': 400, 'message': conflict})

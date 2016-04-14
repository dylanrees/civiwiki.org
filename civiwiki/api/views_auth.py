from django.contrib.auth.models import User
from django.db import IntegrityError
from models import Account
from django.http import JsonResponse, HttpResponse, HttpResponseServerError, HttpResponseRedirect, HttpResponseBadRequest
from django.shortcuts import redirect
from django.contrib.auth import authenticate, logout, login
from django.config import settings
from django.core.mail import send_mail
from utils.custom_decorators import require_post_params
from utils.string_templates import VALIDATION_EMAIL
import datetime, hashlib, random, os

@require_post_params(params=['username', 'password'])
def cw_login(request):
	'''
	USAGE:

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
			return HttpResponse()
		else:
			# Return a 'disabled account' error message
			return HttpResponseServerError(reason='inactive account')
	else:
	# Return an 'invalid login' error message.
		return HttpResponseBadRequest(reason='invalid username / password combination')

def cw_logout(request):
	logout(request)
	return HttpResponseRedirect('/')

@require_post_params(params=['username', 'password', 'email', 'first_name', 'last_name', 'zip'])
def cw_register(request):
	# TODO: This should work but hasn't been super tested. If something goes wrong
	# don't assume this isn't the root of the problem.

	username = request.POST.get('username', '')
	password = request.POST.get('password', '')
	email = request.POST.get('email', '')
	first_name = request.POST.get('first_name', '')
	last_name = request.POST.get('last_name', '')
	zip_code = request.POST.get('zip', '')
	if User.objects.filter(email=email).exists():
		return HttpResponseBadRequest(reason='An account exists for this email address.')

	if User.objects.filter(username=username).exists():
		return HttpResponseBadRequest(reason='Sorry, this username is taken.')

	try:
		User.objects.create_user(username, email, password)
		user = authenticate(username=username, password=password)
		user.is_active = False
		user.save()
	except Exception as e:
		return HttpResponseServerError(reason=str(e))

	try:
		account = Account(user=user, email=email, first_name=first_name, last_name=last_name, zip_code=zip_code)
		account.save()
		login(request, user)
	except Exception as e:
		user.delete()
		return HttpResponseServerError(reason=str(e))

	send_validation_email(account)
	return HttpResponse()

def cw_validate(request, activation_key):
	# TODO: This should work but hasn't been super tested. If something goes wrong
	# don't assume this isn't the root of the problem.
	if request.user.is_authenticated():
		HttpResponseRedirect("/account")

	try:
		account = Account.objects.get(activation_key=activation_key)
	except Account.DoesNotExist as e:
		HttpResponseBadRequest(reason=str(e))

	account.user.is_active = True
	account.user.save()
	login(request, account.user)
	return HttpResponseRedirect("/account")

def send_validation_email(account):
	# TODO: Ensure the email is formatted properly, maybe do this by creating a
	# view that just sends an email without going through the registration process
	# in order to save some time.
	# REMEMBER: if you call this view from a url, ensure to add the parameter request first,
	# every function called from the url dispatcher recieves a request object.

	account = Account.objects.first()
	salt = hashlib.sha1(str(random.random())).hexdigest()[:5]
	activation_key = hashlib.sha1(salt+account.user.email).hexdigest()
	url = settings.BASE_URL
	email_subject = 'CiviWiki: Account Confirmation'
	email_body = VALIDATION_EMAIL.format(name=account.user.username, url=url, activation_key=activation_key)
	send_mail(email_subject, "", 'noreply@civiwiki.org', ['calliet.d@gmail.com'], html_message=email_body)
	return HttpResponse()

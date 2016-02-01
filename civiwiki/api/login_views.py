from models import Account

def login(request):
	'''
	returns secret key from inserted username and password
	'''
	username = request.POST.get('username', '')
	password = request.POST.get('password', '')
	account = {}
	try:
		account = Account.objects.get(username=username, password=password)
	except Exception as e:
		return JsonResponse({'status': 400, 'result': 'User not found'})

	key = account.secret_key
	return JsonResponse({'status_code': 200, 'result': key})

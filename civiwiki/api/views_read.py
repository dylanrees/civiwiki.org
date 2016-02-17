from django.shortcuts import render
from django.http import JsonResponse
from django.db.models import Q
from models import Account, Article, Attachment, Category, Civi, Comment, Hashtag
import sys, json, pdb, random, hashlib


# Create your views here.
def topTen(request):
	'''
		Given an article ID, returns the top ten Civis of type Issue
		(the chain heads)
	'''
	article_id = request.POST.get('id', 1)
	civi = Civi.objects.filter(article_id=article_id, type='I')
	c_tuples = sorted([
		(c, c.rank()) for c in civi
	], key=lambda c: c[1], reverse=True)

	print c_tuples

	result = [{
		"title": c[0].title,
		"body": c[0].body,
		"author": c[0].author.username,
		"visits": c[0].visits,
		"article": c[0].article.topic,
		"type": c[0].type,
		"id": c[0].id
	} for c in c_tuples]

	if len(result) > 10:
		del result[10:]

	return JsonResponse({"result":result})

def getCategories(request):
	'''
		Returns to user list of all Categories
	'''
	result = [{'id': c.id, 'name': c.name} for c in Category.objects.all()]
	return JsonResponse({"result":result})

def getArticles(request):
	'''
		Takes in a category ID, returns a list of results
	'''
	category_id = request.POST.get('id', '')
	result = [{'id':a.id, 'topic': a.topic, 'bill': a.bill} for a in Article.objects.filter(category_id=category_id)]
	return JsonResponse({"result":result})

def getUser(request):
	'''
	takes in username and responds with all user fields

	image fields are going to be urls in which you can access as base.com/media/<image_url>

	:param request: with username
	:return: user object
	'''
	username=request.POST.get('username', '')
	result = [{'id':a.id,
				'username':a.username,
				'password': a.password,
				'about_me': a.about_me,
				'last_name':a.last_name,
			   	'first_name':a.first_name,
				'email':a.email,
				'cover': a.cover_image.url,
				'profile': a.profile_image.url,
				'statistics': a.statistics,
				'friends': a.friends,
				'history': a.history,
				'awards': a.awards
				} for a in Account.objects.filter(username=username)]
	return JsonResponse({"result":result})

def addUser(request):
	'''
	takes in user information and adds it to the database
	upload images as files in your post request
	:param request:
	:return: nothing
	'''
	username = request.POST.get('username', '')
	password = request.POST.get('password', '')
	user = Account()
	user.first_name = request.POST.get('first_name', '')
	user.last_name = request.POST.get('last_name', '')
	user.email = request.POST.get('email', '')
	user.username = username
	user.about_me = request.POST.get('about_me', '')
	user.password = password
	user.profile_image = request.FILES.get('profile')
	user.cover_image = request.FILES.get('cover')
	#create user secret key
	m = hashlib.md5()

	user.friends = json.dumps(request.POST.get('friends', [])) #list of usernames
	user.history = json.dumps(request.POST.get('history', [])) #list of civi's visited
	user.awards = json.dumps(request.POST.get('awards', [])) #list of user awards


	m.update("{username}{password}{int}".format(username=user.username, password=password, int=random.randint(0, sys.maxint)))
	secret_key = m.hexdigest()
	user.secret_key= secret_key
	user.save()
	try:
		user.save()
	except Exception as e:
		return JsonResponse({'result': e})

	return JsonResponse({'status': 200, 'result': user.secret_key})


def linkCivis(request):

	num_civis = Civi.objects.count()
	num_chains = Civi.objects.filter(type="I").count()
	print("There are {A} civis in this database, from it I can create about {I} chains...").format(A=num_civis, I=num_chains)


	Articles = Article.objects.all()

	for a in Articles:
		Civi.objects.filter(article=a).update(REFERENCE=None, AT=None, AND_POSITIVE=None, AND_NEGATIVE=None)


		Issues = Civi.objects.filter(type="I", article=a).order_by('votes_positive2')
		Causes = Civi.objects.filter(type="C", article=a).order_by('votes_positive2')
		Solutions = Civi.objects.filter(type="S", article=a).order_by('votes_positive2')

		for idx in range(Issues.count()):
			i = Issues[idx]
			c = Causes.filter(author=i.author, REFERENCE__isnull=True).first() if Causes.filter(author=i.author, REFERENCE__isnull=True).count() else Causes.filter(REFERENCE__isnull=True).first()
			if c is not None:
				i.AT = c
				i.save()
				c.REFERENCE = i
				c.save()
			else:
				continue

		sol = Solutions.filter(REFERENCE__isnull=True)
		for idx in range(sol.count()):
			s = sol[idx]
			c = Causes.filter(author=s.author, AT__isnull=True).first() if Causes.filter(author=i.author, AT__isnull=True).count() else Causes.filter(AT__isnull=True).first()
			if c is not None:
				c.AT = s
				c.save()
				s.REFERENCE = c
				s.save()
			else:
				continue

		cause = Causes.filter(AT__isnull=True)
		for idx in range(cause.count()):
			c = cause[idx]
			s = Solutions.filter(author=s.author).first() if Solutions.filter(author=i.author).count() else Solutions.first()
			c.AT = s
			c.save()

		cause = Causes.filter(REFERENCE__isnull=True)
		for idx in range(cause.count()):

			chain = Causes.filter(Q(AND_POSITIVE__isnull=True) | Q(AND_NEGATIVE__isnull=True))
			c = cause[idx]
			chain_el = chain.first()

			if(random.random() > 0.5):
			    chain_el.AND_POSITIVE = c
			    chain_el.save()
			else:
			    chain_el.AND_NEGATIVE = c
			    chain_el.save()

	for c in Civi.objects.all():#assign random and_positives and and_negatives

		if c.AND_POSITIVE == None:
			c.AND_POSITIVE_id = random.randint(2,Civi.objects.count())
		if c.AND_NEGATIVE == None:
			c.AND_NEGATIVE_id = random.randint(2, Civi.objects.count())
		c.save()

	return JsonResponse({'status': 'success'})

def getBlock(request):
	article_id = request.POST.get('article_id', -1)
	civi = Civi.objects.filter(article_id=article_id, type='I')
	c_tuples = sorted([
		(c,((2 * c.votes_positive2 + c.votes_positive1) - (2 * c.votes_negative2 + c.votes_negative1))/c.visits) for c in civi
	], key=lambda c: c[1])


	if len(c_tuples) > 1:
		del c_tuples[1:]

	it = c_tuples[0][0]
	result = []
	result.append(it.string())

	if it.AT != None:
		result.append(it.AT.string())
		if it.AT.AND_POSITIVE != None: result.append(it.AT.AND_POSITIVE.string())
		if it.AT.AND_NEGATIVE != None: result.append(it.AT.AND_NEGATIVE.string())
		if it.AT.AT != None:
			result.append(it.AT.AT.string())
			if it.AT.AT.AND_POSITIVE != None: result.append(it.AT.AT.AND_POSITIVE.string())
			if it.AT.AT.AND_NEGATIVE != None: result.append(it.AT.AT.AND_NEGATIVE.string())


	if it.AND_POSITIVE != None: result.append(it.AND_POSITIVE.string())
	if it.AND_NEGATIVE != None: result.append(it.AND_NEGATIVE.string())



	return JsonResponse({"result":result})


def getCivi(request):
	id = request.POST.get('id', -1)
	c = Civi.objects.filter(id=id)
	if len(c):
		if c[0].type == 'I':
			return JsonResponse({'result':getCiviChain(c[0])})
		else:
			return JsonResponse({'result': c[0].string()})

	else:
		return JsonResponse({'result': 'No Civi Returned matching that ID'})

def getCiviChain(it):
	result = []
	result.append(it.string())

	if it.AT != None:
		result.append(it.AT.string())
		if it.AT.AND_POSITIVE != None: result.append(it.AT.AND_POSITIVE.string())
		if it.AT.AND_NEGATIVE != None: result.append(it.AT.AND_NEGATIVE.string())
		if it.AT.AT != None:
			result.append(it.AT.AT.string())
			if it.AT.AT.AND_POSITIVE != None: result.append(it.AT.AT.AND_POSITIVE.string())
			if it.AT.AT.AND_NEGATIVE != None: result.append(it.AT.AT.AND_NEGATIVE.string())


	if it.AND_POSITIVE != None: result.append(it.AND_POSITIVE.string())
	if it.AND_NEGATIVE != None: result.append(it.AND_NEGATIVE.string())

	return result

def getCiviLevel(request):
        #fetches the top 15 (with optional offset) civis linked to the requested civi's AT
        #Use to fetch relevant civis at the next level down a civi chain
        id = request.POST.get('id', 1)
        offset = request.POST.get('offset', 0) #the second argument is the default, right?
        center = Civi.objects.filter(id=id)
        if(len(center)==0 or center[0].AT==None):
                return JsonResponse({'result':[]}) #if the requested civi has no children, just quit
        result = set()
        pending = set([center.AT]) #start with the requested civi's child

        while(len(pending)>0):
                current = pending.pop() #pick an arbitrary pending civi
                result.add(current)
                if(current.AND_POSITIVE != None): #queue the adjacent civis (if any)
                        pending.add(current.AND_POSITIVE)
                if(current.AND_NEGATIVE != None):
                        pending.add(current.AND_NEGATIVE)
        if(offset+15>=len(result)): #i'm choosing 15 as the number of civis to fetch per api call
                x = -1 * min(15, len(result))
                return JsonResponse({'has_more': False, 'result':[c.string() for c in sorted(a, key=lambda x:x.rank(), reverse=True)[x:]]})
        return JsonResponse({'has_more': True, 'result':[c.string() for c in sorted(a, key=lambda x:x.rank(), reverse=True)[offset:offset+15]]})

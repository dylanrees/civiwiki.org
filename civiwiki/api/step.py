from django.http import JsonResponse
from models import Civi
import random

RANDOM_CUTOFF = .2

def stepTest(request):
	'''
	reports a users vote on a given civi
	:param request:
	:return:
	'''

    #Record the vote
	civi_id = int(request.POST.get('civi_id', ''))
	vote = int(request.POST.get('vote', ''))
	civi = Civi.objects.get(id=civi_id)
	civi.visits += 1
	if(vote == -2):
		civi.votes_negative2 += 1
	elif(vote == -1):
		civi.votes_negative1 += 1
	elif(vote == 0):
		civi.votes_neutral += 1
	elif(vote == 1):
		civi.votes_positive1 += 1
	elif(vote == 2):
		civi.votes_positive2 += 1
	else:
		return JsonResponse({'result':'failure: invalid vote'})
	civi.save()

	#Giving the user the next civis to read
	#coding the logic for Issue civis only right now
	rand = random.random()
	result=[]
	if(vote == 2):
		#User reads and positive then reads at
		if civi.AND_POSITIVE != None:
			result.append(civi.AND_POSITIVE.string)
		if civi.AT != None:
			result.append(civi.AT.string)
	elif vote == 1:
		#Read and positive with prob 1-random_cutoff and read and negative with prob random_cutoff
		if civi.AND_POSITIVE != None and civi.AND_NEGATIVE != None:
			if random < RANDOM_CUTOFF:
				result.append(civi.AND_NEGATIVE.string)
			else:
				result.append(civi.AND_POSITIVE.string)
		else:
			if civi.AND_POSITIVE != None:
				result.append(civi.AND_POSITIVE.string)
			if civi.AND_NEGATIVE != None:
				result.append(civi.AND_NEGATIVE.string)
	# elif vote == 0:
		#Send user to new civi chain/new issue civi
	elif vote == -1:
		#Read and negative with prob 1-random_cutoff and read and negative with prob random_cutoff
		if civi.AND_POSITIVE != None and civi.AND_NEGATIVE != None:
			if random < RANDOM_CUTOFF:
				result.append(civi.AND_POSITIVE.string)
			else:
				result.append(civi.AND_NEGATIVE.string)
		else:
			if civi.AND_POSITIVE != None:
				result.append(civi.AND_POSITIVE.string)
			if civi.AND_NEGATIVE != None:
				result.append(civi.AND_NEGATIVE.string)

	elif vote == -2:
		#Send user to and negative
		if civi.AND_NEGATIVE != None:
			result.append(civi.AND_NEGATIVE.string)


	return JsonResponse({'result': result})

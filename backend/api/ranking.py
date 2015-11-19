from models import Account, Article, Attachment, Category, Civi, Comment, Hashtag

NEG2_WEIGHT = 2
NEG1_WEIGHT = 1
NEUTRAL_WEIGHT = 0
POS1_WEIGHT = 1
POS2_WEIGHT = 2
SCALE_POLARITY = 2

def calcPolarities(civis):
	'''
	This method calculates the polarity scores of all the civis in the input list
	:param civis: A list of civis
	:return: a list of polarity scores corresponding to civis
	'''
	civiPolarities=[] #tuple (civi_id, polarity score)
	for civi in civis:
		civiPolarities.append((civi._check_id_field(), calcPolarity(civi)))

	return civiPolarities

def calcPolarity(civi):
	'''
	:param civi: Calculates polarity of the inputted civi
	:return: polarity score
	'''
	score=civi.votes_negative2*NEG2_WEIGHT + civi.votes_negative1*NEG1_WEIGHT
	score += civi.votes_positive1*POS1_WEIGHT + civi.votes_positive2*POS2_WEIGHT
	score /= civi.visits
	score /= SCALE_POLARITY #Scaling polarity so it is a value between 0 and 1 rather than 0 and 2
	return score

def aveScore(civi):
	'''
	Returns average vote of civi
	:param civi:
	:return:
	'''
	ave = civi.votes_negative1 + civi.votes_negative2 + civi.votes_positive2 + civi.votes_positive1
	ave /= civi.visits
	return ave
import random, math
ACCOUNTS = 0
CIVIS = 0
CATEGORIES = ["Business & Economy", "Taxes", "Civil & Human Rights", "Education", "United States Elections", "Enviornment", "Health & Welfare", "Laws & Crime", "Military & Defense", "Political & Economic Systems", "Religion", "Science & Technology", "Treaties & Agreements", "Wars & Conflicts", "Natural Disasters Prevention and Response"]

ARTICLES = []
ARTICLES.extend([("Fiscal Cliff",0), ("Labor",0), ("Jobs",0), ("Minimum Wage", 0), ("Offshoring", 0), ("Unemployment Rate", 0), ("Labor Unions", 0), ("Right to work ", 0), ("Macroeconomics", 0), ("Free Trade", 0)])
ARTICLES.extend([("Monetary Policy", 0), ("Federal Reserve", 0), ("Gold Standard", 0), ("Inflation & Deflation", 0)])
ARTICLES.extend([("Capital Gains Tax", 1), ("Car Taxes", 1), ("Corporate Taxes", 1), ("Estate Tax", 1), ("Flat Tax", 1), ("Income Tax", 1), ("Lottery", 1), ("Payroll Taxes", 1), ("Personal Tax Deductions", 1), ("Property Taxes", 1), ("Sales Tax", 1)])
ARTICLES.extend([("Tax Brackets", 1), ("Tax Forms", 1), ("Tax Preparation", 1), ("Tax Returns", 1), ("Tax Shelters", 1), ("U.S. Debt & Deficits", 1), ("Debt Ceiling", 1), ("Regulation", 1), ("Financial Regulation", 1)])
ARTICLES.extend([("Child Prostitution is Rape, Not Prostitution ", 2), ("Individual Rights & Freedoms", 2), ("Freedom of Press", 2), ("Freedom of Religion", 2), ("Freedom of Speech", 2), ("Gay Rights", 2), ("Right to Privacy", 2), ("Women''s Rights", 2), ("Abortion", 2), ("Discrimination", 2)])
ARTICLES.extend([("Affirmative Action", 2), ("Gambling", 2), ("Online Gambling", 2), ("Gun Control", 2), ("Human Trafficking", 2), ("Legalization of Drugs", 2), ("Legalizing Marijuana", 2), ("Medical Marijuana", 2), ("Racial Politics", 2), ("Racism", 2), ("Torture", 2)])
ARTICLES.extend([("Abstinence Only Education", 3), ("Charter Schools", 3), ("Head Start Program", 3), ("Higher Education", 3), ("Homeschooling", 3), ("Pell Grants", 3), ("Sex Education", 3), ("Teacher Tenure ", 3), ("Teachers Pay", 3)])
ARTICLES.extend([("Voter ID laws ", 4), ("Redistricting ", 4), ("Democratic Engagement (In progress) ", 4)])
ARTICLES.extend([("Endangered Species", 5), ("Energy Independence", 5), ("Fossil Fuels", 5), ("Fracking", 5), ("Gasoline Prices", 5), ("Offshore Drilling", 5), ("Nuclear Energy", 5), ("Renewable Energy", 5), ("Global Warming (in Progress) ", 5), ("Recycling", 5), ("Government Shutdown", 5)])
ARTICLES.extend([("Planned Parenthood Fund (In progress) ", 6), ("Government Benefits", 6), ("Disability Benefits", 6), ("FHA Loans", 6), ("Food Stamp Program", 6), ("Government Health Benefits", 6), ("Children''s Health Insurance Programing", 6), ("Medicare & Medicaid", 6), ("Student Loans", 6), ("Housing Assistance", 6)])
ARTICLES.extend([("Public Housing", 6), ("Section 8 Housing", 6), ("Social Security", 6), ("Unemployment Benefits", 6), ("Veterans Benefits", 6), ("Welfare Programs", 6), ("International Relations", 6), ("Immigration", 6)])
ARTICLES.extend([("Campaign Finance Reform", 7), ("Capital Punishment", 7), ("Hate Crimes", 7), ("Pardons", 7), ("Police Brutality", 7), ("Prisons", 7), ("Drug Sentencing", 7), ("Mandatory Minimum Sentences", 7), ("Three Strikes Laws", 7), ("Tort Reform", 7), ("Judicial Elections ", 7)])
ARTICLES.extend([("Guantanamo Bay", 8), ("The Draft", 8), ("Combat Drones", 8), ("Biological Weapons", 8), ("Chemical Weapons", 8), ("Nuclear Weapons", 8), ("Autonomous Weapons", 8)])
ARTICLES.extend([("Capitalism", 9), ("Communism", 9), ("Fascism", 9), ("Marxism", 9), ("Socialism", 9)])
ARTICLES.extend([("School Prayer", 10), ("Separation of Church & State", 10)])
ARTICLES.extend([("Genetically Engineered Foods", 14), ("High Speed Rail", 14), ("Internet Neutrality", 14), ("Scientific Discoveries", 14), ("Stem Cell Research", 14), ("NASA", 14), ("Government Surveillance", 14)])
ARTICLES.extend([("NAFTA", 12), ("NATO", 12), ("Nuclear Proliferation", 12), ("Nuclear Non-Proliferation Treaty", 12), ("TPP", 12), ("TTIP", 12), ("TISA", 12)])
ARTICLES.extend([("Syria ", 13), ("ISIS ", 13)])
ARTICLES.extend([("FEMA ", 14), ("International Aid", 14)])

TYPES = ['I', 'C', 'S']

class Civi():
	def __init__(self):
		self.id = 0;
		self.title = "";
		self.body = "";
		self.author = 0;
		self.visits = 0;
		self.votes_negative2 = 0;
		self.votes_negative1 = 0;
		self.votes_neutral = 0;
		self.votes_positive1 = 0;
		self.votes_positive2 = 0;
		self.type = 'I';
		self.article = None;
		self.AT = None;
		self.REFERENCE = None;
		self.AND_NEGATIVE = None;
		self.AND_POSITIVE = None;

	def __str__(self):
		string == '''
		Civi #{id}
		title: {title}
		body: {body}
		'''

	def query(self):
		string = "INSERT INTO \"api_civi\"(\"id\", \"title\", \"body\", \"author_id\", \"type\", \"visits\", \"votes_negative1\", \"votes_negative2\", \"votes_neutral\", \"votes_positive1\", \"votes_positive2\", \"article_id\") VALUES({id}, \'{title}\', \'{body}\', {author}, {visits}, {type} , {votes_negative2}, {votes_negative1}, {votes_neutral}, {votes_positive1}, {votes_positive2}, {article});"
		return string.format(
			id=self.id,
			title=self.title,
			body=self.body,
			author=self.author,
			type=self.type,
			visits=self.visits,
			votes_negative2=self.votes_negative2,
			votes_negative1=self.votes_negative1,
			votes_neutral=self.votes_neutral,
			votes_positive1=self.votes_positive1,
			votes_positive2=self.votes_positive2,
			article=self.article);



def createAccounts():
	ACCOUNTS = input("How many accounts do you want in the DB?:")
	if ACCOUNTS < 1:
		return ""

	string = "INSERT INTO \"public\".\"api_account\"(\"id\", \"name\", \"about_me\") VALUES({id}, \'User{id}\', \'Hi!, My name is User{id}!\');\n"
	query = "DELETE FROM \"api_account\" WHERE 1=1;\n"
	for id in range(ACCOUNTS):
		query += string.format(id=id)

	return ACCOUNTS, query


def createCategories():

	string = "INSERT INTO \"api_category\"(\"id\",\"name\") VALUES({id},\'{cat}\');\n"
	query = "DELETE FROM \"api_category\" WHERE 1=1;\n"
	for idx in range(len(CATEGORIES)):
		query += string.format(cat=CATEGORIES[idx], id=idx);

	return query

def createArticles():

	string = "INSERT INTO \"api_article\"(\"id\", \"topic\", \"category_id\") VALUES({id}, \'{cat}\', {idx});\n"
	query = "DELETE FROM \"api_article\" WHERE 1=1;\n"
	for id in range(len(ARTICLES)):
		cat = ARTICLES[id]
		query += string.format(id=id, cat=cat[0], idx=cat[1]);

	return query

def createCivis(ACCOUNTS):
	'''
		Create civi chains of the form-
		id: {id}
		title: TestCivi{#}
		body: This is the {#}nd {I,C,S} regarding {article}.
		author_id: {account}
		visits: {#}
		votes_negative2: {#}
		votes_negative1: {#}
		votes_neutral: {#}
		votes_positive1: {#}
		votes_positive2: {#}
		article: {article}
		AT: {id}
		REFERENCE: {id}
		AND_NEGATIVE: {id}
		AND_POSITIVE: {id}

	'''


	CIVIS = input("How many Civis do you want in the DB?:")
	if CIVIS < 1:
		return ""

	if ACCOUNTS < 1:
		print(ACCOUNTS)
		print("Can't Create Civi's without accounts, creating some now...")
		return False

	query = "DELETE FROM \"api_civi\" WHERE 1=1;\n"

	body = "This is the {id}nd {type} regarding {article}"

	for civi_id in range(CIVIS):
		civi = Civi()
		civi.id = civi_id
		civi.title = "TestCivi{id}".format(id=civi_id)
		civi.author = random.randrange(ACCOUNTS)
		votes = [random.randrange(ACCOUNTS) for i in range(5)]
		if sum(votes) > ACCOUNTS:
			overflow = int(math.ceil(sum(votes)%ACCOUNTS/5))
			votes = [max(vote - overflow, 0) for vote in votes]
		civi.type = random.choice(TYPES)
		civi.visits = sum(votes)
		civi.votes_negative2 = votes[0]
		civi.votes_negative1 = votes[1]
		civi.votes_neutral = votes[2]
		civi.votes_positive1 = votes[3]
		civi.votes_positive2  = votes[4]
		article = random.choice(ARTICLES)

		civi.article = article[1]
		civi.body = body.format(id=civi_id, type=random.choice(TYPES),  article=article[0])
		query += civi.query() + '\n'

	return CIVIS, query

query = ''
query += createCategories()
query += createArticles()
(ACCOUNTS, a) = createAccounts()
query += a
(CIVIS, c) = createCivis(ACCOUNTS)
query += c

text_file = open("populateDB.sql", "w")
text_file.write(query)
text_file.close()

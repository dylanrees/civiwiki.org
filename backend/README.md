Using the database:

API calls available:

The current url that Darius has the database linked to is:
url = http://civiwiki.ngrok.io/

url/api/topTen
Hit this url (i.e. http://civiwiki.ngrok.io/api/topTen) with a POST key-pair of {'article_id', <article_id>}
and it will respond with the top ten civis associated with that article

url/api/articles
Hit this url (i.e. http://civiwiki.ngrok.io/api/articles) with a POST key-pair of {'category_id', <category_id>}
and it will respond with the articles associated with that category

url/api/categories
This url responds with a list of all current categories

url/api/user
POST key-pair of {'username', <username>}
responds with all user information

url/api/adduser
fill in key-pair for the following POST fields

'first_name'
'last_name'
'email'
'username'
'about_me'
'password'

add the new user with those specifications will be created

url/api/addcivi
fill in the key-pair for the following POST fields

'author_id'
'article_id'
'title'
'body'
'type'
'reference_id'
'at_id'
'and_negative_id'
'and_positive_id'

and the new civi will be created

url/api/reportvote
fill in the key-pair for the following POST fields

'civi_id'
'vote'

and the vote will be recorded
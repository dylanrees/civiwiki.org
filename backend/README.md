Using the database:

API calls available:

The current url that Darius has the database linked to is: [http://civiwiki.ngrok.io/](http://civiwiki.ngrok.io/)

> /api/topTen

*Returns top ten civis associated with the article ID* |
**POST** requirements ['article_id']

> /api/articles

*Returns a list of articles associated with selected category* |
**POST** requirements ['category_id']

> /api/categories

*Returns a list of articles associated with selected category* |
**POST** requirements []

> /api/user

*Returns all user information for a specified user* |
**POST** requirements ['username']

> /api/adduser

*Returns a users secret key, after successful creation of a new account in our database* |
**POST** requirements ['first_name', 'last_name', 'email', 'username', 'about_me', 'password']

> /api/addcivi

*Returns success if a user successfully adds a civi* |
**POST** requirements ['author_id', 'article_id', 'title', 'body', 'type', 'reference_id', 'at_id', 'and_negative_id', 'and_positive_id']

> /api/reportvote

*Returns success if a user successfully reports a vote on a civi* |
**POST** requirements ['civi_id', 'vote']

url: http://civiwiki.org/

Relative Urls (frontend)
-------------
> urls accessible through browser HTTP requests to return and load HTML to the end user. Home pages, login pages, etc.

| url | page description |
| --- | --- |
| **/** | home |
| **/login** | login / register |



Relative Urls (API)
---------
> urls accessible through our application to return JSON data, as well as accept data to be stored / parsed. Database querys, login attempts, etc.

| url | description |
| --- | --- |
| **/api/login** | performs logging in of user |
| **/api/logout** | performs logging out of user |
| **/api/register** | creates and logs in a user |
| **/api/getcivi** | returns a civi by id number |
| **/api/topten** | returns 10 civis with highest rating |
| **/api/topics** | returns a list of the topics in circulation |
| **/api/categories** | returns a list of the categories in circulation |
| **/api/user** | returns a users information |
| **/api/getblock** | gets a block of interconnected civis |
| **/api/addcivi** | create a new civi |
| **/api/reportvote** | update the vote rating on a civi |

#CiviWIKI 

###Setup your development enviornment
**First and Foremost:** I recommend that you set up a virtual enviornment before you begin building. Django requires that you only have one version of it installed at a time, while different applications may use different versions based on their unique needs.

*We are using Postgres 9.3.5 and Django 1.8.5*

**To setup locally:**
****(setup on an AWS server needed)****

Create a postgres database (http://www.postgresql.org/) named **civiwiki**, user **postgres**
> ./setupCiviWiki

**To run locally:**
> python manage.py runserver







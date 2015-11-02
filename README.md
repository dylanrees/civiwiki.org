#CiviWIKI 

###Setup your development enviornment
**First and Foremost:** I recommend that you set up a virtual enviornment before you begin building. Django requires that you only have one version of it installed at a time, while different applications may use different versions based on their unique needs.

*We are using Postgres 9.3.5 and Django 1.8.5*

**To setup locally:**
****(setup on an AWS server needed)****

Create a postgres database (http://www.postgresql.org/) named **civiwiki**, user **postgres**
> ./setupCiviWiki

**To run application locally:**
> python manage.py runserver

**For the front-end / objective-C developers**
Ensure that any web request you make is pointed to your *localhost:5000*, this is how we will simulate our server calls.

Ensure that you update your code from master before development, and only push to master when you are 100% a feature is complete. Leave anything incomplete in a seperate branch. If you aren't sure how git works, there is alot of help online but the general structure is this.

> Master branch is our WORKING code, we use this to keep everyone in sync `git pull` often `git push` with extreme caution. 
> Create a new branch with `git checkout -B <branchname>` it will inherit the code from whatever branch you are on when you execute this command
> To look at your local changes compared to the point at your last commit `git status`
> To add files to be committed `git add <filename1 filename2 ...> **OR** .`
> To save a checkpoint on a file status `git commit -m"<description of what this commit entails>"`
> To push to a branch git push origin <branchname>






#CiviWIKI 
######*CiviWiki is a nonprofit charitable organization dedicated to encouraging the growth, development and free distribution of internet based democratic engagement systems designed to educate and empower citizens, to increase government accountability and to promote the general welfare*

###Setup your development enviornment
**First and Foremost:** I recommend that you set up a [virtual enviornment](http://docs.python-guide.org/en/latest/dev/virtualenvs/) before you begin building. Django requires that you only have one version of it installed at a time, while different applications may use different versions based on their unique needs.

*We are using Postgres 9.3.5 and Django 1.8.5*
*iOS targeted towards version 8.0, XCode 6.4*

**To setup locally**
*(effective setup on an AWS server probably won't be implemented within the next month)*
**:**

Create a postgres database (http://www.postgresql.org/) named **civiwiki**, user **postgres**
> ./setupCiviWiki

**To run application locally:**
> python backend/manage.py runserver

**For the front-end / objective-C developers**
Ensure that any web request you make is pointed to your *localhost:8000*, this is how we will simulate our server calls.

Ensure that you update your code from master before development, and only push to master when you are 100% a feature is complete. Leave anything incomplete in a seperate branch. If you aren't sure how git works, there is alot of help online but the general structure is this.

> Master branch is our WORKING code, we use this to keep everyone in sync `git pull` often `git push` with extreme caution. 
> Create a new branch with `git checkout -B <branchname>` it will inherit the code from whatever branch you are on when you execute this command.
> To look at your local changes compared to the point at your last commit `git status`.
> To add files to be committed `git add <filename1 filename2 ...>` **OR** `git add .`.
> To save a checkpoint on a file status `git commit -m"<description of what this commit entails>"`.
> To push to a branch `git push origin <branchname>`.



LICENSE:

BTBreadcrumbView by Created by Meiwin Fu on 13/1/13
BTBreadcrumbView is licensed under MIT License Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

makevirtualenv civiwiki
workon civiwiki
pip install -r requirements.txt
python manage.py migrate
python manage.py runserver

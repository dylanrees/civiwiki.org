makevirtualenv civiwiki
workon civiwiki
pip install -r backend/requirements.txt
python backend/manage.py migrate
python backend/manage.py runserver

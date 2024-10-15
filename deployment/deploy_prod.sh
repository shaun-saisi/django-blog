#!/bin/sh

ssh root@159.223.173.109 <<EOF
  cd django-blog
  git pull
  source /opt/env/djangoblog/bin/activate
  pip install -r requirements.txt
  cd website  
  ./manage.py makemigrations
  ./manage.py migrate --run-syncdb
  sudo service gunicorn restart
  sudo service nginx restart
  exit
EOF


#!/bin/bash

PROJECT_NAME=$1
WEB_SERVER=$2

echo "********* Initialization... *********"
/scripts/init.sh

echo "********* Starting Celery... *********"
/scripts/start-celery-worker.sh $PROJECT_NAME &
/scripts/start-celery-beat.sh $PROJECT_NAME &

# Run database migrations before starting Django server
echo "********* Running Database Migrations... *********"
python manage.py migrate --noinput

# Backup data before upgrading (you may need to adjust the backup location)
echo "********* Backing up Data... *********"
python manage.py dumpdata > /srv/curator/data_backup.json

echo "********* Starting Django server... *********"
/scripts/start-django.sh $PROJECT_NAME $WEB_SERVER

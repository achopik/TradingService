#!/bin/sh

if [ "$DATABASE" = "postgres" ]
then
    echo "Waiting for postgres..."

    while ! nc -z $SQL_HOST $SQL_PORT; do
      sleep 0.1
    done

    echo "PostgreSQL started"
fi

sleep 3
python sources/manage.py migrate
py.test
python sources/manage.py runserver 0.0.0.0:8000

exec "$@"
# Quickstart

A way to start a django project as quick as possible

# Operating System

These instructions are meant for Mac OS.

## Setup

1. Navigate to this directory and run `chmod +x quickstart.sh`
2. Run `./quickstart.sh` and the names for the project and app when prompted

## Database 

1. In the `DATABASES` variable in settings for the `default` dictionary, set `'ENGINE'` to `'django.db.backends.postgresql'`, `PORT` equal to `5432`. Create a postgresql database and then set `NAME`, `USER`, and `PASSWORD` to their respective values
2. Run `python manage.py migrate`
3. Run `python manage.py createsuperuser` then enter the requested information


# Quickstart

A way to start a django project as quick as possible

# Operating System

These instructions are meant for Mac OS.

## Setup

Navigate to this directory and run chmod +x quickstart.sh

1. Run `./quickstart.sh` and the names for the project and app when prompted.
2. Add your app to the settings file. Example: If your app name is polls insert `polls.apps.PollsConfig` to `INSTALLED_APPS` in `settings.py`.
3. Insert `<link rel="stylesheet" type="text/css" href="{% static "APPNAME/bootstrap-4.3.1-dist/css/bootstrap.css" %}">` into the head of your index.html file

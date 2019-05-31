#Get desired project and app names from user
read -p "Enter project name: " PROJECTNAME
read -p "Enter app name: " APPNAME

#Store absolute paths in variables
SCRIPTDIR=$(pwd)
BASEDIR=$(pwd)/$PROJECTNAME
APPDIR=$(pwd)/$PROJECTNAME/$APPNAME
PROJDIR=$(pwd)/$PROJECTNAME/$PROJECTNAME
STATICDIR=$(pwd)/$PROJECTNAME/$APPNAME/static/$APPNAME
TEMPLATESDIR=$(pwd)/$PROJECTNAME/$APPNAME/templates/$APPNAME

#Create virtual environment and add django
virtualenv venv
source venv/bin/activate
pip install Django

#Initialize django project
django-admin startproject $PROJECTNAME
deactivate
mv venv $BASEDIR
cd $BASEDIR
source venv/bin/activate

#Initialize django app
python manage.py startapp $APPNAME

#Add app to project urls
cd $PROJDIR
rm urls.py
touch urls.py
echo "from django.contrib import admin
from django.urls import include, path

urlpatterns = [
    path('"$APPNAME"/', include('"$APPNAME".urls')),
    path('admin/', admin.site.urls),
]" > urls.py

#Add index to view that displays a basic html page
cd $APPDIR
rm views.py
touch views.py
echo "from django.shortcuts import render

def index(request):
	return render(request, '"$APPNAME"/index.html')" > views.py


#Add index view to app urls
touch urls.py
echo "from django.urls import path

from . import views

urlpatterns = [
    path('', views.index, name='index'),
]" > urls.py

#Add bootstrap to app static files
mkdir static
cd static
mkdir $APPNAME
cd $SCRIPTDIR
cp -r bootstrap-4.3.1-dist $STATICDIR
cd $APPDIR

#Add basic html file to app templates
mkdir templates
cd templates
mkdir $APPNAME
cd $APPNAME
touch index.html
echo "{% load static %}
<!DOCTYPE html>
<html>
<head>
	<link rel=\"stylesheet\" type=\"text/css\" href=\"{% static \""$APPNAME"/bootstrap-4.3.1-dist/css/bootstrap.css\" %}\">
</head>
<body>
	<h1>Hello, world. You're at the "$APPNAME" index.</h1>
</body>
</html>" > index.html

#Create file where forms will go 
cd $APPDIR
touch forms.py

#Specify app in installed apps settings variable
cd $SCRIPTDIR
cp -r include_app.py $PROJDIR
cd $PROJDIR
python3 include_app.py $APPNAME
rm include_app.py

echo "Quickstart complete"






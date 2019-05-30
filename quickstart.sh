read -p "Enter project name: " PROJECTNAME
read -p "Enter app name: " APPNAME

SCRIPTDIR=$(pwd)
BASEDIR=$(pwd)/$PROJECTNAME
APPDIR=$(pwd)/$PROJECTNAME/$APPNAME
PROJDIR=$(pwd)/$PROJECTNAME/$PROJECTNAME
STATICDIR=$(pwd)/$PROJECTNAME/$APPNAME/static/$APPNAME
TEMPLATESDIR=$(pwd)/$PROJECTNAME/$APPNAME/templates/$APPNAME

virtualenv venv
source venv/bin/activate
pip install Django

django-admin startproject $PROJECTNAME
deactivate
mv venv $BASEDIR
cd $BASEDIR
source venv/bin/activate

python manage.py startapp $APPNAME

cd $PROJDIR
rm urls.py
touch urls.py
echo "from django.contrib import admin
from django.urls import include, path

urlpatterns = [
    path('"$APPNAME"/', include('"$APPNAME".urls')),
    path('admin/', admin.site.urls),
]" > urls.py

cd $APPDIR
rm views.py
touch views.py
echo "from django.shortcuts import render

def index(request):
	return render(request, '"$APPNAME"/index.html')" > views.py

touch urls.py
echo "from django.urls import path

from . import views

urlpatterns = [
    path('', views.index, name='index'),
]" > urls.py

mkdir static
cd static
mkdir $APPNAME
cd $SCRIPTDIR
cp -r bootstrap-4.3.1-dist $STATICDIR
cd $APPDIR


mkdir templates
cd templates
mkdir $APPNAME
cd $APPNAME
touch index.html

echo "{% load static %}
<!DOCTYPE html>
<html>
<head>
</head>
<body>
	<h1>Hello, world. You're at the "$APPNAME" index.</h1>
</body>
</html>" > index.html







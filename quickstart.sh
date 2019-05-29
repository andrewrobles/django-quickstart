read -p "Enter project name: " PROJECTNAME
read -p "Enter app name: " APPNAME

virtualenv venv
source venv/bin/activate
pip install Django

django-admin startproject $PROJECTNAME
deactivate
mv venv $PROJECTNAME
cd $PROJECTNAME
source venv/bin/activate

python manage.py startapp $APPNAME

cd $PROJECTNAME
rm urls.py
touch urls.py
echo "from django.contrib import admin
from django.urls import include, path

urlpatterns = [
    path('"$APPNAME"/', include('"$APPNAME".urls')),
    path('admin/', admin.site.urls),
]" > urls.py

cd ../
cd $APPNAME
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
cd ../../../
cp -r bootstrap-4.3.1-dist $PROJECTNAME/$APPNAME/static/$APPNAME
cd $PROJECTNAME/$APPNAME


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







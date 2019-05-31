import sys

file = open('settings.py', 'r')
data = file.readlines()
target = 'INSTALLED_APPS'
line = 0

for i in data:
	line += 1
	if target in i:
		break

app_name = sys.argv[1]
data[line] = '	\'' + app_name + '.apps.' + app_name.capitalize() + 'Config\',\n' + data[line]

file = open('settings.py', 'w')
file.writelines(data)
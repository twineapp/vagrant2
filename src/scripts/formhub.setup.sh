#!/bin/sh

echo "Formhub: Set up a new virtual environment:"
mkdir ~/virtual_environments
cd ~/virtual_environments
virtualenv --no-site-packages formhub
source formhub/bin/activate

echo "Formhub: Make directory structure and clone formhub:"
mkdir -p ~/src/formhub-app
cd ~/src/formhub-app
git clone git://github.com/modilabs/formhub.git
cd formhub
git submodule init
git submodule update

echo "Formhub: Install requirements:"
pip install numpy  --use-mirrors
pip install -r requirements.pip
sudo ln -s /usr/lib/x86_64-linux-gnu/libfreetype.so /usr/lib/
sudo ln -s /usr/lib/x86_64-linux-gnu/libz.so /usr/lib/
sudo ln -s /usr/lib/x86_64-linux-gnu/libjpeg.so /usr/lib/
pip install -r requirements.pip

echo "Formhub: Create a database and start server:"
python manage.py syncdb --noinput
python manage.py migrate


echo "Formhub: Configure the celery daemon:"
sudo cp ~/src/formhub-app/formhub/extras/celeryd/etc/init.d/celeryd /etc/init.d/celeryd
sudo cp ~/src/formhub-app/formhub/extras/celeryd/etc/default/celeryd /etc/default/celeryd
sed 's,<username>,vagrant,g' /etc/default/celeryd > tmpfile && mv tmpfile /etc/default/celeryd
###sudo /etc/init.d/celeryd start ### Not sure why this fails. Below is another users solution.
/home/vagrant/virtual_environments/formhub/bin/python /home/vagrant/src/formhub-app/formhub/manage.py celeryd_multi start
python manage.py runserver 0.0.0.0:8000

echo "Formhub: Running Tests:"
###python manage.py test ###Disabled testing as this is very time consuming (more than 20 minutes)


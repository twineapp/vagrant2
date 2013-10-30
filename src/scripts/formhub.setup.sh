#!/bin/sh

echo "Formhub: Make directory structure and clone formhub:"
cd /var/www
rm -rf formhub/ ; git clone git://github.com/modilabs/formhub.git
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
cp /var/www/vagrant2/puppet/templates/default_settings.py /var/www/formhub/formhub/preset/default_settings.py
mysql -u root -ppwd -e "create database formhub";
python manage.py syncdb --noinput
python manage.py migrate


echo "Formhub: Configure the celery daemon:"
cp /var/www/formhub/extras/celeryd/etc/init.d/celeryd /etc/init.d/celeryd
cp /var/www/formhub/extras/celeryd/etc/default/celeryd /etc/default/celeryd
sed 's,<username>,vagrant,g' /etc/default/celeryd > tmpfile && mv tmpfile /etc/default/celeryd
cp /var/www/vagrant2/puppet/templates/settings.py /var/www/formhub/formhub/settings.py
python manage.py celeryd_multi start
echo "127.0.0.1       formhub.local" >> /etc/hosts


cp /var/www/vagrant2/puppet/templates/formhub.wsgi /var/www/formhub/formhub.wsgi
cp /var/www/vagrant2/puppet/templates/formhub /etc/apache2/sites-available/formhub
a2ensite formhub

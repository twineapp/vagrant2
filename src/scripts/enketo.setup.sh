#!/bin/sh

a2enmod expires
cd /var/www/
git clone https://github.com/modilabs/enketo.git
cd enketo
git checkout 71af128c6a
mysql -u root -ppwd -e "create database enketo";
mysql -u root -ppwd --database=enketo < /var/www/enketo/devinfo/database/instances.sql
mysql -u root -ppwd --database=enketo < /var/www/enketo/devinfo/database/languages.sql
mysql -u root -ppwd --database=enketo < /var/www/enketo/devinfo/database/properties.sql
mysql -u root -ppwd --database=enketo < /var/www/enketo/devinfo/database/surveys.sql
git submodule update --init
cp /var/www/vagrant2/puppet/templates/.htaccess_enketo /var/www/enketo/public/.htaccess
sudo /etc/init.d/apache2 restart
cp /var/www/vagrant2/puppet/templates/settings.py /var/www/formhub/formhub/settings.py
cp /var/www/vagrant2/puppet/templates/database.php /var/www/enketo/Code_Igniter/application/config/database.php
echo "127.0.0.1       enketo.local" >> /etc/hosts


cp /var/www/vagrant2/puppet/templates/enketo /etc/apache2/sites-available/enketo
a2ensite enketo
service apache2 reload
#!/bin/sh

a2enmod expires
a2enmod ssl
cd /var/www/
rm -rf enketo/ ; git clone https://github.com/modilabs/enketo.git
cd enketo
mysql -u root -ppwd -e "create database enketo";
mysql -u root -ppwd --database=enketo < /var/www/enketo/devinfo/database/instances.sql
mysql -u root -ppwd --database=enketo < /var/www/enketo/devinfo/database/languages.sql
mysql -u root -ppwd --database=enketo < /var/www/enketo/devinfo/database/properties.sql
mysql -u root -ppwd --database=enketo < /var/www/enketo/devinfo/database/surveys.sql
git submodule init
git submodule update
sudo /etc/init.d/apache2 restart
cp /shared_folder/vagrant2/puppet/templates/enketo.php /var/www/enketo/Code_Igniter/application/config/enketo.php
cp /shared_folder/vagrant2/puppet/templates/database.php /var/www/enketo/Code_Igniter/application/config/database.php
cp /shared_folder/vagrant2/puppet/templates/config.php /var/www/enketo/Code_Igniter/application/config/config.php
echo "127.0.0.1       enketo.formhub.localhost" >> /etc/hosts

npm install -g grunt-cli
npm install
grunt

cp /shared_folder/vagrant2/puppet/templates/enketo /etc/apache2/sites-available/enketo
cp /shared_folder/vagrant2/puppet/templates/enketo-ssl /etc/apache2/sites-available/enketo-ssl
a2ensite enketo
a2ensite enketo-ssl
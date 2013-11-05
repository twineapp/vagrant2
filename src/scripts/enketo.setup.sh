#!/bin/sh

a2enmod expires
a2enmod ssl
cd /var/www/
git clone https://github.com/modilabs/enketo.git
cd enketo
mysql -u root -ppwd -e "create database enketo";
mysql -u root -ppwd --database=enketo < /var/www/vagrant2/src/sql-enketo/instances.sql
mysql -u root -ppwd --database=enketo < /var/www/vagrant2/src/sql-enketo/languages.sql
mysql -u root -ppwd --database=enketo < /var/www/vagrant2/src/sql-enketo/properties.sql
mysql -u root -ppwd --database=enketo < /var/www/vagrant2/src/sql-enketo/surveys.sql
git submodule update --init
sudo /etc/init.d/apache2 restart
cp /var/www/vagrant2/puppet/templates/enketo.php /var/www/enketo/Code_Igniter/application/config/enketo.php
cp /var/www/vagrant2/puppet/templates/database.php /var/www/enketo/Code_Igniter/application/config/database.php
echo "127.0.0.1       enketo.localhost" >> /etc/hosts


cp /var/www/vagrant2/puppet/templates/enketo /etc/apache2/sites-available/enketo
cp /var/www/vagrant2/puppet/templates/enketo-ssl /etc/apache2/sites-available/enketo-ssl
a2ensite enketo
a2ensite enketo-ssl
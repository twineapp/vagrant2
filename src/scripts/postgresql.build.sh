#!/bin/sh

echo "db script start."

echo "... 1 database, database users, user permissions"
sudo -u postgres psql -c "create database dof_security;"
sudo -u postgres psql -c "create user dof_read with password 'pwd';"
sudo -u postgres psql -c "create user dof_write with password 'pwd';"
sudo -u postgres psql -c "GRANT select ON ALL TABLES IN SCHEMA public TO dof_read;"
sudo -u postgres psql -c "GRANT select,insert,update,delete ON ALL TABLES IN SCHEMA public TO dof_write;"

echo "Change directory to /var/www/postgresql/"
echo "Importing data dump: dof_export_for_build_small.sql"
cd /shared_folder/postgresql/
sudo -u postgres psql dof_security < dof_export_for_build_small.sql > /dev/null 2>&1


echo "db script complete."
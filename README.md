#vagrant2

dev environment with xforms and postgresGIS

Virtual OS: Ubuntu 12.04 (Precise) x64, with Packages:

- Apache
- MySQL
- PostgreSQL
- Formhub
- Enketo
- Orbeon
- Tomcat7
- Java JDK
- Java JRE
- PHP
- phpMyAdmin
- Curl
- OAuth
- Mongo
- Prince
- Python
- Sendmail

## Requirements:
- VirtualBox (https://www.virtualbox.org/wiki/Downloads), tested with v4.2.12
- Vagrant (http://downloads.vagrantup.com), tested with v1.2.1

## Guide:  
1. Download and install software from Requirements  
2. Create a folder named 'dofapp/' and clone this repository (dofapp/vagrant2).  
3. Clone / copy in the dof repo and datasets  
	- clone 'dof' github repository into 'dofapp/dof/' directory
	
    - copy dof postgresql dump to 'dofapp/postgresql/dof_export.sql'
4. Run terminal, go into 'dofapp/vagrant2/', and execute the command 'vagrant up'. This will download the base box of ubuntu (~35MB), and bring up the dof vm
5. Install dnsmasq on your local machine nameserver

    **ubuntu**

    - sudo apt-get install dnsmasq	
    - edit /etc/dnsmasq.conf and add these entries to bottom of file
        - address=/formhub.localhost/192.168.50.5
        - address=/enketo.formhub.localhost/192.168.50.5
    - edit /etc/resolv.conf and add this entry to top of file
        - nameserver 127.0.0.1
        
    **OS X**

    - there is a good description here (using homebrew): http://blakeembrey.com/articles/local-development-with-dnsmasq/
    - brew install dnsmasq
    - edit /etc/dnsmasq.conf and add these entries to bottom of file
        - address=/formhub.localhost/192.168.50.5
        - address=/enketo.formhub.localhost/192.168.50.5
    - add nameserver entry at System Preferences -> Network -> Advanced -> DNS
        - nameserver 127.0.0.1 (as first entry)
        - your other DNS name servers
        
6. View dof: http://192.168.50.5/dof
7. View Formhub: http://formhub.localhost/
8. View Enketo: https://enketo.formhub.localhost/
9. View Orbeon: http://192.168.50.5:8080/

## Working with the twine vagrant:
- "vagrant up" starts the virtual machine
- "vagrant suspend" suspends the vm, this is normally how you would end your work session
- "vagrant halt" shuts down the vm, you would do this to autoload additional db patches for example
- "vagrant reload" is equivelent to a halt and up, and should be run after changes to the vagrant repo. Before a reload, delete the dbs
- "vagrant destroy" completely removes the vm from your machine. You would do this to save disk space if you won't be working on twine for a while, or to do a full rebuild after significant changes to the vagrant repo
- command reference: http://docs.vagrantup.com/v2/cli/index.html

## Notes:
- Server should be ready to use at 192.168.50.5 (modify this static IP in Vagrantfile before bringing up the vagrant if required)
- Test via http://192.168.50.5/phpinfo.php
- src in the directory is linked to the webserver document root

## VM Passwords
- mysql username:password are root:pwd
- postgresql username:password are dof_read:pwd
- postgresql username:password are dof_write:pwd
- rockmongo username:password are admin:admin

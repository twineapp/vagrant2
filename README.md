vagrant2
========

dev environment with xforms and postgresGIS

## Requirements:
- VirtualBox (https://www.virtualbox.org/wiki/Downloads), tested with v4.2.12
- Vagrant (http://downloads.vagrantup.com), tested with v1.2.1

## Guide:  
1. Download and install software from Requirements  
2. Create a folder named 'dofapp/' and clone this repository (dofapp/vagrant2).  
3. Clone / copy in the dof repo and datasets  
    3.1. Clone 'dof' github repository into 'dofapp/dof/' directory
    3.1. Copy dof postgresql dump to 'dofapp/postgresql/dof_export_for_build_small.sql' directory
4. Run terminal, go into 'dofapp/vagrant2/', and execute the command 'vagrant up'. This will download the base box of ubuntu (~35MB), and bring up the dof vm

#!/bin/sh

cd /root
sudo wget https://github.com/orbeon/orbeon-forms/releases/download/tag-release-4.3.0.1-ce/orbeon-4.3.0.1.201308150213-CE.zip
sudo unzip orbeon-4.3.0.1.201308150213-CE.zip
sudo cp orbeon-4.3.0.1.201308150213-CE/orbeon.war /var/lib/tomcat7/webapps/


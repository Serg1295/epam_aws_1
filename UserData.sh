#!/bin/bash
apt-get -y update
apt-get -y install apache2
PrivateIP=`curl http://169.254.169.254/latest/meta-data/local-ipv4`
echo "Sergo Hovakimyan $PrivateIP " > /var/www/html/index.html
sudo service apache2 start
chkconfig apache2 on
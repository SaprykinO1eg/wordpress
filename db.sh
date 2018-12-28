#!/bin/bash

# Update 
apt-get update

dpkg -s mc htop tmux &>/dev/null || {
	apt-get install mc htop tmux  -y
	}

export DEBIAN_FRONTED=noninterractive
debconf-set-selections <<< 'mariadb-server mysql-server/root_password password Qwert123'
debconf-set-selections <<< 'mariadb-server mysql-server/root_password_again password Qwert123'

dpkg -s mariadb-server &>/dev/null || {
	apt-get install -y mariadb-server
	}
	
sed -i 's/127.0.0.1/0.0.0.0/' /etc/mysql/mariadb.conf.d/50-server.cnf

service mysql restart

if  ! mysql -u root -pQwert123 -e "SHOW DATABASES;" | grep wordpress 
then
echo "Then add bd wordpress " 
mysql -u root -pQwert123 -e "CREATE DATABASE wordpress DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;"
mysql -u root -pQwert123 -e "GRANT ALL ON wordpress.* TO 'wordpress'@'192.168.100.10' IDENTIFIED BY 'wordpress';"
mysql -u root -pQwert123 -e "FLUSH PRIVILEGES;"
fi
echo "Install DB is Done!"
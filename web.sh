#!/bin/bash

# Update 
apt-get update

dpkg -s mc htop tmux mysql-client &>/dev/null || {
	apt-get install mc htop tmux mysql-client -y
	}

dpkg -s apache2 php libapache2-mod-php php-mysql php-curl php-gd \
	php-mbstring php-mcrypt php-xml php-xmlrpc zip  &>/dev/null || {
	apt-get install apache2 php libapache2-mod-php php-mysql php-curl php-gd \
	php-mbstring php-mcrypt php-xml php-xmlrpc zip  -y
	}
	a2enmod rewrite
	service apache2 restart
	
if [ ! -d /var/www/wordpress ]; then
	cd /tmp
	wget = https://wordpress.org/latest.zip -O wordpress.zip
	unzip wordpress.zip
	mv /tmp/wordpress /var/www/
fi

cd /etc/apache2/sites-available/
a2dissite "000-default.conf"
cp "000-default.conf" wordpress.conf
a2ensite wordpress.conf
chown -R www-data:www-data /var/www/wordpress/

sed -i 's/html/wordpress/' /etc/apache2/sites-available/wordpress.conf
sed -i 's/#ServerName www.example.ru/ServerName wordpress.example.ru/' \
/etc/apache2/sites-available/wordpress.conf
sed -i 's/ServerAdmin webmaster@localhost/ServerAdmin kazaam14@yandex.ru/' \
/etc/apache2/sites-available/wordpress.conf

service apache2 restart

echo "Install WEB is Done! "
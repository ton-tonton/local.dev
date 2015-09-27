#!/usr/bin/env bash

# variable
PASSWORD='password'

# update repository and upgrade package
sudo apt-get update
sudo apt-get -y upgrade

# install apache2 and syn folder /vagrant to /var/www
sudo apt-get install -y apache2
if ! [ -L /var/www ]; then
  rm -rf /var/www
  ln -fs /vagrant /var/www
fi

# install php 5.6
sudo apt-get install -y python-software-properties
sudo add-apt-repository -y ppa:ondrej/php5-5.6
sudo apt-get update
sudo apt-get -y upgrade
sudo apt-get install -y php5 php5-mcrypt

# install MySQL
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password password $PASSWORD"
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $PASSWORD"
sudo apt-get update
sudo apt-get install -y mysql-server php5-mysql

# enable mod_rewrite and mcrypt
sudo a2enmod rewrite
sudo php5enmod mcrypt
sudo service apache2 restart

# install git
sudo apt-get update
sudo apt-get install -y git

# install Composer
curl -s https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer

#install nodejs
sudo apt-get install -y nodejs
sudo apt-get install -y npm
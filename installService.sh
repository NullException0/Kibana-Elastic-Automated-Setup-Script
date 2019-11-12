#!/bin/bash


if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

printf '\n\n'
echo 'Updating and upgrading the server'
apt-get update -y
apt-get upgrade -y

printf '\n\n'
echo 'Installing Java Package'
apt-get install default-jdk -y
java -version

#Java
printf '\n\n'
echo 'Installing java component'
apt-get install software-properties-common -y
add-apt-repository ppa:linuxuprising/java

#ElasticSearch Repository
printf '\n\n'
echo 'Adding Elastic Repository'
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
apt-get install apt-transport-https
echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-7.x.list

#ElasticSearch
printf '\n\n'
echo 'Installing ElasticSearch'
apt-get install elasticsearch -y
/bin/systemctl daemon-reload
/bin/systemctl enable elasticsearch.service
systemctl start elasticsearch.service

#Kibana
printf '\n\n'
echo 'Installing Kibana'
apt-get update -y
apt-get install kibana -y
/bin/systemctl daemon-reload
/bin/systemctl enable kibana.service
systemctl start kibana.service

#Apache2
printf '\n\n'
echo 'installing apache2 web server and PHP'
apt-get install apache2 -y

#PHP
apt-get install php -y
apt-get install libapache2-mod-php -y

systemctl stop apache2
systemctl start apache2

printf '\n\n'
echo 'installing composer and elastic component'
apt-get install composer -y
mkdir /var/www/html/api
cd /var/www/html/api/
composer update
composer require elasticsearch/elasticsearch
# run above command in the api file
apt-get install php-curl -y

#reporting
printf '\n\n##############################\n\n'
printf 'JAVA\n\n'
java -version
printf '\n\n'

printf 'ElasticSearch'
printf '\n\n'

printf 'Composer'
printf '\n\n'

printf 'Kibana'
printf '\n\n'

printf 'Apache2 Web Server\n\n'
apache2 -v
printf '\n\n'

printf 'PHP\n\n'
php -v
printf '\n\n'

printf 'You should configure ElasticSearch X-Pack for security\n'
printf 'Guide to configure X-Pack : https://www.elastic.co/guide/en/elasticsearch/reference/6.7/setup-xpack.html\n\n'

printf 'sudo vi /etc/elasticsearch/elasticsearch.yml\n\n'
printf 'sudo /usr/share/elasticsearch/bin/elasticsearch-setup-passwords interactive\n\n'
printf 'sudo vi /etc/kibana/kibana.yml\n\n'
printf 'sudo service elasticsearch restart\n\n'
printf 'sudo service kibana restart\n\n'

printf '\n\n##############################\n\n'

read -p 'Press [Enter] key to continue...'
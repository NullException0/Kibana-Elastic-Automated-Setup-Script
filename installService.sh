#!bin/sh

echo '\n\nUpdating and upgrading the server\n\n'
apt update -y
apt-get upgrade -y


echo '\n\nInstalling Java Package\n\n'
apt install default-jdk -y
java -version


echo '\n\nInstalling java component\n\n'
apt install software-properties-common -y
add-apt-repository ppa:linuxuprising/java


echo '\n\nInstalling Elastic Search\n\n'
apt-get install elasticsearch -y
/bin/systemctl daemon-reload
/bin/systemctl enable elasticsearch.service
systemctl start elasticsearch.service


echo 'Installing Kibana\n\n'
apt-get install kibana -y
/bin/systemctl daemon-reload
/bin/systemctl enable kibana.service
systemctl start kibana.service


echo '\n\ninstalling apache2 web server and PHP\n\n'
apt install apache2 -y
apt install libapache2-mod-php -y
apt install php -y


systemctl stop apache2
systemctl start apache2


echo '\n\ninstalling composer and elastic component\n\n'
apt install composer -y
mkdir /var/www/html/api
cd /var/www/html/api/
composer update
composer require elasticsearch/elasticsearch
# run above command in the api file
apt install php-curl -y


function pause(){
   read -p "$*"
}
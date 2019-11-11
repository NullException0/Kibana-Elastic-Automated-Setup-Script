!/bin/bash
# run with sudo priviledge

printf '\n\n'
echo 'Updating and upgrading the server'
apt update -y
apt-get upgrade -y

printf '\n\n'
echo 'Installing Java Package'
apt install default-jdk -y
java -version

printf '\n\n'
echo 'Installing java component'
apt install software-properties-common -y
add-apt-repository ppa:linuxuprising/java

printf '\n\n'
echo 'Installing Elastic Search'
apt-get install elasticsearch -y
/bin/systemctl daemon-reload
/bin/systemctl enable elasticsearch.service
systemctl start elasticsearch.service

printf '\n\n'
echo 'Installing Kibana'
apt-get install kibana -y
/bin/systemctl daemon-reload
/bin/systemctl enable kibana.service
systemctl start kibana.service

printf '\n\n'
echo 'installing apache2 web server and PHP'
apt install apache2 -y
apt install libapache2-mod-php -y
apt install php -y

systemctl stop apache2
systemctl start apache2

printf '\n\n'
echo 'installing composer and elastic component'
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
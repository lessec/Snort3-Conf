#!/usr/bin/env bash
# Ubuntu LTS with ELK Installer

## Ready to run
sudo -Sv
ORGNPATH=$(pwd)
read -p "Allow ALL IP to connect ELK? If wish press (Y) then press return " AallIP
if [ "$AallIP" != "Y" ]; then
    read -p "Allow just ONE IP to connect ELK? If wish press (Y) then press return " AOneIP
    if [ "$AOneIP" = "Y" ]; then
        read -p "Enter allow IP: " AllowIP
    else
        echo "Please setup Firewall(UFW) manually for ELK"
    fi
fi

## Configure Port
sudo apt install -y ufw
sudo ufw allow ssh
if [ "$AallIP" = "Y" ]; then
    sudo ufw allow 9200/tcp
    sudo ufw allow 5601/tcp
elif [ "$AOneIP" = "Y" ]; then
    sudo ufw allow from "$AllowIP" to any port 9200
    sudo ufw allow from "$AllowIP" to any port 5601
fi
sudo ufw enable

## Get Elasticsearch, Logstash and Kibana repo
sudo apt install -y apt-transport-https
curl -fsSL https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo gpg --dearmor -o /usr/share/keyrings/elasticsearch-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/elasticsearch-keyring.gpg] https://artifacts.elastic.co/packages/8.x/apt stable main" | sudo tee /etc/apt/sources.list.d/elastic-8.x.list
sudo apt update

## Install Elasticsearch, Logstash and Kibana
sudo apt install -y elasticsearch | tee elastic-install.log
sudo apt install -y logstash
sudo apt install -y kibana

sudo mv /etc/elasticsearch/elasticsearch.yml /etc/elasticsearch/elasticsearch.yml.bck
sudo mv /etc/kibana/kibana.yml /etc/kibana/kibana.yml.bck
sudo cp "$ORGNPATH"/cfg/elasticsearch.yml /etc/elasticsearch/elasticsearch.yml
sudo cp "$ORGNPATH"/cfg/kibana.yml /etc/kibana/kibana.yml

sudo systemctl enable elasticsearch
sudo systemctl enable logstash
sudo systemctl enable kibana
sudo systemctl start elasticsearch
sudo systemctl start logstash
sudo systemctl start kibana

## Kibana Installation func
sudo /usr/share/elasticsearch/bin/elasticsearch-create-enrollment-token --scope kibana
sudo /usr/share/kibana/bin/kibana-verification-code
echo "-----DONE!-----"

#!/usr/bin/env bash
# Ubuntu LTS with ELK Installer

## Ready to run
sudo -Sv
ORGNPATH=$(pwd)
sudo apt install -y ufw
sudo ssh allow ssh
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

## Configure Port
#sudo ufw allow from <ALLOW IP> to any port 9200
#sudo ufw allow from <ALLOW IP> to any port 5601

## Kibana Installation func
sudo /usr/share/elasticsearch/bin/elasticsearch-create-enrollment-token --scope kibana
sudo /usr/share/kibana/bin/kibana-verification-code
echo "-----DONE!-----"

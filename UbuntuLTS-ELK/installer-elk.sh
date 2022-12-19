#!/usr/bin/env bash
# Ubuntu LTS with ELK Installer

sudo apt install -y ufw
sudo ufw enable

curl -fsSL https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo gpg --dearmor -o /usr/share/keyrings/elasticsearch-keyring.gpg
sudo apt install -y apt-transport-https

echo "deb [signed-by=/usr/share/keyrings/elasticsearch-keyring.gpg] https://artifacts.elastic.co/packages/8.x/apt stable main" | sudo tee /etc/apt/sources.list.d/elastic-8.x.list
echo "deb https://artifacts.elastic.co/packages/8.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-8.x.list
echo "deb [signed-by=/usr/share/keyrings/elasticsearch-keyring.gpg] https://artifacts.elastic.co/packages/8.x/apt stable main" | sudo tee /etc/apt/sources.list.d/elastic-8.x.list

sudo apt update
sudo apt install -y elasticsearch | tee elastic-install.log
sudo apt install -y logstash
sudo apt install -y kibana

sudo systemctl enable elasticsearch
sudo systemctl enable logstash
sudo systemctl enable kibana
sudo systemctl start elasticsearch
sudo systemctl start logstash
sudo systemctl start kibana

#sudo ufw allow from <ALLOW IP> to any port 9200
sudo /usr/share/elasticsearch/bin/kibana-verification-code
echo "-----DONE!-----"

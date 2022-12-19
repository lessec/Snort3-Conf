#!/usr/bin/env bash
# CentOS 9 Stream with ELK Installer

## Ready to run
sudo -Sv
ORGNPATH=$(pwd)
sudo dnf install -y java-17-openjdk java-17-openjdk-devel

sudo firewall-cmd --permanent --zone=public --add-port=9200/tcp
sudo firewall-cmd --permanent --zone=public --add-port=5601/tcp
sudo firewall-cmd --reload

## Install Elasticsearch, Logstash and Kibana
sudo update-crypto-policies --set LEGACY
sudo rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch
sudo cp "$ORGNPATH"/cfg/elasticsearch8.repo /etc/yum.repos.d/elasticsearch.repo
sudo cp "$ORGNPATH"/cfg/logstash8.repo /etc/yum.repos.d/logstash.repo
sudo cp "$ORGNPATH"/cfg/kibana8.repo /etc/yum.repos.d/kibana.repo

sudo dnf --enablerepo=elasticsearch install -y elasticsearch | tee elastic-install.log
sudo systemctl enable elasticsearch
sudo systemctl start elasticsearch

sudo dnf --enablerepo=elasticsearch install -y logstash
sudo systemctl enable logstash
sudo systemctl start logstash

sudo dnf --enablerepo=elasticsearch install -y kibana
sudo systemctl enable kibana
sudo systemctl start kibana

#!/usr/bin/env bash
# CentOS 9 Stream with ELK Installer

## Ready to run
sudo -Sv
ORGNPATH=$(pwd)
sudo dnf install -y firewalld
sudo systemctl enable firewalld
sudo systemctl start firewalld

## Get Elasticsearch, Logstash and Kibana repo
sudo update-crypto-policies --set LEGACY
sudo rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch
sudo cp "$ORGNPATH"/cfg/elasticsearch8.repo /etc/yum.repos.d/elasticsearch.repo
sudo cp "$ORGNPATH"/cfg/logstash8.repo /etc/yum.repos.d/logstash.repo
sudo cp "$ORGNPATH"/cfg/kibana8.repo /etc/yum.repos.d/kibana.repo

## Install Elasticsearch, Logstash and Kibana
sudo dnf --enablerepo=elasticsearch install -y elasticsearch | tee elastic-install.log
sudo dnf --enablerepo=elasticsearch install -y logstash
sudo dnf --enablerepo=elasticsearch install -y kibana
sudo systemctl enable elasticsearch
sudo systemctl enable logstash
sudo systemctl enable kibana
sudo systemctl start elasticsearch
sudo systemctl start logstash
sudo systemctl start kibana

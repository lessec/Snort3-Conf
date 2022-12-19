#!/usr/bin/env bash
# CentOS 9 Stream with Filebeat Installer

curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-8.5.2-x86_64.rpm
sudo rpm -vi filebeat-8.5.2-x86_64.rpm
sudo systemctl enable filebeat
sudo systemctl start filebeat
echo "-----DONE!-----"

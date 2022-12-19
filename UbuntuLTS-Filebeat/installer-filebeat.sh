#!/usr/bin/env bash
# Ubuntu LTS with Filebeat Installer

curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-8.5.3-amd64.deb
sudo dpkg -i filebeat-8.5.3-amd64.deb
sudo systemctl enable filebeat
sudo systemctl start filebeat
echo "-----DONE!-----"

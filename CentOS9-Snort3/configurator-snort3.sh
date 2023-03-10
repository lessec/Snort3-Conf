#!/usr/bin/env bash
# CentOS 9 Stream with Snort3 Configurator

# Get Oinkcode
sudo -Sv
read -p "Enter Oinkcode: " OINKCODE
ORGNPATH=$(pwd)

# Snort Global Rules, Open AppID and IP Reputation
mkdir -p ~/sources/snort-rules
cd ~/sources/snort-rules
curl -Lo snort3-community-rules.tar.gz https://snort.org/downloads/community/snort3-community-rules.tar.gz
curl -Lo snortrules-snapshot-31470.tar.gz https://www.snort.org/rules/snortrules-snapshot-31470.tar.gz?oinkcode="$OINKCODE"
curl -Lo Talos_LightSPD.tar.gz https://www.snort.org/rules/Talos_LightSPD.tar.gz?oinkcode="$OINKCODE"
curl -Lo ip-blocklist https://www.talosintelligence.com/documents/ip-blacklist
curl -Lo snort-openappid.tar.gz https://snort.org/downloads/openappid/26425
tar xf snort3-community-rules.tar.gz
tar xf snortrules-snapshot-*.tar.gz
tar xf Talos_LightSPD.tar.gz
tar xf snort-openappid.tar.gz

sudo mkdir -p /usr/local/snort/etc/snort/old
sudo cp ~/sources/snort-rules/snort3-community-rules/*.rules /usr/local/snort/etc/rules
sudo cp ~/sources/snort-rules/rules/*.rules /usr/local/snort/etc/rules
sudo cp ~/sources/snort-rules/so_rules/*.rules /usr/local/snort/etc/so_rules
sudo cp ~/sources/snort-rules/builtins/*.rules /usr/local/snort/etc/builtin_rules
sudo cp ~/sources/snort-rules/etc/snort_defaults.lua /usr/local/snort/etc/snort/old
sudo cp ~/sources/snort-rules/etc/snort.lua /usr/local/snort/etc/snort/old
sudo cp ~/sources/snort-rules/etc/file_magic.lua /usr/local/snort/etc/snort/old
sudo cp ~/sources/snort-rules/ip-blocklist /usr/local/snort/etc/lists
sudo cp -r ~/sources/snort-rules/lightspd/* /usr/local/snort/etc/lightspd
sudo cp -r ~/sources/snort-rules/odp /usr/local/snort/etc/appid/odp
ls /usr/local/snort/etc/rules; ls /usr/local/snort/etc/lists; ls /usr/local/snort/etc/appid/odp

# Confiure default setup
sudo cp "$ORGNPATH"/cfg/snort_defaults.lua /usr/local/snort/etc/snort/snort_defaults.lua
sudo cp "$ORGNPATH"/cfg/snort.lua /usr/local/snort/etc/snort/snort.lua
echo "-----DONE!-----"

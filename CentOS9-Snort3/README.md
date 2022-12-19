# CentOS9 Snort3 with PulledPork3

When before run `installer.sh`, first update CentOS 9 Stream
```bash
sudo dnf update -y && sudo dnf install -y curl git vim
sudo dnf config-manager --set-enabled crb
sudo dnf install -y dnf-plugins-core
sudo dnf install -y epel-release
sudo dnf upgrade -y && sudo reboot now
```

And please setup ldconfig
```bash
sudo vi /etc/ld.so.conf.d/local.conf
```
Add two line in local.conf:
```yml
/usr/local/lib
/usr/local/lib64
```
```bash
sudo ldconfig
```

## Start to install Snort3
Now, you can run installer!
```bash
git clone https://github.com/lessec/centos9-snort3.git
cd centos9-snort3
sh installer-snort3.sh
sh configurator-snort3.sh
sh installer-pp3.sh
```

## Run Snort
```bash
sudo snort -c /usr/local/snort/etc/snort/snort.lua --plugin-path /usr/local/snort/extra -k all -i ens160 -y -l /var/log/snort
```

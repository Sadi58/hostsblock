#!/bin/bash
##################
# This installation script is originally geared for Debian/GNOME systems.
# Therefore, some commands and locations used here (followed by comment "MIGHT NOT BE VALID FOR ALL SYSTEMS")
# may need to modified in other systems (including how dnsmasq & kwakd daemons are started at the end). 
# Please make sure that you have made any necessary changes before running this script in other systems.
##################
# get confirmation
read -r -p "This script is written for Debian/GNOME systems, and contains some commands and file copy destinations which may require modifications for other systems. Are you sure you don't need any such modifaction or have already done it? [y/N] " response
response=${response,,}    # tolower
if [[ $response =~ ^(yes|y)$ ]]
then
# install any missing dependencies
sudo apt-get install coreutils curl grep sed file unzip p7zip-full gzip gksu python-appindicator python-gtk2 zenity inotify-tools	# MIGHT NOT BE VALID FOR ALL SYSTEMS
# copy hostsblock files
sudo cp -f "./hostsblock.allow.list" "/usr/share/indicator-hostsblock/hostsblock.allow.list"
sudo cp -f "./hostsblock-common.sh" "/usr/share/indicator-hostsblock/hostsblock-common.sh"
sudo cp -f "./hostsblock.conf" "/usr/share/indicator-hostsblock/hostsblock.conf"
sudo cp -f "./hostsblock.deny.list" "/usr/share/indicator-hostsblock/hostsblock.deny.list"
sudo cp -f "./hostsblock.sh" "/usr/share/indicator-hostsblock/hostsblock.sh"
sudo cp -f "./hostsblock-urlcheck.sh" "/usr/share/indicator-hostsblock/hostsblock-urlcheck.sh"
sudo cp -f "../man/hostsblock.8" "/usr/share/man/man8/hostsblock.8" && sudo gzip -9 -n "/usr/share/man/man8/hostsblock.8"
sudo cp -f "../man/hostsblock.conf.8" "/usr/share/man/man8/hostsblock.8" && sudo gzip -9 -n "/usr/share/man/man8/hostsblock.conf.8"
sudo cp -f "../man/hostsblock-urlcheck.8" "/usr/share/man/man8/hostsblock.8" && sudo gzip -9 -n "/usr/share/man/man8/hostsblock-urlcheck.8"
# copy kwakd files
sudo cp -f "./kwakd/kwakd" "/etc/init.d/kwakd"	# MIGHT NOT BE VALID FOR ALL SYSTEMS
if [ `uname -m` == "x86_64" ]
then
	sudo cp -f "./kwakd/kwakd_amd64" "/usr/bin/kwakd"
else
	sudo cp -f "./kwakd/kwakd_i386" "/usr/bin/kwakd"
fi
sudo cp -f "./kwakd/start-kwakd" "/usr/bin/start-kwakd"
sudo cp -f "./kwakd/kwakd.1" "/usr/share/man/man1/kwakd.1" &&  sudo gzip -9 -n "/usr/share/man/man1/kwakd.1"
# copy indicator files
sudo cp -f "./indicator-hostsblock.desktop" "/etc/xdg/autostart/indicator-hostsblock.desktop"	# MIGHT NOT BE VALID FOR ALL SYSTEMS
sudo cp -f "./indicator_hostsblock.desktop" "/usr/share/applications/indicator_hostsblock.desktop"	# MIGHT NOT BE VALID FOR ALL SYSTEMS
sudo cp -f "./indicator-hostsblock.svg" "/usr/share/icons/indicator-hostsblock.svg"		# MIGHT NOT BE VALID FOR ALL SYSTEMS
sudo cp -f "./hostsblock-color.svg" "/usr/share/indicator-hostsblock/hostsblock-color.svg"
sudo cp -f "./hostsblock-dark.svg" "/usr/share/indicator-hostsblock/hostsblock-dark.svg"
sudo cp -f "./hostsblock-light.svg" "/usr/share/indicator-hostsblock/hostsblock-light.svg"
sudo cp -f "./hostsblock.svg" "/usr/share/indicator-hostsblock/hostsblock.svg"
sudo cp -f "./hostsblock-indicator" "/usr/share/indicator-hostsblock/hostsblock-indicator"
sudo cp -f "./hostsblock-launcher" "/usr/share/indicator-hostsblock/hostsblock-launcher"
sudo cp -f "./indicator-hostsblock" "/usr/share/indicator-hostsblock/indicator-hostsblock"
# make necessary configuration changes for dnsmaq
sudo sed -i "s/^#listen\-address=$/listen\-address=127\.0\.0\.1/g" "/etc/dnsmasq.conf"	# MIGHT NOT BE VALID FOR ALL SYSTEMS
sudo sed -i "s/^#addn\-hosts=\/etc\/banner_add_hosts$/addn\-hosts=\/etc\/hosts\.block/g" "/etc/dnsmasq.conf"	# MIGHT NOT BE VALID FOR ALL SYSTEMS
# start dnsmasq if not running already	# MIGHT NOT BE VALID FOR ALL SYSTEMS
if [ ! "$(pidof dnsmasq)" ]
then
	sudo systemctl enable dnsmasq
	sudo systemctl start dnsmasq
fi
# start kwakd if not running already	# MIGHT NOT BE VALID FOR ALL SYSTEMS
if [ ! "$(pidof kwakd)" ]
then
	sudo update-rc.d kwakd defaults
	sudo "/etc/init.d/kwakd" start
fi
fi

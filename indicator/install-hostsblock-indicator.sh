#!/bin/bash

##################
# Note: This installation script is geared for
# Debian/GNOME systems - like Ubuntu.
# Therefore, some commands and locations used here
# may need to be modified in other systems,
# e.g. how dnsmasq, kwakd, etc. can work.
# Please make sure that you have made any necessary changes
# before running this script in other systems.
##################

# get confirmation and go
read -r -p "This script is written for Debian/GNOME systems, like Ubuntu, and contains some commands and file copy destinations which may require modifications for other systems. Are you sure you don't need any such modification or have already done it? [y/N] " response
# to-lower
response=${response,,}
if [[ $response =~ ^(yes|y)$ ]]; then

#	install any missing dependencies
	sudo apt-get install coreutils curl dnsmasq grep sed file unzip p7zip-full gzip gksu python-appindicator python-gtk2 zenity inotify-tools

#	copy hostsblock files
	if [ ! -d '/usr/share/indicator-hostsblock' ]; then
	sudo mkdir '/usr/share/indicator-hostsblock'
	fi
	sudo cp -f "./hostsblock.allow.list" "/usr/share/indicator-hostsblock/hostsblock.allow.list"
	sudo cp -f "./hostsblock-common.sh" "/usr/share/indicator-hostsblock/hostsblock-common.sh"
	sudo cp -f "./hostsblock.conf" "/usr/share/indicator-hostsblock/hostsblock.conf"
	sudo cp -f "./hostsblock.deny.list" "/usr/share/indicator-hostsblock/hostsblock.deny.list"
	sudo cp -f "./hostsblock.sh" "/usr/share/indicator-hostsblock/hostsblock.sh"
	sudo cp -f "./hostsblock-urlcheck.sh" "/usr/share/indicator-hostsblock/hostsblock-urlcheck.sh"
	sudo cp -f "../man/hostsblock.8" "/usr/share/man/man8/hostsblock.8" && sudo gzip -9 -n "/usr/share/man/man8/hostsblock.8"
	sudo cp -f "../man/hostsblock.conf.8" "/usr/share/man/man8/hostsblock.conf.8" && sudo gzip -9 -n "/usr/share/man/man8/hostsblock.conf.8"
	sudo cp -f "../man/hostsblock-urlcheck.8" "/usr/share/man/man8/hostsblock-urlcheck.8" && sudo gzip -9 -n "/usr/share/man/man8/hostsblock-urlcheck.8"
	sudo chmod a+r "/usr/share/man/man8/hostsblock.8.gz" "/usr/share/man/man8/hostsblock.conf.8.gz" "/usr/share/man/man8/hostsblock-urlcheck.8.gz"

#	copy kwakd files
#	sudo cp -f "./kwakd/kwakd" "/etc/init.d/kwakd"
#	if [ `uname -m` == "x86_64" ]; then
#		sudo cp -f "./kwakd/kwakd_amd64" "/usr/bin/kwakd"
#	else
#		sudo cp -f "./kwakd/kwakd_i386" "/usr/bin/kwakd"
#	fi
#	sudo cp -f "./kwakd/start-kwakd" "/usr/bin/start-kwakd"
#	sudo cp -f "./kwakd/kwakd.1" "/usr/share/man/man1/kwakd.1" &&  sudo gzip -9 -n "/usr/share/man/man1/kwakd.1"

#	copy indicator files
	sudo cp -f "./indicator-hostsblock.desktop" "/etc/xdg/autostart/indicator-hostsblock.desktop"
	sudo cp -f "./indicator_hostsblock.desktop" "/usr/share/applications/indicator_hostsblock.desktop"
	sudo cp -f "./hostsblock-breeze-dark.svg" "/usr/share/icons/hostsblock-breeze-dark.svg"
	sudo cp -f "./hostsblock-breeze-light.svg" "/usr/share/icons/hostsblock-breeze-light.svg"
	sudo cp -f "./hostsblock-color.svg" "/usr/share/indicator-hostsblock/hostsblock-color.svg"
	sudo cp -f "./hostsblock-dark.svg" "/usr/share/indicator-hostsblock/hostsblock-dark.svg"
	sudo cp -f "./hostsblock-light.svg" "/usr/share/indicator-hostsblock/hostsblock-light.svg"
	sudo cp -f "./hostsblock.svg" "/usr/share/indicator-hostsblock/hostsblock.svg"
	sudo cp -f "./hostsblock-check-updates" "/usr/share/indicator-hostsblock/hostsblock-check-updates"
	sudo cp -f "./hostsblock-indicator" "/usr/share/indicator-hostsblock/hostsblock-indicator"
	sudo cp -f "./hostsblock-launcher" "/usr/share/indicator-hostsblock/hostsblock-launcher"
	sudo cp -f "./indicator-hostsblock" "/usr/share/indicator-hostsblock/indicator-hostsblock"
	sudo cp -f "./indicator-hostsblock.svg" "/usr/share/indicator-hostsblock/indicator-hostsblock.svg"
	sudo chmod a+r -R "/usr/share/indicator-hostsblock/"
	sudo chmod a+rx "/etc/xdg/autostart/indicator-hostsblock.desktop" "/usr/share/indicator-hostsblock/hostsblock-indicator" "/usr/share/indicator-hostsblock/hostsblock-launcher" "/usr/share/indicator-hostsblock/indicator-hostsblock"

#	make indicator icon writable by all
	sudo chmod a+w "/usr/share/indicator-hostsblock/hostsblock.svg" "/usr/share/indicator-hostsblock/hostsblock-check-updates"

#	set default update interval as daily
	sudo ln -sf "/usr/share/indicator-hostsblock/hostsblock-launcher" "/etc/cron.daily/hostsblock-launcher"

#	make necessary configuration changes for dnsmaq
	sudo sed -i "s/^#listen\-address=$/listen\-address=127\.0\.0\.1/g" "/etc/dnsmasq.conf"
	sudo sed -i "s/^#addn\-hosts=\/etc\/banner_add_hosts$/addn\-hosts=\/etc\/hosts\.block/g" "/etc/dnsmasq.conf"

#	start dnsmasq if not running already
	if [ ! "$(pidof dnsmasq)" ]; then
		sudo systemctl enable dnsmasq
		sudo systemctl start dnsmasq
	fi

#	start kwakd if not running already
#	if [ ! "$(pidof kwakd)" ]; then
#		sudo update-rc.d kwakd defaults
#		sudo "/etc/init.d/kwakd" start
#	fi

fi

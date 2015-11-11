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
sudo cp -f "./auto-refresh" "/usr/share/indicator-hostsblock/auto-refresh"
sudo cp -f "./change-icon-gui" "/usr/share/indicator-hostsblock/change-icon-gui"
sudo cp -f "./check-updates" "/usr/share/indicator-hostsblock/check-updates"
sudo cp -f "./disable-hostsblock" "/usr/share/indicator-hostsblock/disable-hostsblock"
sudo cp -f "./editor-gui" "/usr/share/indicator-hostsblock/editor-gui"
sudo cp -f "./edit-user-gui" "/usr/share/indicator-hostsblock/edit-user-gui"
sudo cp -f "./enable-hostsblock" "/usr/share/indicator-hostsblock/enable-hostsblock"
sudo cp -f "./hostsblock-color.png" "/usr/share/indicator-hostsblock/hostsblock-color.png"
sudo cp -f "./hostsblock-dark.png" "/usr/share/indicator-hostsblock/hostsblock-dark.png"
sudo cp -f "./hostsblock-light.png" "/usr/share/indicator-hostsblock/hostsblock-light.png"
sudo cp -f "./hostsblock.png" "/usr/share/indicator-hostsblock/hostsblock.png"
sudo cp -f "./indicator-hostsblock" "/usr/share/indicator-hostsblock/indicator-hostsblock"
sudo cp -f "./launcher" "/usr/share/indicator-hostsblock/launcher"
sudo cp -f "./launcher-gui" "/usr/share/indicator-hostsblock/launcher-gui"
sudo cp -f "./merge-user-gui" "/usr/share/indicator-hostsblock/merge-user-gui"
sudo cp -f "./restart-dnsmasq" "/usr/share/indicator-hostsblock/restart-dnsmasq"
sudo cp -f "./restart-indicator" "/usr/share/indicator-hostsblock/restart-indicator"
sudo cp -f "./scheduler-gui" "/usr/share/indicator-hostsblock/scheduler-gui"
sudo cp -f "./status_auto-update" "/usr/share/indicator-hostsblock/status_auto-update"
sudo cp -f "./status_last-update" "/usr/share/indicator-hostsblock/status_last-update"
sudo cp -f "./viewer-gui" "/usr/share/indicator-hostsblock/viewer-gui"
sudo cp -f "./view-hostsblock-gui" "/usr/share/indicator-hostsblock/view-hostsblock-gui"
sudo cp -f "./view-log-gui" "/usr/share/indicator-hostsblock/view-log-gui"
sudo cp -f "./indicator_hostsblock.desktop" "/usr/share/applications/indicator_hostsblock.desktop"	# MIGHT NOT BE VALID FOR ALL SYSTEMS
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

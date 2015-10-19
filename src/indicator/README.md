indicator-hostsblock
===============

A very simple and lightweight indicator applet to manage hostsblock: https://github.com/gaenserich/hostsblock

Based on the AMD indicator applet here: https://github.com/beidl/amd-indicator

![screenshot](indicator-hostsblock-screenshot.png)

Prerequisites
===============

Install "python-appindicator" and "zenity" in addition to any other hostsblock dependencies.

Installation
===============

Install "hostsblock" as required - for example:
```
	/usr/local/lib/hostsblock-common.sh
	/etc/hostsblock/black.list
	/etc/hostsblock/hostsblock.conf
	/etc/hostsblock/hostsblock.sh
	/etc/hostsblock/hostsblock-urlcheck.sh
	/etc/hostsblock/white.list
```
Then copy "hostsblock-indicator" files like this:
```
	/etc/sudoers.d/indicator-hostsblock-sudoers
	/etc/xdg/autostart/indicator-hostsblock.desktop
	/usr/local/indicator-hostsblock/check-updates
	/usr/local/indicator-hostsblock/disable-hostsblock
	/usr/local/indicator-hostsblock/editor-gui
	/usr/local/indicator-hostsblock/enable-hostsblock
	/usr/local/indicator-hostsblock/hostsblock.png
	/usr/local/indicator-hostsblock/hostsblock-color.png
	/usr/local/indicator-hostsblock/hostsblock-dark.png
	/usr/local/indicator-hostsblock/hostsblock-light.png
	/usr/local/indicator-hostsblock/icon4colortheme
	/usr/local/indicator-hostsblock/icon4darktheme
	/usr/local/indicator-hostsblock/icon4lighttheme
	/usr/local/indicator-hostsblock/indicator-hostsblock
	/usr/local/indicator-hostsblock/launcher
	/usr/local/indicator-hostsblock/launcher-gui
	/usr/local/indicator-hostsblock/restart-dnsmasq
	/usr/local/indicator-hostsblock/restart-indicator
	/usr/local/indicator-hostsblock/scheduler-gui
	/usr/local/indicator-hostsblock/status_auto-update
	/usr/local/indicator-hostsblock/status_last-update
	/usr/local/indicator-hostsblock/viewer-gui
```
Caution: Be aware that copying a file under the system directory "/etc/sudoers.d" might make it impossible to use the "sudo" command if there's something wrong with the file. Therefore, it might be a good idea to keep this folder open in a Root Nautilus or Root Terminal window so that you can remove this file to remedy such a problem.

Info about some files
=====================

1. The file "indicator-hostsblock" is a simple pyhton script (originally found here: https://github.com/beidl/amd-indicator) that adds an indicator to the system tray (Unity top panel) to easily manage the original hostsblock utility, using several scripts added here. 

2. The file "launcher" merely launches "/etc/hostsblock/hostsblock.sh" with verbosity level 3, creates a log file, and sends a graphical notification of the result ("no updates" or "x updates") to user(s).

3. The file "check-updates" is actually a clipping of the original "hostsblock.sh" script, which merely checks the blocklists, and (unsuccessfully) attempts to download and overwrite those that have changed since the last update in the system cache, and then allows replacing such failure messages with a "change found" statement in "launcher-gui".

4. The file "launcher-gui" is a simple zenity-based script that starts the "check-updates" script, informs the user when there are updates, and asks if they would like hostsblock to update. If Yes, the user is required to enter their password, and hostsblock is launched similar to "launcher", and then the user is asked if they would like to view the log file.

5. The file "scheduler-gui" is a simple zenity-based script which checks all cron directories (/etc/cron.hourly,daily,weekly,monthly) for the file (or symlink) "hostsblock-launcher" (aka "launcher") to inform the user how hostsblock is scheduled to run, and asks if they would like to change it, and then implements the user's choice.

6. The files "viewer-gui" and "editor-gui" are simple zenity-based scripts that allow the user to view/edit file(s) they choose from a list (/etc/hosts.block; /etc/hostsblock/hostsblock.conf,black.list,white.list; /var/log/hostsblock.log).

HostsBlock Indicator
=====================

A very simple and lightweight indicator applet to manage hostsblock: https://github.com/gaenserich/hostsblock

Based on the AMD indicator applet here: https://github.com/beidl/amd-indicator

**NOTE:** The indicator here is based on the previous main version of **hostsblock**, which  runs only system-wide with admin privileges, because (1) it needs considerable effort and time to overhaul the whole indicator script(s), and (2) the use of this indicator makes it less essential to make the move allowing to run **hostsblock** without admin privileges.

![screenshot](indicator-hostsblock-screenshot.png)

Installation
----------------------

1. ***Use the "installation script" provided***: Open a terminal window, change (`cd`) to the sub-directory `.../indicator` and enter `./install-hostsblock-indicator.sh` (after **customizing**, if necessary, for non-Debian/GNOME systems). This should install the **hostsblock** and **indicator** together with **dnsmasq** (if not installed already). After copying all files, the script adds the entries "*listen-address=127.0.0.1*" and "*addn-hosts=/etc/hosts.block*" to `/etc/dnsmasq.conf` (if they don't exist already), and starts **dnsmasq** service (if it is not running already), after which the user can either run **HostsBlock Indicator** application or choose to start using it via the indicator after logging out and back in. Also note that installation of **kwakd** has now been commented out because at least some of the latest web browsers seem to be intelligently handling the issue concerned.

2. **Manual installation**: Follow the commands in the installation script, e.g. copying and pasting each into a terminal window opened in the sub-directory `indicator`.

Change log
----------------------

- **0.999.3-17:** Added 2 Breeze-style icons; expanded allow.list; condensed indicator menu; removed deb package files; improved hostsblock.conf; minor fixes
- **0.999.3-16:** Fixed problem with very long query result lists; Changed how log history is displayed; Added hostsblock status info to menu
- **0.999.3-15:** Re-organized some menu items, inc. "Edit Config Files" and "Merge User Lists", plus several small fixes
- **0.999.3-14:** New menu items "View History", "Query Hosts.Block File" and "Query Cache Files", plus several small fixes
- **0.999.3-13:** Most scripts merged into a single "backend" script (as functions)
- **0.999.3-12:** Changed icons
- **0.999.3-11:** Smarter use of sudo command
- **0.999.3-10:** Fixed kwakd pathnames and updated icons
- **0.999.3-09:** Moved upstream hostsblock files also into indicator directory to fix deb reinstallation/upgrade issues
- **0.999.3-08:** Fixed important bugs associated with awk commands in some scripts
- **0.999.3-07:** Both **hostsblock** and **indicator** moved to `/usr/share/` to avoid **lintian errors**
- **0.999.3-06:** Improved View/Edit Config Files menu items, and hostsblock.conf format
- **0.999.3-05:** Added quit menu item and polished menu further
- **0.999.3-04:** Indicator now automatically refreshes after a change in program directory (e.g. log, icon)
- **0.999.3-03:** Added user black/white lists feature and fixed some bugs
- **0.999.3-02:** Fixed indicator restart failure after launcher cron job
- **0.999.3-01:** Minor upstream updates, added hostsblock man files
- **0.999.2-03:** Added kwakd man file
- **0.999.2-02:** Added launcher no update notification

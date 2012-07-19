#!/usr/bin/env python2

import os
import commands

command = "wicd-cli --wireless -d"
output = commands.getoutput(command)
if output == 'Invalid wireless network identifier.':
    os.system('rfkill unblock wlan')
    os.system('ifconfig wlan0 up')
else:
    os.system('rfkill block wlan')
    os.system('ifconfig wlan0 down')

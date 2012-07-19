#!/usr/bin/env python2
"""
Gives your laptop's battery state(charging/discharging) and battery percentage
for your tmux status bar.

requires- acpi
"""

import commands
import os


def get_charging_state():
    command = "acpi -a"
    output = commands.getoutput(command)
    return output.split(':')[1].strip()


def get_battery_percentage():
    command = "acpi -b"
    if get_charging_state() == 'on-line':
        output = commands.getoutput(command)
        return output[-3:]
    elif get_charging_state() == 'off-line':
        output = commands.getoutput(command)
        batt = output.split(',')[1].strip()
        return batt

if __name__ == '__main__':
    if get_charging_state() == 'on-line':
        os.system("echo C")  # this means it's plugged in

    else:
        os.system("echo " + get_battery_percentage())

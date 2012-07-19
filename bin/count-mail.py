#!/usr/bin/env python2

import commands
import os

mailboxes = "~/.mail/GMail/INBOX/new"

command= """
find %s -type d -exec sh -c "ls -1 {} | wc -l | tr -d ' ' " \;""" % mailboxes
output = commands.getoutput(command)
output = map(int, output.split('\n'))

total_mail = sum(output) 

os.system("echo " + str(total_mail))

#!/bin/sh
# Inspired by Joshaven Potter
# http://joshaven.com/resources/tricks/mikrotik-automatically-updated-address-list/
saveTo=../public/lists
now=$(date);
echo "# Generated on $now" > $saveTo/openbl.rsc
echo "/ip firewall address-list" >> $saveTo/openbl.rsc
wget -q -O - http://www.openbl.org/lists/base_30days.txt.gz | gunzip | awk --posix '/^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}/ { print "add list=blacklist address=" $1 " comment=OpenBL";}' >> $saveTo/openbl.rsc
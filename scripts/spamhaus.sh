#!/bin/sh
# Inspired by Joshaven Potter
# http://joshaven.com/resources/tricks/mikrotik-automatically-updated-address-list/
saveTo=../public/lists
now=$(date);
echo "# Generated on $now" > $saveTo/spamhaus.rsc
echo "/ip firewall address-list" >> $saveTo/spamhaus.rsc
wget -q -O - http://www.spamhaus.org/drop/drop.lasso | awk --posix '/[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\// { print "add list=blacklist address=" $1 " comment=SpamHaus";}' >> $saveTo/spamhaus.rsc
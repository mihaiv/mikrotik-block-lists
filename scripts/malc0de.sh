#!/bin/bash
# Inspired by Joshaven Potter
# http://joshaven.com/resources/tricks/mikrotik-automatically-updated-address-list/
DIR="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR

saveTo=../public/lists
now=$(date);
echo "# Generated on $now" > $saveTo/malc0de.rsc
echo "/ip firewall address-list" >> $saveTo/malc0de.rsc
wget -q -O - http://malc0de.com/bl/IP_Blacklist.txt | awk --posix '/^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}/ { print "add list=blacklist address=" $1 " comment=malc0de";}' >> $saveTo/malc0de.rsc


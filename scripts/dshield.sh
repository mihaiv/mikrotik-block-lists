#!/bin/bash
# Inspired by Joshaven Potter
# http://joshaven.com/resources/tricks/mikrotik-automatically-updated-address-list/
DIR="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR

saveTo=../public/lists
now=$(date);
echo "# Generated on $now" > $saveTo/dshield.rsc
echo "/ip firewall address-list" >> $saveTo/dshield.rsc
wget -q -O - http://feeds.dshield.org/block.txt | awk --posix '/^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.0\t/ { print "add list=blacklist address=" $1 "/24 comment=DShield";}' >> $saveTo/dshield.rsc
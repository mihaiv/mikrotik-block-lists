## Mikrotik Block Lists


These scripts were created by [Joshaven Potter](http://joshaven.com/resources/tricks/mikrotik-automatically-updated-address-list/).
They were adapted to be easily deployed on a personal server.

## Installing on your own web server
* Create a new webserver virtual host pointing to the /public folder
* Create 3 weekly cron jobs (one for each script under the /scripts folder) to refresh the lists 


## Router Scripts

### [OpenBL](https://www.openbl.org/lists.html)
“The OpenBL.org project (formerly known as the SSH blacklist) is about detecting, logging and reporting various types of internet abuse. Currently our hosts monitor ports 21 (FTP), 22 (SSH), 23 (TELNET), 25 (SMTP), 110 (POP3), 143 (IMAP), 587 (Submission), 993 (IMAPS) and 995 (POP3S) for bruteforce login attacks as well as scans on ports 80 (HTTP) and 443 (HTTPS) for vulnerable installations of phpMyAdmin and other web applications.”

	# Script which will download the drop list as a text file
	/system script add name="Download_openbl" source={
	/tool fetch url="http://yourdomain.com/lists/openbl.rsc" mode=http;
	:log info "Downloaded openbl.rsc";
	}

	# Script which will Remove old openbl list and add new one
	/system script add name="Replace_openbl" source={
	:foreach i in=[/ip firewall address-list find ] do={
	:if ( [/ip firewall address-list get $i comment] = "OpenBL" ) do={
	/ip firewall address-list remove $i
	}
	}
	/import file-name=openbl.rsc;
	:log info "Removal old openbl and add new";
	}

	# Schedule the download and application of the openbl list
	/system scheduler add comment="Download openbl list" interval=7d name="DownloadBegoneList" on-event=Download_openbl start-date=jan/01/1970 start-time=01:05:00
	/system scheduler add comment="Apply openbl List" interval=7d name="InstallBegoneList" on-event=Replace_openbl start-date=jan/01/1970 start-time=01:15:00


### [SpamHaus](http://www.spamhaus.org/drop/)

“Spamhaus Don’t Route Or Peer List (DROP)
The DROP list will not include any IP address space under the control of any legitimate network – even if being used by “the spammers from hell”. DROP will only include netblocks allocated directly by an established Regional Internet Registry (RIR) or National Internet Registry (NIR) such as ARIN, RIPE, AFRINIC, APNIC, LACNIC or KRNIC or direct RIR allocations.”

	# Script which will download the drop list as a text file
	/system script add name="Download_spamhaus" source={
	/tool fetch url="http://yourdomain.com/lists/spamhaus.rsc" mode=http;
	:log info "Downloaded spamhaus.rsc";
	}

	# Script which will Remove old spamhaus list and add new one
	/system script add name="Replace_spamhaus" source={
	:foreach i in=[/ip firewall address-list find ] do={
	:if ( [/ip firewall address-list get $i comment] = "SpamHaus" ) do={
	/ip firewall address-list remove $i
	}
	}
	/import file-name=spamhaus.rsc;
	:log info "Removal old spamhaus and add new";
	}

	# Schedule the download and application of the spamhaus list
	/system scheduler add comment="Download spamhaus list" interval=7d name="DownloadSpamhausList" on-event=Download_spamhaus start-date=jan/01/1970 start-time=02:02:00
	/system scheduler add comment="Apply spamhaus List" interval=7d name="InstallSpamhausList" on-event=Replace_spamhaus start-date=jan/01/1970 start-time=02:12:00

### [dshield](https://www.dshield.org/)

“This list summarizes the top 20 attacking class C (/24) subnets over the last three days. The number of ‘attacks’ indicates the number of targets reporting scans from this subnet.”

	# Script which will download the drop list as a text file
	/system script add name="Download_dshield" source={
	/tool fetch url="http://yourdomain.com/lists/dshield.rsc" mode=http;
	:log info "Downloaded dshield.rsc";
	}

	# Script which will Remove old dshield list and add new one
	/system script add name="Replace_dshield" source={
	:foreach i in=[/ip firewall address-list find ] do={
	:if ( [/ip firewall address-list get $i comment] = "DShield" ) do={
	/ip firewall address-list remove $i
	}
	}
	/import file-name=dshield.rsc;
	:log info "Removal old dshield and add new";
	}

	# Schedule the download and application of the dshield list
	/system scheduler add comment="Download dshield list" interval=7d name="DownloadDShieldList" on-event=Download_dshield start-date=jan/01/1970 start-time=02:42:00
	/system scheduler add comment="Apply dshield List" interval=7d name="InstallDShieldList" on-event=Replace_dshield start-date=jan/01/1970 start-time=02:52:00

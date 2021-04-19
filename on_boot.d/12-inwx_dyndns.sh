#!/bin/sh
# @k-a-s-c-h on GitHub
# @0815 on ubnt forums
# file is located at https://github.com/k-a-s-c-h/unifi/blob/main/on_boot.d/12-inwx_dyndns.sh

###############
dyndns_username='user'
dyndns_password='password'
dyndns_hostname='your-dyndns.domain.tld'
update_ipv6=true
sleeptime=30
###############

while sleep $sleeptime
do

	if [ $update_ipv6 = true ]; then
		if [ `nslookup -type=a $dyndns_hostname ns.inwx.de | tail -n2 | grep Address | awk '{print $2}'` != `curl -s -4 ifconfig.co` ] || [ `nslookup -type=aaaa $dyndns_hostname ns.inwx.de | tail -n2 | grep Address | awk '{print $2}'` != `curl -s -6 ifconfig.co` ]; then
			curl --user $dyndns_username:$dyndns_password "https://dyndns.inwx.com/nic/update?myip=${ipv4}&myipv6=${ipv6}"
		fi
	else
		if [ `nslookup -type=a $dyndns_hostname ns.inwx.de | tail -n2 | grep Address | awk '{print $2}'` != `curl -s -4 ifconfig.co` ]; then
			curl --user $dyndns_username:$dyndns_password "https://dyndns.inwx.com/nic/update?myip=${ipv4}"
		fi
	fi
	
done
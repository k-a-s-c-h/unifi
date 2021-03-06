#!/bin/sh
# @k-a-s-c-h on GitHub
# @0815 on ubnt forums
# file is located at https://github.com/k-a-s-c-h/unifi/blob/main/on_boot.d/12-inwx_dyndns.sh
#
# curl -LJo /mnt/data/on_boot.d/12-inwx_dyndns.sh https://raw.githubusercontent.com/k-a-s-c-h/unifi/main/on_boot.d/12-inwx_dyndns.sh
# chmod +x /mnt/data/on_boot.d/12-inwx_dyndns.sh

###############
dyndns_username='username'
dyndns_password='password'
dyndns_hostname='your-dyndns.domain.tld'
update_sleeptime='30'
update_ipv4ipv6='true'
update_ipv4_only='false'
update_ipv6_only='false'
namesver='ns.inwx.de'
get_ipv4='ifconfig.co'
get_ipv6='ifconfig.co'
###############

while sleep $update_sleeptime
do

	if [ $update_ipv4ipv6 = true ]; then
		if [ `nslookup -type=a $dyndns_hostname $nameserver | tail -n2 | grep Address | awk '{print $2}'` != `curl -s -4 $get_ipv4` ] || [ `nslookup -type=aaaa $dyndns_hostname $nameserver | tail -n2 | grep Address | awk '{print $2}'` != `curl -s -6 $get_ipv6` ]; then
			curl --user $dyndns_username:$dyndns_password "https://dyndns.inwx.com/nic/update?myip=${ipv4}&myipv6=${ipv6}"
		fi
	elif [ $update_ipv4_only = true ]; then
		if [ `nslookup -type=a $dyndns_hostname $nameserver | tail -n2 | grep Address | awk '{print $2}'` != `curl -s -4 $get_ipv4` ]; then
			curl --user $dyndns_username:$dyndns_password "https://dyndns.inwx.com/nic/update?myip=${ipv4}"
		fi
	elif [ $update_ipv6_only = true ]; then
		if [ `nslookup -type=aaaa $dyndns_hostname $nameserver | tail -n2 | grep Address | awk '{print $2}'` != `curl -s -6 $get_ipv6` ]; then
			curl --user $dyndns_username:$dyndns_password "https://dyndns.inwx.com/nic/update?myipv6=${ipv6}"
		fi
	fi
	
done

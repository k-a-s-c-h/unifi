#!/bin/bash
# @k-a-s-c-h on GitHub
# @0815 on ubnt forums
# file is located at https://github.com/k-a-s-c-h/unifi/blob/main/on_boot.d/12-cloudflare_ddns.sh
#
# curl -LJo /mnt/data/on_boot.d/12-cloudflare_ddns.sh https://raw.githubusercontent.com/k-a-s-c-h/unifi/main/on_boot.d/12-cloudflare_ddns.sh
# chmod +x /mnt/data/on_boot.d/12-cloudflare_ddns.sh

api_token=""                                         # API Token, must be created at https://dash.cloudflare.com/profile/api-tokens
subdomain=""                                         # Which subdomain you want to be updated
update_sleeptime=300                                 # Set check time, in seconds
ipv4_update=false                                    # IPv4 update true/false
ipv6_update=false                                    # IPv6 update true/false

[ ! -z "$api_token" ] || { echo "API Token not set" ; exit 1; }

if [ $ipv4_update = true ] || [ $ipv6_update = true ]; then
	[ ! -z "$zone_id" ] || zone_id=$(curl -s -X GET "https://api.cloudflare.com/client/v4/zones?name=$(echo "$subdomain" | awk -F\. '{print $(NF-1) FS $NF}')" -H "Authorization: Bearer $api_token" -H "Content-Type: application/json"| jq -r '.result[] | "\(.id)"')

	while sleep $update_sleeptime
	do

	if [[ $ipv4_update = true ]]; then
		wanip=$(curl -s -4 checkip.amazonaws.com)
		if [[ $wanip =~ ^(([1-9]?[0-9]|1[0-9][0-9]|2([0-4][0-9]|5[0-5]))\.){3}([1-9]?[0-9]|1[0-9][0-9]|2([0-4][0-9]|5[0-4]))$ ]]; then
			record=$(curl -s -X GET "https://api.cloudflare.com/client/v4/zones/$zone_id/dns_records?type=A&name=$subdomain" -H "Authorization: Bearer $api_token" -H "Content-Type: application/json")
			[[ $record == *"\"count\":0"* ]] && { echo -s "Cloudflare DDNS Updater: $subdomain does not exist on Cloudflare"; exit 1; }
			if [[ $wanip == $(echo "$record" | jq -r '{"result"}[] | .[0] | .content') ]]; then
				echo "Cloudflare DDNS Updater: WANIP $wanip for $subdomain has not changed."
			else
				update=$(curl -s -X PUT "https://api.cloudflare.com/client/v4/zones/$zone_id/dns_records/$(echo "$record" | jq -r '{"result"}[] | .[0] | .id')" -H "Authorization: Bearer $api_token" -H "Content-Type: application/json" --data "{\"id\":\"$zone_id\",\"type\":\"A\",\"name\":\"$subdomain\",\"content\":\"$wanip\"}")
				case "$update" in
					*"\"success\":false"*)
						echo "Cloudflare DDNS Updater: WANIP $wanip $subdomain DDNS failed for update."
					;;
					*)
						echo "Cloudflare DDNS Updater: old WANIP $(echo "$record" | jq -r '{"result"}[] | .[0] | .content') new WANIP $wanip $subdomain DDNS updated."
					;;
				esac
			fi
		else
			echo "Cloudflare DDNS Updater: No public IP found or WANIP IPv4 is not valid."
		fi
	fi

	if [[ $ipv6_update = true ]]; then
		wanip=$(curl -s -6 ifconfig.co)
		if [[ $wanip =~ ^(([0-9a-fA-F]{1,4}:){7,7}[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,7}:|([0-9a-fA-F]{1,4}:){1,6}:[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,5}(:[0-9a-fA-F]{1,4}){1,2}|([0-9a-fA-F]{1,4}:){1,4}(:[0-9a-fA-F]{1,4}){1,3}|([0-9a-fA-F]{1,4}:){1,3}(:[0-9a-fA-F]{1,4}){1,4}|([0-9a-fA-F]{1,4}:){1,2}(:[0-9a-fA-F]{1,4}){1,5}|[0-9a-fA-F]{1,4}:((:[0-9a-fA-F]{1,4}){1,6})|:((:[0-9a-fA-F]{1,4}){1,7}|:)|fe80:(:[0-9a-fA-F]{0,4}){0,4}%[0-9a-zA-Z]{1,}|::(ffff(:0{1,4}){0,1}:){0,1}((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\.){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])|([0-9a-fA-F]{1,4}:){1,4}:((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\.){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9]))$ ]]; then
			record=$(curl -s -X GET "https://api.cloudflare.com/client/v4/zones/$zone_id/dns_records?type=AAAA&name=$subdomain" -H "Authorization: Bearer $api_token" -H "Content-Type: application/json")
			[[ $record == *"\"count\":0"* ]] && { echo -s "Cloudflare DDNS Updater: ${record_name} does not exist on Cloudflare"; exit 1; }
			if [[ $wanip == $(echo "$record" | jq -r '{"result"}[] | .[0] | .content') ]]; then
				echo "Cloudflare DDNS Updater: WANIP $wanip for $subdomain has not changed."
			else
				update=$(curl -s -X PUT "https://api.cloudflare.com/client/v4/zones/$zone_id/dns_records/$(echo "$record" | jq -r '{"result"}[] | .[0] | .id')" -H "Authorization: Bearer $api_token" -H "Content-Type: application/json" --data "{\"id\":\"$zone_id\",\"type\":\"AAAA\",\"name\":\"$subdomain\",\"content\":\"$wanip\"}")
				case "$update" in
					*"\"success\":false"*)
						echo "Cloudflare DDNS Updater: WANIP $wanip $subdomain DDNS failed for update."
					;;
					*)
						echo "Cloudflare DDNS Updater: old WANIP $(echo "$record" | jq -r '{"result"}[] | .[0] | .content') new WANIP $wanip $subdomain DDNS updated."
					;;
				esac
			fi
		else
			echo "Cloudflare DDNS Updater: No public IP found or WANIP IPv6 is not valid."
		fi
	fi

	done

fi
#!/bin/sh
# @k-a-s-c-h on GitHub
# @0815 on ubnt forums
# file is located at https://github.com/k-a-s-c-h/unifi/blob/main/on_boot.d/11-ad-ula.sh
# curl -LJo /mnt/data/on_boot.d/11-add-ula.sh https://raw.githubusercontent.com/k-a-s-c-h/unifi/main/on_boot.d/11-add-ula.sh
# chmod +x /mnt/data/on_boot.d/11-add-ula.sh
# execute via ssh "ifconfig br0 | grep HWaddr | awk '{print $5}'" and generate a ULA PREFIX with your br0 MAC address on https://cd34.com/rfc4193/ and enter it under ULA_PREFIX_br0
###############
logfile=0
sleeptime=30
ULA_PREFIX_br0=
###############

[ ! -z "$sleep_time" ] || sleep_time=0

while sleep $sleep_time
do

if [ `ifconfig br0 | grep "$ULA_PREFIX_br0::1/64" | wc -l` = 0 ]; then
	ip address add $ULA_PREFIX_br0::1/64 dev br0
fi

sleep_time=$sleeptime

done

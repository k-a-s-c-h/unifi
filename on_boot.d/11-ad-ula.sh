#!/bin/sh
# @k-a-s-c-h on GitHub
# @0815 on ubnt forums
# file is located at https://github.com/k-a-s-c-h/unifi/blob/main/on_boot.d/11-ad-ula.sh

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
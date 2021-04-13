

<b>UDM/UDMPro Boot Script (on_boot.d)</b>
- Thanks John D. for providing UDM / UDMPro Boot Script
- https://github.com/boostchicken/udm-utilities/tree/master/on-boot-script

<b>UDM/UDMPro Wireguard</b>
- Thanks tusc for providing Wireguard for UDM / UDMPro in kernel mode
- https://github.com/tusc/wireguard-kmod

<b>UDM/UDMPro Wireguard Start Script (requires on_boot.d)</b><br>
<a href="https://github.com/k-a-s-c-h/unifi/blob/main/on_boot.d/10-wireguard.sh">10-wireguard.sh</a> starts automatically when booting the UDM / UDMPro @tusc setup_wireguard.sh script and starts the Wireguard VPN tunnel. If Wireguard is not yet present on the UDM/UDMPro, 10-wireguard.sh automatically loads the latest release from @tusc repo and extracts it.
```
curl -LJo /mnt/data/on_boot.d/10-wireguard.sh https://raw.githubusercontent.com/k-a-s-c-h/unifi/main/on_boot.d/10-wireguard.sh
chmod +x /mnt/data/on_boot.d/10-wireguard.sh
```

<b>UDM/UDMPro Wireguard Failover Script (requires on_boot.d)</b>
- <a href="https://github.com/k-a-s-c-h/unifi/blob/main/on_boot.d/10-wireguard_failover.sh">10-wireguard_failover.sh</a><br>
On failover, Wireguard automatically switches from the primary interface to the failover interface, when switching from the failover interface to the primary interface, Wireguard remains on the failover interface.<br>
By default, the Wireguard failover script checks every 30 seconds to see if the primary interface is available again and reconnects Wireguard to the primary interface.<br>
In the script you can adjust the sleeptime using the variable sleeptime. Furthermore it is possible to write a logfile to the file wireguard_failover in /mnt/data/log/ using the variable logfile.

```
logfile= 0 disable | 1 enable
sleeptime = time in ms
```

```
curl -LJo /mnt/data/on_boot.d/10-wireguard_failover.sh https://raw.githubusercontent.com/k-a-s-c-h/unifi/main/on_boot.d/10-wireguard_failover.sh
chmod +x /mnt/data/on_boot.d/10-wireguard_failover.sh
```
<b>Author: k-a-s-c-h (@0815 on ubnt forums)</b>

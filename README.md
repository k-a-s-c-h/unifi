

<b>UDM/UDMPro Boot Script (on_boot.d)</b>
- Thanks John D. for providing UDM / UDMPro Boot Script
- https://github.com/boostchicken/udm-utilities/tree/master/on-boot-script

<b>UDM/UDMPro Wireguard</b>
- Thanks tusc for providing Wireguard for UDM / UDMPro in kernel mode
- https://github.com/tusc/wireguard-kmod

<b>UDM/UDMPro Wireguard Start Script (on_boot.d)</b><br>
- <a href="https://github.com/k-a-s-c-h/unifi/blob/main/on_boot.d/10-wireguard.sh">10-wireguard.sh</a><br>
10-wireguard.sh starts automatically when booting the UDM / UDMPro and starts setup_wireguard.sh script from tusc and starting the Wireguard VPN tunnel.<br>
10-wireguard.sh checks if Wiregard is already present on the UDM/UDM Pro, if not it will be downloaded from tusc repo and extracted.
```
curl -LJo /mnt/data/on_boot.d/10-wireguard.sh https://raw.githubusercontent.com/k-a-s-c-h/unifi/main/on_boot.d/10-wireguard.sh
chmod +x /mnt/data/on_boot.d/10-wireguard.sh
```

<b>UDM/UDMPro Wireguard Failover Script (on_boot.d)</b>
- <a href="https://github.com/k-a-s-c-h/unifi/blob/main/on_boot.d/10-wireguard_failover.sh">10-wireguard_failover.sh</a><br>
During failover, Wireguard automatically switches from the primary Interface to the failover Interface when switching from the failover Interface to the primary Interface, Wireguard remains on the failover Interface.<br>
The Wireguard Failover script checks every 30 seconds whether the primary Interface is available again and reconnects Wireguard to the primary Interface.
```
curl -LJo /mnt/data/on_boot.d/10-wireguard_failover.sh https://raw.githubusercontent.com/k-a-s-c-h/unifi/main/on_boot.d/10-wireguard_failover.sh
chmod +x /mnt/data/on_boot.d/10-wireguard_failover.sh
```
<b>Author: k-a-s-c-h (@0815 on ubnt forums)</b>

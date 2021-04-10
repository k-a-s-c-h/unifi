

<b>UDM/UDMPro Boot Script (on_boot.d)</b>
- Thanks John D. for providing UDM / UDMPro Boot Script
- https://github.com/boostchicken/udm-utilities/tree/master/on-boot-script

<b>UDM/UDMPro Wireguard</b>
- Thanks tusc for providing Wireguard for UDMPro in kernel mode
- https://github.com/tusc/wireguard-kmod

<b>UDM/UDMPro Wireguard Start Script (on_boot.d)</b>
```
# curl -LJo /mnt/data/on_boot.d/10-wireguard.sh https://raw.githubusercontent.com/k-a-s-c-h/unifi/main/on_boot.d/10-wireguard.sh
# chmod +x /mnt/data/on_boot.d/10-wireguard.sh
```

<b>UDM/UDMPro Wireguard Failover Script (on_boot.d)</b>
- <a href="https://github.com/k-a-s-c-h/unifi/blob/main/on_boot.d/10-wireguard_failover.sh">10-wireguard_failover.sh</a><br>
During failover, Wireguard automatically switches from the primary WAN to the failover Interface when switching from the failover Interface to the primary WAN, Wireguard remains on the failover Interface.<br>
wireguard_failover checks every 240 seconds whether the primary WAN is available again and reconnects Wireguard to the primary WAN.
```
# curl -LJo /mnt/data/on_boot.d/10-wireguard_failover.sh https://raw.githubusercontent.com/k-a-s-c-h/unifi/main/on_boot.d/10-wireguard_failover.sh
# chmod +x /mnt/data/on_boot.d/10-wireguard_failover.sh
```
<b>Author: k-a-s-c-h (@0815 on ubnt forums)</b>

<b>Author: k-a-s-c-h (@0815 on ubnt forums)</b>

<b>UDMPro Boot Script (on_boot.d)</b>
- https://github.com/boostchicken/udm-utilities/tree/master/on-boot-script
- chmod +x /mnt/data/on_boot.d/*

<b>UDMPro Wireguard</b>
- https://github.com/tusc/wireguard-kmod

<b>UDMPro Wireguard Start Script (on_boot.d)</b>
- <a href="https://github.com/k-a-s-c-h/unifi/blob/main/on_boot.d/10-wireguard.sh">10-wireguard.sh</a><br>

<b>UDMPro Wireguard Failover Script (on_boot.d)</b>
- <a href="https://github.com/k-a-s-c-h/unifi/blob/main/on_boot.d/10-wireguard_failover.sh">10-wireguard_failover.sh</a><br>
During failover, Wireguard automatically switches from the primary WAN to the failover WAN when switching from the failover WAN to the primary WAN, Wireguard remains on the failover WAN.
10-wireguard_failover.sh checks every 240 seconds whether the primary WAN is available again and reconnects Wireguard to the primary WAN.

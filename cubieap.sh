#!/bin/sh

modprobe bcmdhd op_mode=2
ip addr add 10.254.239.1/24 dev wlan0
sysctl net.ipv4.ip_forward=1
iptables -t nat -A POSTROUTING -s 10.254.239.0/24 -o eth0 -j MASQUERADE
iptables -A FORWARD -s 10.254.239.0/24 -o eth0 -j ACCEPT
iptables -A FORWARD -d 10.254.239.0/24 -m conntrack --ctstate ESTABLISHED,RELATED -i eth0 -j ACCEPT
systemctl start hostapd
systemctl start dnsmasq


#!/bin/bash
#

whoami

iptables -A OUTPUT -p tcp --dport 22 -j ACCEPT
iptables -A OUTPUT -p tcp --dport 53 -j ACCEPT
iptables -A OUTPUT -p udp --dport 53 -j ACCEPT
iptables -A OUTPUT -j REJECT

ip6tables -A OUTPUT -p tcp --dport 22 -j ACCEPT
ip6tables -A OUTPUT -p tcp --dport 53 -j ACCEPT
ip6tables -A OUTPUT -p udp --dport 53 -j ACCEPT
ip6tables -A OUTPUT -j REJECT

echo "alias winscp='wine C:/Program\ Files\ (x86)/WinSCP/winscp.exe'" >> /home/app/.bashrc

su - -c 'wine "C:/Program Files (x86)/WinSCP/winscp.exe"' app


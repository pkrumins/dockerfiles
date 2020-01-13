#!/bin/bash
#

iptables -A OUTPUT -p tcp --dport 3306 -j ACCEPT
iptables -A OUTPUT -p tcp --dport 3307 -j ACCEPT
iptables -A OUTPUT -p tcp --dport 3308 -j ACCEPT
iptables -A OUTPUT -p tcp --dport 3309 -j ACCEPT
iptables -A OUTPUT -j REJECT

ip6tables -A OUTPUT -p tcp --dport 3306 -j ACCEPT
ip6tables -A OUTPUT -p tcp --dport 3307 -j ACCEPT
ip6tables -A OUTPUT -p tcp --dport 3308 -j ACCEPT
ip6tables -A OUTPUT -p tcp --dport 3309 -j ACCEPT
ip6tables -A OUTPUT -j REJECT

echo "alias sqlyog='wine .wine/drive_c/Program\ Files/SQLyog\ Community/SQLyogCommunity.exe'" >> /home/app/.bashrc

su - -c 'wine .wine/drive_c/Program\ Files/SQLyog\ Community/SQLyogCommunity.exe' app

#su - app

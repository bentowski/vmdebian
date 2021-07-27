#!/bin/bash
apt install sudo -y
apt install cron -y
apt install net-tools -y
apt install ufw -y
apt install libpam-cracklib -y
adduser bbaudry
deluser user42
addgroup user42
addgroup bbaudry user42
addgroup bbaudry sudo
cp srcs/sshd_config /etc/ssh/
cp srcs/login.defs /etc/
cp srcs/sudoers /etc/
cp srcs/common-password /etc/pam.d/
cp srcs/monitoring.sh /root/
ufw default deny outgoing
ufw default deny incoming
ufw allow 4242
chage -M 30 bbaudry
chage -m 2 bbaudry
chage -W 7 bbaudry
chage -M 30 root
chage -m 2 root
chage -W 7 root

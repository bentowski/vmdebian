#!/bin/bash
apt install sudo -y
apt install cron -y
apt install net-tools -y
apt install ufw -y
apt install libpam-cracklib -y
addgroup bbaudry42
addgroup bbaudry bbaudry42
addgroup bbaudry sudo
cp sshd_config /etc/ssh/
cp sudoers /etc/
cp common-password /etc/pam.d/
cp monitoring.sh /root/
ufw default deny outgoing
ufw default deny incoming
ufw allow 4242
chage -M 30 bbaudry
chage -M 30 root
chage -m 2 bbaudry
chage -m 2 root
chage -W 7 bbaudry
chage -W 7 root

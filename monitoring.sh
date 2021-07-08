#!/bin/bash
archi=`uname -a`
pCPU=`lscpu | grep "Processeur" | cut -d' ' -f26`
vCPU=`cat /proc/cpuinfo | grep "processor" | wc -l`
Tmem=`free -m | grep "Mem" | cut -d' ' -f13`
Umem=`free -m | grep "Mem" | cut -d' ' -f22`
Pmem=`free | grep "Mem" | awk '{print $3/$2 * 100.0}' | cut -c-4`
Tdisk=`df --total -h | grep "total" | cut -d' ' -f29`
Udisk=`df --total -h | grep "total" | cut -d' ' -f33 | cut -c-3`
Pdisk=`df --total -h | grep "total" | cut -d' ' -f39`
CPUload=`top -n1 | grep "%Cpu" | cut -c1`
boot=`who -b | cut -c29-`
lvm=`lsblk | grep "root" | cut -d' ' -f19`
if [ $lvm = "lvm" ]
then
	lvm="yes"
else
	lvm="no"
fi
tcp=`netstat -a | grep "tcp" | grep "ESTABLISHED" | wc -l`
users=`who | wc -l`
ip=`ip address show enp0s3 | grep "inet " | cut -d' ' -f6 | cut -d'/' -f1`
mac=`ip address show enp0s3 | grep "ether" | cut -d' ' -f6`
sudo=`ls /var/log/sudo/00/00/ | wc -l`
touch print
echo \#Architecture: $archi >> print
echo \#CPU Physical: $pCPU >> print
echo \#vCPU: $vCPU >> print
echo \#Memory Usage: $Umem/$Tmem'MB' '('$Pmem'%)' >> print
echo \#Disk Usage: $Udisk/$Tdisk '('$Pdisk')' >> print
echo \#CPU Load: $CPUload >> print
echo \#Last Boot: $boot >> print
echo \#LVM Use: $lvm >> print
echo \#Connexions TCP: $tcp ESTABLISHED >> print
echo \#User Log: $users >> print
echo \#Network: IP $ip '('$mac')' >> print
echo \#Sudo: $sudo cmd >> print
wall print
rm print

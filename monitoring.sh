#!/bin/bash
archi=`uname -a`
pCPU=`lscpu | grep "Processeur" | awk '{print $2}'`
vCPU=`cat /proc/cpuinfo | grep "processor" | wc -l`
Tmem=`free -m | grep "Mem" | awk '{print $2}'`
Umem=`free -m | grep "Mem" | awk '{print $3}'`
Pmem=`free | grep "Mem" | awk '{print $3/$2 * 100.0}' | cut -c-4`
Tdisk=`df --total -h | grep "total" | awk '{print $2}'`
Udisk=`df --total -h | grep "total" | awk '{print $3}'| cut -c-3`
Pdisk=`df --total -h | grep "total" | awk '{print $5}'`
CPUload=`top -n1 | grep "%Cpu" | awk '{print $2}'`
boot=`who -b | cut -c29-`
lvm=`lsblk | grep "root" | awk '{print $6}'`
if [ $lvm = "lvm" ]
then
	lvm="yes"
else
	lvm="no"
fi
tcp=`netstat -a | grep "tcp" | grep "ESTABLISHED" | wc -l`
users=`who | wc -l`
ip=`ip address show enp0s3 | grep "inet " | awk '{print $2}' | cut -d'/' -f1`
mac=`ip address show enp0s3 | grep "ether" | awk '{print $2}'`
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

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
us=`top -b -n1 | grep "%Cpu" | cut -d',' -f1 | cut -d' ' -f3`
usdec=`top -b -n1 | grep "%Cpu" | cut -d',' -f2 | cut -d' ' -f1`
sy=`top -b -n1 | grep "%Cpu" | cut -d',' -f3 | cut -d' ' -f3`
sydec=`top -b -n1 | grep "%Cpu" | cut -d',' -f4 | cut -d' ' -f1`
ni=`top -b -n1 | grep "%Cpu" | cut -d',' -f5 | cut -d' ' -f3`
nidec=`top -b -n1 | grep "%Cpu" | cut -d',' -f6 | cut -d' ' -f1`
wa=`top -b -n1 | grep "%Cpu" | cut -d',' -f9 | cut -d' ' -f3`
wadec=`top -b -n1 | grep "%Cpu" | cut -d',' -f10 | cut -d' ' -f1`
hi=`top -b -n1 | grep "%Cpu" | cut -d',' -f11 | cut -d' ' -f3`
hidec=`top -b -n1 | grep "%Cpu" | cut -d',' -f12 | cut -d' ' -f1`
si=`top -b -n1 | grep "%Cpu" | cut -d',' -f13 | cut -d' ' -f3`
sidec=`top -b -n1 | grep "%Cpu" | cut -d',' -f14 | cut -d' ' -f1`
st=`top -b -n1 | grep "%Cpu" | cut -d',' -f15 | cut -d' ' -f3`
stdec=`top -b -n1 | grep "%Cpu" | cut -d',' -f16 | cut -d' ' -f1`
CPUload=$(($us+$sy+$ni+$wa+$hi+$si+$st))
CPUloaddec=$(($usdec+$sydec+$nidec+$wadec+$hidec+$sidec+$stdec))
if [ $CPUloaddec -gt 10 ]
then
	CPUloaddec=$(($CPUloaddec-10))
	CPUload=$(($CPUload+1))
fi
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
sudo=`cat /var/log/sudo.log | grep "COMMAND" | wc -l`
touch print
echo \#Architecture: $archi >> print
echo \#CPU Physical: $pCPU >> print
echo \#vCPU: $vCPU >> print
echo \#Memory Usage: $Umem/$Tmem'MB' '('$Pmem'%)' >> print
echo \#Disk Usage: $Udisk/$Tdisk '('$Pdisk')' >> print
echo \#Cpu load: $CPUload% >> print
echo \#Last Boot: $boot >> print
echo \#LVM Use: $lvm >> print
echo \#Connexions TCP: $tcp ESTABLISHED >> print
echo \#User Log: $users >> print
echo \#Network: IP $ip '('$mac')' >> print
echo \#Sudo: $sudo cmd >> print
wall print
rm print

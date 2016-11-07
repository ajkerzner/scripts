#!/bin/bash

 echo "Alex's experimental install script"

 pre="[MPI_INSTALL]"

 echo -n "$pre Which machine is this? [0=boss, 1=worker1, 2=worker2, 3=worker3] "
 hostopt0="mario"
 ipopt0="192.168.1.29"
 hostopt1="luigi"
 ipopt1="192.168.1.30"
 hostopt2="toad"
 ipopt2="192.168.1.31"
 hostopt3="peach"
 ipopt3="192.168.1.32"

 read machine_id
 case $machine_id in
   0)
     newhost="$hostopt0"
     newipaddr="$ipopt0"
     ;;
   1)
     newhost="$hostopt1"
     newipaddr="$ipopt1"
     ;;
   2)
     newhost="$hostopt2"
     newipaddr="$ipopt2"
     ;;
   3)
     newhost="$hostopt3"
     newipaddr="$ipopt3"
     ;;
   *)
     echo "$pre Invalid option '$machine_id', exiting."
     exit 1
     ;;
 esac


 echo "$pre Configuration: host=$newhost, ipaddr=$newipaddr"




 echo "$pre USER INPUT REQUIRED"
 echo "$pre Installing python-mpi4py, python-numpy, and python-pandas"
 sudo apt-get install python-mpi4py python-numpy python-pandas

 echo "$pre Changing host to '$newhost'"

 echo "$pre modifying /etc/hosts"
 sudo sed -i "s/\(127\.0\.1\.1\s*\)raspberrypi/\1$newhost/" /etc/hosts

 if [ $machine_id -eq 0 ]
 then
   echo "$pre Adding additional machines for boss..."
   sudo echo "\n$ipopt1 $hostopt1" >> /etc/hosts
   sudo echo "$ipopt2 $hostopt2" >> /etc/hosts
   sudo echo "$ipopt3 $hostopt3" >> /etc/hosts
 fi

 echo "$pre modifying /etc/hostname"
 echo "$newhost" | sudo tee /etc/hostname

 echo "$pre setting hostname with hostname command"
 sudo hostname "$newhost"

 echo "$pre Backing up /etc/network/interfaces to /etc/network/interfaces.bak"
 sudo cp /etc/network/interfaces /etc/network/interfaces.bak



 echo "$pre Modifying /etc/network/interfaces"
 sudo sed -i "s/\(iface eth0 inet\) manual/auto eth0\n\1 static\naddress $newipaddr \nnetmask 255.255.255.0\nnetwork 192.168.1.0\nbroadcast 192.168.1.255\ngateway 192.168.1.254/"     /etc/network/interfaces

 
 echo "$pre End of part 1. The system will now reboot."
 echo "$pre RUN PART 2 WHEN THE SYSTEM IS BACK ONLINE"
 sudo reboot now
 
 
 

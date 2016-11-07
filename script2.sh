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

 echo "$pre Part 2: begin"

echo "$pre Checking if ~/.ssh exists"
 if [ ! -d "/home/pi/.ssh" ]
 then
   echo "$pre Directory does not exist. Creating..."
   sudo install -d -m 700 /home/pi/.ssh
   sudo chown pi:pi /home/pi/.ssh
 fi

 echo "$pre Verifying that ~/.ssh/authorized_keys exists"
 touch /home/pi/.ssh/authorized_keys

 if [ $machine_id -eq 0 ]
 then
   echo "$pre Generating keys for boss..."
   cd /home/pi/.ssh
   ssh-keygen -t rsa -C "$hostopt0" -f "/home/pi/.ssh/id_rsa" -N ''
 
   echo "$pre Copying key to workers..."
   cd /home/pi
   echo "$pre USER INPUT REQUIRED"
   cat /home/pi/.ssh/id_rsa.pub | ssh pi@"$ipopt1" 'cat >> /home/pi/.ssh/authorized_keys'
   cat /home/pi/.ssh/id_rsa.pub | ssh pi@"$ipopt2" 'cat >> /home/pi/.ssh/authorized_keys'
   cat /home/pi/.ssh/id_rsa.pub | ssh pi@"$ipopt3" 'cat >> /home/pi/.ssh/authorized_keys'


 echo "$pre Checking if ~/mpi4py directory exists..."
 if [ ! -d "/home/pi/mpi4py" ]
 then
 
   echo "$pre Creating ~/mpi4py directory..."
   mkdir /home/pi/mpi4py
 fi
   

   echo "$pre Creating machinefile at ~/mpi4py/workers..."
   echo "$ipopt0" > /home/pi/mpi4py/workers
   echo "$ipopt1" >> /home/pi/mpi4py/workers
   echo "$ipopt2" >> /home/pi/mpi4py/workers
   echo "$ipopt3" >> /home/pi/mpi4py/workers

   echo "$pre Creating beginner's script..."
   cd /home/pi/mpi4py
   echo 'from mpi4py import MPI' > helloworld.py
   echo 'import sys' >> helloworld.py
   echo 'size = MPI.COMM_WORLD.Get_size()' >> helloworld.py
   echo 'rank = MPI.COMM_WORLD.Get_rank()' >> helloworld.py
   echo 'name = MPI.Get_processor_name()' >> helloworld.py
   echo 'sys.stdout.write("Hello world! I am process %d of %d on %s.\n" % (rank,size,name))' >> helloworld.py
   sudo chmod a+rwx helloworld.py
   sudo chown pi:pi helloworld.py

   echo "$pre ...done creating python script."


   echo "$pre Preparing $hostopt1..."
   ssh pi@"$ipopt1" "cd ~; mkdir mpi4py"
   scp /home/pi/mpi4py/helloworld.py pi@"$ipopt1":/home/pi/mpi4py

   echo "$pre Preparing $hostopt2..."
   ssh pi@"$ipopt2" "cd ~; mkdir mpi4py"
   scp /home/pi/mpi4py/helloworld.py pi@"$ipopt2":/home/pi/mpi4py

   echo "$pre Preparing $hostopt3..."
   ssh pi@"$ipopt3" "cd ~; mkdir mpi4py"
   scp /home/pi/mpi4py/helloworld.py pi@"$ipopt3":/home/pi/mpi4py

   echo "$pre Okay, it should be done!"
 fi

 echo "$pre Rebooting is recommended, but [probably] optional."
 #sudo reboot now
 
 
 

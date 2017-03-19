# scripts

This contains scripts to prepare a raspberry pi cluster for MPI-based distributed programming in python.

The actual commands executed by this script were provided by the instruction sheet.
If you have no idea what this is, leave.


This is a set of bash scripts.

"script.sh" - the original script. WILL NOT WORK.

"script1.sh" - part 1 of the script.

"script2.sh" - part 2 of the script.


Directions:

1. Connect the ethernet switch to the network (plug in the cable).
2. Verify that the hostname on each raspberry pi is "raspberrypi".
3. Edit the script to customize the different ip addresses and hostnames.
4. Run "script1.sh" on the workers and the boss.
5. Disconnect the ethernet switch from the network.
6. Run "script2.sh" on the workers.
7. Run "script2.sh" on the boss.
8. Test the raspberry pi cluster.

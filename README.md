# scripts

This contains scripts to prepare a raspberry pi cluster for MPI-based distributed programming in python.

This is a set of bash scripts.

"script.sh" - the original script. NOT GUARANTEED TO WORK.

"script1.sh" - part 1 of the script.
"script2.sh" - part 2 of the script.


Directions:

1. run "script1.sh" on the workers, then disconnect from the network.
2. run "script2.sh" on the workers.
3. run "script1.sh" on the boss, then disconnect from the network.
4. run "script2.sh" on the boss.

#!/bin/sh
qsub -cwd -l h_rt=0:20:0 -V -o "/dev/null" -e $RESULTS"/"$12"/errors/runErrors.out" initKmc.sh

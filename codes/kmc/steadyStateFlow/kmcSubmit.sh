#!/bin/bash
#
# Made with a little help from Pat
#
#$ -cwd -V
#$ -l h_rt=00:20:00
#$ -R y


#!/bin/sh
mkdir -p $RESULTS/steadyStateFlow/blinkTest3/0
qsub -cwd -l h_rt=0:20:0 -V -e $RESULTS"/"$12"/errors/runErrors.out" /usr/bin/python steadyStateFlow.py 1.0 0.0 0.5 60 1 1000000 1.0 0.0 $RESULTS/steadyStateFlow/blinkTest3/0

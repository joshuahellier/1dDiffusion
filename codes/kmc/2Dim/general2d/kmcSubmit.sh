#!/bin/bash
#
# Made with a little help from Pat
#
qsub -t 1-4096 -e "/home/s1373240/research/results/errors" -o "/dev/null"  -cwd -l h_rt=10:00:00 kmcJobArray.sh "jobInputs/testInput"

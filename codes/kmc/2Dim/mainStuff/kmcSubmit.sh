#!/bin/bash
#
# Made with a little help from Pat
#
qsub -t 3073-4096 -e "/home/s1373240/research/results/errors" -o "/dev/null"  -cwd -l h_rt=24:00:00 kmcJobArray.sh "jobInputs/testInput"

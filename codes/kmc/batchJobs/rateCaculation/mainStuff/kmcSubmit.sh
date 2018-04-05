#!/bin/bash
#
# Made with a little help from Pat
#
qsub -t 3-384 -e "/home/s1373240/research/results/errors" -o "/dev/null"  -cwd -l h_rt=14:00:00 kmcJobArray.sh "jobInputs/testInput"

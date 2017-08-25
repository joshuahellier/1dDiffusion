#!/bin/bash
#
# Made with a little help from Pat
#
qsub -t 3-3456 -e "/home/s1373240/research/results/errors" -o "/dev/null"  -cwd -l h_rt=30:00:00 kmcJobArray.sh "jobInputs/testInput"

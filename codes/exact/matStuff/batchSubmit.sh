#!/bin/bash
#
# Made with a little help from Pat
#
qsub -t 1-1024 -e "/home/s1373240/research/results/errors" -o "/dev/null"  -cwd -l h_rt=1:00:00 batchJobArray.sh "jobInputs/testInput"

#!/bin/bash
#
# Made with a little help from Pat
#
qsub -l h_vmem=4G -t 10000-16384 -o "/dev/null" -e "/dev/null"  -cwd -l h_rt=02:00:00 batchJobArray.sh "jobInputs/testInput"

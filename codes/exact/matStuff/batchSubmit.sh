#!/bin/bash
#
# Made with a little help from Pat
#
qsub -l h_vmem=4G -t 1-1024 -e "/dev/null" -o "/dev/null"  -cwd -l h_rt=01:00:00 batchJobArray.sh "jobInputs/testInput"

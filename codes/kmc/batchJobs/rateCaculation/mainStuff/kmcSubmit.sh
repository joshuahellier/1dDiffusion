#!/bin/bash
#
# Made with a little help from Pat
#
qsub -t 1-1024 -e "/dev/null" -o "/dev/null"  -cwd -l h_rt=00:10:00 kmcJobArray.sh "jobInputs/testInput"

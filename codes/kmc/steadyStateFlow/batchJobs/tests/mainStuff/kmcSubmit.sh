#!/bin/bash
#
# Made with a little help from Pat
#
qsub -t 1-256 -cwd -o "/dev/null" -e "/dev/null"  -l h_rt=04:00:00 kmcJobArray.sh "jobInputs/testInput"

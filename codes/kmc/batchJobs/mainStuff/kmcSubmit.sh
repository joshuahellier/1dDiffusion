#!/bin/bash
#
# Made with a little help from Pat
#
qsub -t 3-4608 -cwd -e "/dev/null" -o "/dev/null"  -l h_rt=08:00:00 kmcJobArray.sh "jobInputs/testInput"

#!/bin/bash
#
# Made with a little help from Pat
#
qsub -t 2-288 -o "/dev/null" -e "/dev/null"  -cwd -l h_rt=00:03:00 kmcJobArray.sh "jobInputs/testInput"

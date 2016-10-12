#!/bin/bash
#
# Made with a little help from Pat
#
qsub -t 255-2304 -cwd -o "/dev/null" -e "/dev/null"  -l h_rt=00:30:00 kmcJobArray.sh "jobInputs/testInput"

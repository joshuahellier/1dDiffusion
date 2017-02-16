#!/bin/bash
#
# Made with a little help from Pat
#
qsub -t 3-4608 -e "/dev/null" -o "/dev/null" -cwd -l h_rt=30:00:00 kmcJobArray.sh "jobInputs/testInput"

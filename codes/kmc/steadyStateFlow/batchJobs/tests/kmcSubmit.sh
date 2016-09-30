#!/bin/bash
#
# Made with a little help from Pat
#
qsub -t 0-2 -cwd -o /dev/null -e /dev/null -l h_rt=00:10:00 kmcJobArray.sh "jobInputs/testInput"

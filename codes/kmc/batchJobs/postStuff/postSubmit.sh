#!/bin/bash
#
# Made with a little help from Pat
#
qsub -t 1-216 -cwd -o "/dev/null" -e "/dev/null"  -l h_rt=00:30:00 postJobArray.sh "postProcInputs/postProcInput"

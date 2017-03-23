#!/bin/bash
#
# Made with a little help from Pat
#
qsub -t 3-288 -cwd -e "/dev/null" -o "/dev/null"  -l h_rt=00:15:00 postJobArray.sh "postProcInputs/postProcInput"

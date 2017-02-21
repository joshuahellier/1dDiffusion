#!/bin/bash
#
# Made with a little help from Pat
#
qsub -t 3-288 -o "/dev/null" -e "/dev/null" -cwd -l h_rt=00:5:00 postJobArray.sh "postProcInputs/postInput"

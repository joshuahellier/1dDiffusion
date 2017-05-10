#!/bin/bash
#
# Made with a little help from Pat
#
qsub -t 1-288 -o "/dev/null" -e "/dev/null" -cwd -l h_rt=02:00:00 postJobArray.sh "postProcInputs/postInput"

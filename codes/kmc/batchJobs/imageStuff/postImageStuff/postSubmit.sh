##!/bin/bash
#
# Made with a little help from Pat
#
qsub -t 1-10 -o "/dev/null" -e "/dev/null" -cwd -l h_rt=00:10:00 postJobArray.sh "postProcInputs/postInput"

#!/bin/bash
#
# Made with a little help from Pat
#
qsub -t 1-2048 -cwd -o "/dev/null" -e "/dev/null"  -l h_rt=08:00:00 kmcJobArray.sh "postProcInputsInputs/postProcInput"

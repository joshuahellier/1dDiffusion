#!/bin/bash
#
# Made with a little help from Pat
#
qsub -t 4002-6912 -e "/home/s1373240/errorLogs/" -o "/dev/null"  -cwd -l h_rt=6:00:00 kmcJobArray.sh "jobInputs/testInput"

#!/bin/bash
#
# Made with a little help from Pat
#
qsub -t 1459-6912 -e "/exports/eddie/scratch/s1373240/results/errors/" -o "/dev/null"  -cwd -l h_rt=24:00:00 kmcJobArray.sh "jobInputs/testInput"

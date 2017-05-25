#!/bin/bash
#
# Made with a little help from Pat
#
qsub -t 1-1440 -o "/dev/null" -e "/exports/eddie/scratch/s1373240/results/batchJobs/imagingRuns/errors"  -cwd -l h_rt=04:00:00 kmcJobArray.sh "jobInputs/testInput"

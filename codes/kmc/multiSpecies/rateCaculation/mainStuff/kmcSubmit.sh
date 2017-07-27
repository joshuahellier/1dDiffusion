#!/bin/bash
#
# Made with a little help from Pat
#
qsub -t 1-11 -e "$RESULTS/batchJobs/mainRuns/errors/attempt6b" -o "/dev/null"  -cwd -l h_rt=30:00:00 kmcJobArray.sh "jobInputs/testInput"

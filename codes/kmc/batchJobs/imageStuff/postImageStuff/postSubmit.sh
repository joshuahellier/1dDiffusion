#!/bin/bash
#
# Made with a little help from Pat
#
qsub -t 1-288 -o "/exports/eddie/scratch/s1373240/results/batchJobs/imagingRuns/outputs" -e "/exports/eddie/scratch/s1373240/results/batchJobs/imagingRuns/errors" -cwd -l h_rt=06:00:00 postJobArray.sh "postProcInputs/postInput"

#!/bin/bash
#
# Made with a little help from Pat
#
qsub -t 1-2 -cwd -l h_rt=00:00:10 testJob.array.sh testData

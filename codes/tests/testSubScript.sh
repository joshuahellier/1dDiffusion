#!/bin/bash
#
# Made with a little help from Pat
#
#$ -cwd -V
#$ -l h_rt=00:1:00
#$ 
qsub -t 1-2 testJob.array.sh data

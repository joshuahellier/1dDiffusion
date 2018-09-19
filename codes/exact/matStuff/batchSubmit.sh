#!/bin/bash
#
# Made with a little help from Pat
#
qsub -l h_vmem=4G -t 2000-2000  -cwd  -l h_rt=01:00:00 batchJobArray.sh "jobInputs/testInput"

#!/bin/bash
#
# Made with a little help from Pat
#
qsub -t 1-2342 -e "/exports/csce/eddie/ph/groups/eddie_physics_ifp_dmarendu_01/s1373240/results/batchJobs/concRuns/errors" -o "/exports/csce/eddie/ph/groups/eddie_physics_ifp_dmarendu_01/s1373240/results/batchJobs/concRuns/outputs"  -cwd -l h_rt=30:00:00 kmcJobArray.sh "jobInputs/testInput"

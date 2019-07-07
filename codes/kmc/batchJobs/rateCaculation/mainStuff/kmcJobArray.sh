#!/bin/sh
if [ `expr $(df --output=pcent /exports/eddie/scratch/s1373240/results | tail -1 | sed s/%//)` -gt 90 ]; then
   exit 99
fi
./initKmc.sh $1.$SGE_TASK_ID

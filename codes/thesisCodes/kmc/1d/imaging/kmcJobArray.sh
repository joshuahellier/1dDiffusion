#!/bin/sh
if [ `expr $(df --output=pcent /exports/eddie/scratch/ | tail -1 | sed s/%//)` -gt 110 ]; then
   exit 99
fi
./initKmc.sh $1.$SGE_TASK_ID

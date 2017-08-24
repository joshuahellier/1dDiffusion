#!/bin/sh
if [ `expr $(df --output=pcent /exports/csce/eddie/ph/groups/eddie_physics_ifp_dmarendu_01/s1373240/results | tail -1 | sed s/%//)` -gt 80 ]; then
   exit 99
fi
./initKmc.sh $1.$SGE_TASK_ID

#!/bin/sh
if [ `expr $(df --output=pcent /home/s1373240/research/results | tail -1 | sed s/%//)` -gt 95 ]; then
   exit 99
fi

. /etc/profile.d/modules.sh
module load python

./initBatch.sh $1.$SGE_TASK_ID

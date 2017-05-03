#!/bin/bash

# To be honest, don't use this script, it sucks!

set -bm

startjob() {
    python 1dCustomIntInput.py $arg1 $arg2 $arg3 $arg4 $arg5 $arg6 $arg7  > /dev/null 2>&1 &
}

max_parallel=5
total_jobs=100
avConc=500
maxDiff=1000
diffInc=$((maxDiff / total_jobs))
rateConstFull=1000
transTime=100000000
fileInfo=''
numSteps=1000000
sysSize=20
fileInfo+='/bigRun/'
arg1=$avConc
arg3=$rateConstFull
arg4=$sysSize
arg5=$numSteps
arg6=$transTime

count=0
started=0

parallelLim=$(($max_parallel-1))
jobsLim=$(($total_jobs-1))

while [ $started -lt $total_jobs ];
        do
                count=0
                while [ $count -lt $parallelLim ] && [ $started -lt $jobsLim ]
                        do
                                tracker=$((diffInc * started))
                                arg2=$tracker
                                destination=$fileInfo
                                destination+=$tracker
                                arg7=$destination
                                python 1dCustomIntInput.py $arg1 $arg2 $arg3 $arg4 $arg5 $arg6 $arg7  > /dev/null 2>&1 &
                                started=$(($started+1))
                        done
                tracker=$((diffInc * started))
                arg2=$tracker
                destination=$fileInfo
                destination+=$tracker
                arg7=$destination
                python 1dCustomIntInput.py $arg1 $arg2 $arg3 $arg4 $arg5 $arg6 $arg7
                started=$(($started+1))
                printf "Done $started of $total_jobs \n"
        done


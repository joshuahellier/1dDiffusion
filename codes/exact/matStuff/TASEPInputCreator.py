import subprocess
import sys
import os
import math

# This code is meant to manage running multiple instances of my KMCLib codes at the same time,
# in the name of time efficiency
numConfigs = 2048
sysSize = 14
numVecs = 8
dataLocation = "exactSolns/TASEP/largeReInitialCut/"
minDiff = 10.0**(-3)
maxVal = 2.0
diffStepSize = (maxVal-2.0*minDiff)/float(numConfigs-1)
jobIndex = 1
tolerance = 10.0**(-16)
runningJobs = []

for rateIndex in range(0, numConfigs):
    tempRateDiff = minDiff + diffStepSize*rateIndex
    botLoad = tempRateDiff
    topUnload = maxVal - botLoad
    jobInput = "sparseTASEP.py "+str(botLoad)+" "+str(topUnload)+" "+str(sysSize)+" "+str(numVecs)+" "+str(tolerance)+" "+dataLocation+str(rateIndex)+"\n"
    with open("jobInputs/testInput."+str(jobIndex), 'w') as f:
        f.write(jobInput)
        jobIndex += 1

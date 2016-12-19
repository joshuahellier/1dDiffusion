import subprocess
import sys
import os

# This code is meant to manage running multiple instances of my KMCLib codes at the same time,
# in the name of time efficiency
numConcs = 24
numLambda = 12
numImageSteps=1000000
dataLocation = "batchJobs/mainRuns/attempt6"
newWriteLocation = "batchJobs/imagingRuns/attempt6"

jobIndex = 1

runningJobs = []

for rateIndex in range(0, numLambda):
    currentRate = lambdaMin + rateStepSize*rateIndex
    for concIndex in range(0, numConcs):
        currentConc = concMin + concStepSize*concIndex
        jobInput = "newPostProcIm.py "+str(numImageSteps)+" "+dataLocation+str(rateIndex)+"/"+str(concIndex)+"/"+str(0)+" "+newWriteLocation+str(rateIndex)+"/"+str(concIndex)+"/"+str(0)+"\n"
            with open("jobInputs/testInput."+str(jobIndex), 'w') as f:
                f.write(jobInput)
        jobIndex += 1

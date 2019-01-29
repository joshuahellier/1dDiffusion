import subprocess
import sys
import os

# This code is meant to manage running multiple instances of my KMCLib codes at the same time,
# in the name of time efficiency
numConcDiff = 5
numConcs = 5
numLambda = 2
numStepsEquilib = 10000000
numImageSteps = 1000000
sysSize = 508
analInterval = 1
numPasses = 10
timeInterval = 0.1
dataLocation = "batchJobs/imagingRuns/attempt6f/"
lambdaMin = 1.00
lambdaMax = 2.0
concDiff = 0.1
rateStepSize = (lambdaMax-lambdaMin)/float(numLambda-1)
concMax = 0.94
concMin = 0.06
concStepSize = (concMax-concMin)/float(numConcs-1)

jobIndex = 1

runningJobs = []

for rateIndex in range(0, numLambda):
    currentRate = lambdaMin + rateStepSize*rateIndex
    for concIndex in range(0, numConcs):
        currentConc = concMin + concStepSize*concIndex
        for concDiffIndex in [0]:
            botConc = currentConc - 0.5*concDiff
            topConc = currentConc + 0.5*concDiff
            jobInput = "steadyFlowImager.py "+str(botConc)+" "+str(topConc)+" "+str(currentRate)+" "+str(sysSize)+" "+str(numImageSteps)+" "+str(numStepsEquilib)+" "+str(timeInterval)+" "+dataLocation+str(rateIndex)+"/"+str(concIndex)+"/"+str(concDiffIndex)+"\n"
            with open("jobInputs/testInput."+str(jobIndex), 'w') as f:
                f.write(jobInput)
            jobIndex += 1

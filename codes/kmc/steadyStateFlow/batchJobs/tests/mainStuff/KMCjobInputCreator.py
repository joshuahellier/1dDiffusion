import subprocess
import sys
import os

# This code is meant to manage running multiple instances of my KMCLib codes at the same time,
# in the name of time efficiency
numConcDiff = 8
numConcs = 16
numLambda = 8
numStepsEquilib = 10000000
numStepsAnal = 5000000
numStepsSnapshot = 100000
numStepsReq = 5000000
sysSize = 120
analInterval = 1
numPasses = 8
timeInterval = 10.0
dataLocation = "batchJobs/tests/test3/"
lambdaMin = 0.01
lambdaMax = 0.5
concDiffMin = -0.1
concDiffMax = 0.1
rateStepSize = (lambdaMax-lambdaMin)/float(numLambda-1)
diffStepSize = (concDiffMax - concDiffMin)/float(numConcDiff-1)
concMax = 0.94
concMin = 0.06
concStepSize = (concMax-concMin)/float(numConcs-1)

jobIndex = 1

runningJobs = []

for rateIndex in range(0, numLambda):
    currentRate = lambdaMin + rateStepSize*rateIndex
    for concIndex in range(0, numConcs):
        currentConc = concMin + concStepSize*concIndex
        for concDiffIndex in range(0, numConcs):
            currentConcDiff = diffStepSize*concDiffIndex + concDiffMin
            botConc = currentConc - 0.5*currentConcDiff
            topConc = currentConc + 0.5*currentConcDiff
            jobInput = "steadyStateFlow.py "+str(botConc)+" "+str(topConc)+" "+str(currentRate)+" "+str(sysSize)+" "+str(analInterval)+" "+str(numStepsEquilib)+" "+str(numStepsSnapshot)+" "+str(numStepsAnal)+" "+str(numStepsReq)+" "+str(numPasses)+" "+str(timeInterval)+" "+dataLocation+str(rateIndex)+"/"+str(concIndex)+"/"+str(concDiffIndex)+"\n"
            with open("jobInputs/testInput."+str(jobIndex), 'w') as f:
                f.write(jobInput)
            jobIndex += 1

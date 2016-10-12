import subprocess
import sys
import os

# This code is meant to manage running multiple instances of my KMCLib codes at the same time,
# in the name of time efficiency
numConcDiff = 8
numConcs = 12
numLambda = 24
numStepsEquilib = 5000000
numStepsAnal = 1000000
numStepsSnapshot = 1000
numStepsReq = 1000000
sysSize = 252
analInterval = 1
numPasses = 10
timeInterval = 10.0
dataLocation = "batchJobs/mainRuns/attempt1"
lambdaMin = 0.01
lambdaMax = 1.5
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
        for concDiffIndex in range(0, numConcDiff):
            currentConcDiff = diffStepSize*concDiffIndex + concDiffMin
            botConc = currentConc - 0.5*currentConcDiff
            topConc = currentConc + 0.5*currentConcDiff
            jobInput = "steadyStateFlow.py "+str(botConc)+" "+str(topConc)+" "+str(currentRate)+" "+str(sysSize)+" "+str(analInterval)+" "+str(numStepsEquilib)+" "+str(numStepsSnapshot)+" "+str(numStepsAnal)+" "+str(numStepsReq)+" "+str(numPasses)+" "+str(timeInterval)+" "+dataLocation+str(rateIndex)+"/"+str(concIndex)+"/"+str(concDiffIndex)+"\n"
            with open("jobInputs/testInput."+str(jobIndex), 'w') as f:
                f.write(jobInput)
            jobIndex += 1

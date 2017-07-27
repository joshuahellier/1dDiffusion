import subprocess
import sys
import os

# This code is meant to manage running multiple instances of my KMCLib codes at the same time,
# in the name of time efficiency
numConcDiff = 16
numConcs = 24
numLambda = 12
numStepsEquilib = 160000000
numStepsAnal = 80000000
numStepsSnapshot = 1000
numStepsReq = 16000000
sysSize = 124
analInterval = 1
numPasses = 10
timeInterval = 100.0
dataLocation = "batchJobs/mainRuns/attempt6b/"
lambdaMin = 0.05
lambdaMax = 1.2
concDiffMin = -0.05
concDiffMax = 0.05
rateStepSize = (lambdaMax-lambdaMin)/float(numLambda-1)
diffStepSize = (concDiffMax - concDiffMin)/float(numConcDiff-1)
concMax = 0.97
concMin = 0.03
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
            jobInput = "newSteadyFlow.py "+str(botConc)+" "+str(topConc)+" "+str(currentRate)+" "+str(sysSize)+" "+str(analInterval)+" "+str(numStepsEquilib)+" "+str(numStepsSnapshot)+" "+str(numStepsAnal)+" "+str(numStepsReq)+" "+str(numPasses)+" "+str(timeInterval)+" "+dataLocation+str(rateIndex)+"/"+str(concIndex)+"/"+str(concDiffIndex)+"\n"
            with open("jobInputs/testInput."+str(jobIndex), 'w') as f:
                f.write(jobInput)
            jobIndex += 1

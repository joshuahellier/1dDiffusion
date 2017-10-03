import subprocess
import sys
import os

# This code is meant to manage running multiple instances of my KMCLib codes at the same time,
# in the name of time efficiency
numConcs = 64
numLambda = 64
numStepsEquilib = 400000
numStepsAnal = 16000
numStepsSnapshot = 1000
numStepsReq = 16000
sysSize = 64
analInterval = 1
numPasses = 10000
timeInterval = 1.0
dataLocation = "batchJobs/concRuns/constDensSlice2/"
lambdaMin = 0.01
lambdaMax = 0.75
rateStepSize = (lambdaMax-lambdaMin)/float(numLambda-1)
concMax = 1.0-0.01
concMin = 0.01
concStepSize = (concMax-concMin)/float(numConcs-1)

jobIndex = 1

runningJobs = []

for rateIndex in range(0, numLambda):
    currentRate = lambdaMin + rateStepSize*rateIndex
    for botConcIndex in range(0, numConcs):
        botConc = concMin + concStepSize*botConcIndex
        topConc = 1.0 - botConc
        jobInput = "concFlow.py "+str(botConc)+" "+str(topConc)+" "+str(currentRate)+" "+str(sysSize)+" "+str(analInterval)+" "+str(numStepsEquilib)+" "+str(numStepsSnapshot)+" "+str(numStepsAnal)+" "+str(numStepsReq)+" "+str(numPasses)+" "+str(timeInterval)+" "+dataLocation+str(rateIndex)+"/"+str(botConcIndex)+"\n"
        with open("jobInputs/testInput."+str(jobIndex), 'w') as f:
            f.write(jobInput)
        jobIndex += 1

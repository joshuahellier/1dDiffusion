import subprocess
import sys
import os

# This code is meant to manage running multiple instances of my KMCLib codes at the same time,
# in the name of time efficiency
numConcs = 24
numLambda = 6
numStepsEquilib = 16000
numStepsAnal = 8000
numStepsSnapshot = 1000
numStepsReq = 16000
sysSize = 124
analInterval = 1
numPasses = 50
timeInterval = 1.0
dataLocation = "batchJobs/concRuns/tests/test1"
lambdaMin = 0.05
lambdaMax = 0.25
rateStepSize = (lambdaMax-lambdaMin)/float(numLambda-1)
concMax = 0.99
concMin = 0.01
concStepSize = (concMax-concMin)/float(numConcs-1)

jobIndex = 1

runningJobs = []

for rateIndex in range(0, numLambda):
    currentRate = lambdaMin + rateStepSize*rateIndex
    for botConcIndex in range(0, numConcs):
        botConc = concMin + concStepSize*botConcIndex
        for topConcIndex in range(0, numConcs):
            topConc = concMin + concStepSize*topConcIndex
            jobInput = "concFlow.py "+str(botConc)+" "+str(topConc)+" "+str(currentRate)+" "+str(sysSize)+" "+str(analInterval)+" "+str(numStepsEquilib)+" "+str(numStepsSnapshot)+" "+str(numStepsAnal)+" "+str(numStepsReq)+" "+str(numPasses)+" "+str(timeInterval)+" "+dataLocation+str(rateIndex)+"/"+str(botConcIndex)+"/"+str(topConcIndex)+"\n"
            with open("jobInputs/testInput."+str(jobIndex), 'w') as f:
                f.write(jobInput)
            jobIndex += 1

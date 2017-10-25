import subprocess
import sys
import os

# This code is meant to manage running multiple instances of my KMCLib codes at the same time,
# in the name of time efficiency
numConcs = 12
numLambda = 12
numStepsEquilib = 1600000
numStepsAnal = 16000
numStepsSnapshot = 1000
numStepsReq = 16000
sysWidth = 16
sysLength = 16
analInterval = 1
numPasses = 100
timeInterval = 1.0
dataLocation = "dim2Runs/attempt1/16x16/"
lambdaMin = 0.05
lambdaMax = 1.25
rateStepSize = (lambdaMax-lambdaMin)/float(numLambda-1)
concMax = 0.99
concMin = 0.01
concStepSize = (concMax-concMin)/float(numConcs-1)

jobIndex = 5185

runningJobs = []

for rateIndex in range(0, numLambda):
    currentRate = lambdaMin + rateStepSize*rateIndex
    for botConcIndex in range(0, numConcs):
        botConc = concMin + concStepSize*botConcIndex
        for topConcIndex in range(0, numConcs):
            topConc = concMin + concStepSize*topConcIndex
            jobInput = "2dSteadyFlow.py "+str(botConc)+" "+str(topConc)+" "+str(currentRate)+" "+str(sysWidth)+" "+str(sysLength)+" "+str(analInterval)+" "+str(numStepsEquilib)+" "+str(numStepsSnapshot)+" "+str(numStepsAnal)+" "+str(numStepsReq)+" "+str(numPasses)+" "+str(timeInterval)+" "+dataLocation+str(rateIndex)+"/"+str(botConcIndex)+"/"+str(topConcIndex)+"\n"
            with open("jobInputs/testInput."+str(jobIndex), 'w') as f:
                f.write(jobInput)
            jobIndex += 1

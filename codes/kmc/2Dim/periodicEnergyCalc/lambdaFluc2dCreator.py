import subprocess
import sys
import os

# This code is meant to manage running multiple instances of my KMCLib codes at the same time,
# in the name of time efficiency
numLambda = 512
numStepsEquilib = 16000000
numStepsAnal = 16000
numStepsSnapshot = 1000
numStepsReq = 640000
sysWidth = 16
sysLength = 64
analInterval = 1
numPasses = 256
timeInterval = 1.0
dataLocation = "dim2Runs/longEqCloseLook/16x64/"
lambdaMin = 0.01
lambdaMax = 0.75
rateStepSize = (lambdaMax-lambdaMin)/float(numLambda-1)
botConc = 0.75
topConc = 0.25

runningJobs = []
jobIndex = 3585

for rateIndex in range(0, numLambda):
    currentRate = lambdaMin + rateStepSize*rateIndex
    jobInput = "2dSteadyFlow.py "+str(botConc)+" "+str(topConc)+" "+str(currentRate)+" "+str(sysWidth)+" "+str(sysLength)+" "+str(analInterval)+" "+str(numStepsEquilib)+" "+str(numStepsSnapshot)+" "+str(numStepsAnal)+" "+str(numStepsReq)+" "+str(numPasses)+" "+str(timeInterval)+" "+dataLocation+str(rateIndex)+"\n"
    with open("jobInputs/testInput."+str(jobIndex), 'w') as f:
        f.write(jobInput)
        jobIndex += 1

import subprocess
import sys
import os

# This code is meant to manage running multiple instances of my KMCLib codes at the same time,
# in the name of time efficiency
numLambda = 512
numStepsEquilib = 1600000
numStepsAnal = 16000
numStepsSnapshot = 1000
numStepsReq = 16000
sysWidth = 32
sysLength = 32
analInterval = 1
numPasses = 100
timeInterval = 1.0
dataLocation = "dim2Runs/lambdaScan1/"
lambdaMin = 0.05
lambdaMax = 1.25
rateStepSize = (lambdaMax-lambdaMin)/float(numLambda-1)

runningJobs = []

for rateIndex in range(0, numLambda):
    currentRate = lambdaMin + rateStepSize*rateIndex
    botConc = 0.99
    topConc = 0.01
            jobInput = "2dSteadyFlow.py "+str(botConc)+" "+str(topConc)+" "+str(currentRate)+" "+str(sysWidth)+" "+str(sysLength)+" "+str(analInterval)+" "+str(numStepsEquilib)+" "+str(numStepsSnapshot)+" "+str(numStepsAnal)+" "+str(numStepsReq)+" "+str(numPasses)+" "+str(timeInterval)+" "+dataLocation+str(rateIndex)+"\n"
    with open("jobInputs/testInput."+str(jobIndex), 'w') as f:
        f.write(jobInput)
        jobIndex += 1

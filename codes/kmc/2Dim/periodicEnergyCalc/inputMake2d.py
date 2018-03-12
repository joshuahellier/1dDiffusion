import subprocess
import sys
import os
import math

# This code is meant to manage running multiple instances of my KMCLib codes at the same time,
# in the name of time efficiency
numConcs = 16
numLambda = 16
numStepsEquilib = 1600000
numStepsAnal = 512
numStepsReq = 4096
sysWidth = 16
sysLength = 16
analInterval = 1
numPasses = 10000
timeInterval = 1.0
aParam = 1.0
dataLocation = "/dim2Runs/periodic/periodicSmall/"
lambdaMin = 0.01
lambdaMax = 100.0
rateStepSize = (lambdaMax-lambdaMin)/float(numLambda-1)
concMax = 0.99
concMin = 0.01
concStepSize = (concMax-concMin)/float(numConcs-1)

jobIndex = 1

runningJobs = []

for rateIndex in range(0, numLambda):
    tempRate = lambdaMin + rateStepSize*rateIndex
    currentRate = (lambdaMax - lambdaMin)*(math.exp(aParam*(tempRate-lambdaMin)/(lambdaMax-lambdaMin))-1.0)/(math.exp(aParam)-1) + lambdaMin
    for concIndex in range(0, numConcs):
        conc = concMin + concStepSize*concIndex
        jobInput = "2dPeriodic.py "+str(conc)+" "+str(currentRate)+" "+str(sysWidth)+" "+str(sysLength)+" "+str(analInterval)+" "+str(numStepsEquilib)+" "+str(numStepsAnal)+" "+str(numStepsReq)+" "+str(numPasses)+" "+dataLocation+str(rateIndex)+"/"+str(concIndex)+"\n"
        with open("jobInputs/testInput."+str(jobIndex), 'w') as f:
            f.write(jobInput)
        jobIndex += 1

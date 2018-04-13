import subprocess
import sys
import os
import math

# This code is meant to manage running multiple instances of my KMCLib codes at the same time,
# in the name of time efficiency
numLambda = 1024
numStepsEquilib = 16000000
numStepsAnal = 16000
numStepsSnapshot = 1000
numStepsReq = 640000
sysWidth = 16
sysLength = 16
analInterval = 1
numPasses = 256
timeInterval = 1.0
dataLocation = "dim2Runs/wideScan/highDens/"
lambdaMin = 10.0**(-4)
lambdaMax = 10.0**(4)
rateStepSize = (lambdaMax-lambdaMin)/float(numLambda-1)
botConc = 0.9
topConc = 0.7

runningJobs = []
jobIndex = 2049

for rateIndex in range(0, numLambda):
    tempRate = lambdaMin + rateStepSize*rateIndex
    currentRate = math.exp(((tempRate-lambdaMin)*math.log(lambdaMax)+(lambdaMax-tempRate)*math.log(lambdaMin))/(lambdaMax-lambdaMin))
    jobInput = "2dSteadyFlow.py "+str(botConc)+" "+str(topConc)+" "+str(currentRate)+" "+str(sysWidth)+" "+str(sysLength)+" "+str(analInterval)+" "+str(numStepsEquilib)+" "+str(numStepsSnapshot)+" "+str(numStepsAnal)+" "+str(numStepsReq)+" "+str(numPasses)+" "+str(timeInterval)+" "+dataLocation+str(rateIndex)+"\n"
    with open("jobInputs/testInput."+str(jobIndex), 'w') as f:
        f.write(jobInput)
        jobIndex += 1

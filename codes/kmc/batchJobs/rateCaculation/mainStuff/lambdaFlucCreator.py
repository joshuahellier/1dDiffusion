import subprocess
import sys
import os
import math

# This code is meant to manage running multiple instances of my KMCLib codes at the same time,
# in the name of time efficiency
numLambda = 512
numStepsEquilib = 400000
numStepsAnal = 16000
numStepsSnapshot = 1000
numStepsReq = 16000
sysSize = 64
analInterval = 1
numPasses = 10000
timeInterval = 1.0
dataLocation = "batchJobs/concRuns/highLambdaScan1/"
lambdaMin = 0.7
lambdaMax = 30.0
aParam = 1.0
rateStepSize = (lambdaMax-lambdaMin)/float(numLambda-1)
jobIndex = 1

runningJobs = []

for rateIndex in range(0, numLambda):
    tempRate = lambdaMin + rateStepSize*rateIndex
    currentRate = (lambdaMax - lambdaMin)*(math.exp(aParam*(tempRate-lambdaMin)/(lambdaMax-lambdaMin))-1.0)/(math.exp(aParam)-1) + lambdaMin
    botConc = 0.75
    topConc = 0.25
    jobInput = "concFlow.py "+str(botConc)+" "+str(topConc)+" "+str(currentRate)+" "+str(sysSize)+" "+str(analInterval)+" "+str(numStepsEquilib)+" "+str(numStepsSnapshot)+" "+str(numStepsAnal)+" "+str(numStepsReq)+" "+str(numPasses)+" "+str(timeInterval)+" "+dataLocation+str(rateIndex)+"\n"
    with open("jobInputs/testInput."+str(jobIndex), 'w') as f:
        f.write(jobInput)
        jobIndex += 1

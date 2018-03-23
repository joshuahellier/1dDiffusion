import subprocess
import sys
import os
import math

# This code is meant to manage running multiple instances of my KMCLib codes at the same time,
# in the name of time efficiency
numLambda = 1024
numStepsEquilib = 16**6
numStepsAnal = 16**4
numStepsReq = 16**5
sysWidth = 16
sysLength = 16
sysDepth = 16
analInterval = 1
numPasses = 256
dataLocation = "dim3Runs/lambdaFluc/lambdaFluc1/"
lambdaMin = 0.001
lambdaMax = 1000.0
rateStepSize = (lambdaMax-lambdaMin)/float(numLambda-1)
avConc = 0.5
aParam = 4.0

runningJobs = []
jobIndex = 1

for rateIndex in range(0, numLambda):
    tempRate = lambdaMin + rateStepSize*rateIndex
    currentRate = (lambdaMax - lambdaMin)*(math.exp(aParam*(tempRate-lambdaMin)/(lambdaMax-lambdaMin))-1.0)/(math.exp(aParam)-1) + lambdaMin
    jobInput = "3dPeriodic.py "+str(avConc)+" "+str(currentRate)+" "+str(sysWidth)+" "+str(sysLength)+" "+str(sysDepth)+" "+str(analInterval)+" "+str(numStepsEquilib)+" "+" "+str(numStepsAnal)+" "+str(numStepsReq)+" "+str(numPasses)+" "+dataLocation+str(rateIndex)+"\n"
    with open("jobInputs/testInput."+str(jobIndex), 'w') as f:
        f.write(jobInput)
        jobIndex += 1

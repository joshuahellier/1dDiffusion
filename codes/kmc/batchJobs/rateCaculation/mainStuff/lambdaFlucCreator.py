import subprocess
import sys
import os
import math

# This code is meant to manage running multiple instances of my KMCLib codes at the same time,
# in the name of time efficiency
numLambda = 32
numStepsEquilib = 4000000
numStepsAnal = 16000
numStepsSnapshot = 1000
numStepsReq = 16000
sysSize = 256
analInterval = 1
numPasses = 10000
timeInterval = 1.0
dataLocation = "batchJobs/concRuns/newLambdaScans/lambdaScan4Repeats/size256/"
lambdaMin = 0.01
lambdaMax = 0.25
aParam = 1.0
rateStepSize = (lambdaMax-lambdaMin)/float(numLambda-1)
jobIndex = 545
botConc = 3.0/4.0
topConc = 7.0/12.0
runningJobs = []

for rateIndex in range(0, numLambda):
    tempRate = lambdaMin + rateStepSize*rateIndex
    currentRate = tempRate
#    currentRate = math.exp(((tempRate-lambdaMin)*math.log(lambdaMax)+(lambdaMax-tempRate)*math.log(lambdaMin))/(lambdaMax-lambdaMin))
    jobInput = "concFlow.py "+str(botConc)+" "+str(topConc)+" "+str(currentRate)+" "+str(sysSize)+" "+str(analInterval)+" "+str(numStepsEquilib)+" "+str(numStepsSnapshot)+" "+str(numStepsAnal)+" "+str(numStepsReq)+" "+str(numPasses)+" "+str(timeInterval)+" "+dataLocation+str(rateIndex)+"\n"
    with open("jobInputs/testInput."+str(jobIndex), 'w') as f:
        f.write(jobInput)
        jobIndex += 1

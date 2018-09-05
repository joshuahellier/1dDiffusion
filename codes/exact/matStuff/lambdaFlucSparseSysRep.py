import subprocess
import sys
import os
import math

# This code is meant to manage running multiple instances of my KMCLib codes at the same time,
# in the name of time efficiency
numLambda = 2048
sysSize = 10
numVecs = 16
dataLocation = "exactSolns/compScanRepeats/low/"
lambdaMin = 10.0**(-3)
lambdaMax = 10.0**(3)
rateStepSize = (lambdaMax-lambdaMin)/float(numLambda-1)
jobIndex = 1
botConc = 0.3
topConc = 0.1
boundMult = 1000.0
tolerance = 10.0**(-16)
runningJobs = []

for rateIndex in range(0, numLambda):
    tempRate = lambdaMin + rateStepSize*rateIndex
#    currentRate = tempRate
    currentRate = math.exp(((tempRate-lambdaMin)*math.log(lambdaMax)+(lambdaMax-tempRate)*math.log(lambdaMin))/(lambdaMax-lambdaMin))
    jobInput = "sparseSysRep.py "+str(botConc)+" "+str(topConc)+" "+str(currentRate)+" "+str(sysSize)+" "+str(numVecs)+" "+str(boundMult)+" "+str(tolerance)+" "+str(lambdaMin)+" "+str(lambdaMax)+" "+dataLocation+str(rateIndex)+"\n"
    with open("jobInputs/testInput."+str(jobIndex), 'w') as f:
        f.write(jobInput)
        jobIndex += 1

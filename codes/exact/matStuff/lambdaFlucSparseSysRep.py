import subprocess
import sys
import os
import math

# This code is meant to manage running multiple instances of my KMCLib codes at the same time,
# in the name of time efficiency
numLambda = 256

sysSize = 5
numVecs = 1
dataLocation = "exactSolns/thesisCorrections/low"
lambdaMin = 10.0**(-4)
lambdaMax = 10.0**(4)
rateStepSize = (lambdaMax-lambdaMin)/float(numLambda-1)
jobIndex = 513
botConc = 0.3
topConc = 0.1
boundMult = 1000.0
tolerance = 10.0**(-18)
runningJobs = []

for rateIndex in range(0, numLambda):
    tempRate = lambdaMin + rateStepSize*rateIndex
#    currentRate = tempRate
    currentRate = math.exp(((tempRate-lambdaMin)*math.log(lambdaMax)+(lambdaMax-tempRate)*math.log(lambdaMin))/(lambdaMax-lambdaMin))
    jobInput = "simpleGroundStateFinder.py "+str(botConc)+" "+str(topConc)+" "+str(currentRate)+" "+str(sysSize)+" "+str(numVecs)+" "+str(boundMult)+" "+str(tolerance)+" "+str(1)+" "+dataLocation+str(rateIndex)+"\n"
    with open("jobInputs/testInput."+str(jobIndex), 'w') as f:
        f.write(jobInput)
        jobIndex += 1

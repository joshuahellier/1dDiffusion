import subprocess
import sys
import os
import math

# This code is meant to manage running multiple instances of my KMCLib codes at the same time,
# in the name of time efficiency
numLambda = 2048
sysSize = 10
numVecs = 2048
resultDir = os.environ.get('RESULTS')
if resultDir == None :
    print ("WARNING! $RESULTS not set! Attempt to write results will fail!\n")
dataLocation = resultDir+"/exactSolns/highDefSpectrumRepeat/"
lambdaMin = 10.0**(-3)
lambdaMax = 10.0**(3)
rateStepSize = (lambdaMax-lambdaMin)/float(numLambda-1)
jobIndex = 1
botConc = 0.6
topConc = 0.4
boundMult = 100.0
runningJobs = []
bigList = []
failedJobs = []

for rateIndex in range(0, numLambda):
    tempRate = lambdaMin + rateStepSize*rateIndex
#    currentRate = tempRate
    currentRate = math.exp(((tempRate-lambdaMin)*math.log(lambdaMax)+(lambdaMax-tempRate)*math.log(lambdaMin))/(lambdaMax-lambdaMin))
    try:
        with open(dataLocation+str(rateIndex)+"/eigenvalues.dat", 'r') as f:
            lines = f.readlines()
            for line in lines:
                words = line.split()
                for word in words:
                    bigList.append(str(currentRate)+", "+str(abs(float(word))/currentRate)+"\n")
    except IOError:
        jobInput = "sparseSysRep.py "+str(botConc)+" "+str(topConc)+" "+str(currentRate)+" "+str(sysSize)+" "+str(numVecs)+" "+str(boundMult)+" "+str(tolerance)+" "+str(lambdaMin)+" "+str(lambdaMax)+" "+dataLocation+str(rateIndex)+"\n"

with open(dataLocation+"condensedMatData.dat", 'w') as f:
    for item in bigList:
        f.write(item)

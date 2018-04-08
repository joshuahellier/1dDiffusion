import subprocess
import sys
import os
import math
from scipy import stats

# This code is meant to manage running multiple instances of my KMCLib codes at the same time,
# in the name of time efficiency
resultDir = os.environ.get('RESULTS')
if resultDir == None :
    print ("WARNING! $RESULTS not set! Attempt to write results will fail!\n")
numLambda = 1024
numStepsEquilib = 16**6
numStepsAnal = 16**4
numStepsReq = 16**5
sysWidth = 16
sysLength = 16
sysSize = sysLength*sysWidth
analInterval = 1
numPasses = 256
dataLocation = "dim2Runs/lambdaFluc/lambdaFluc1/"
lambdaMin = 0.001
lambdaMax = 1000.0
rateStepSize = (lambdaMax-lambdaMin)/float(numLambda-1)
avConc = 0.5


runningJobs = []
failedRuns = []
enData = []
jobIndex = 1

for rateIndex in range(0, numLambda):
    currentLoc = resultDir+"/"+dataLocation+str(rateIndex)
    tempRate = lambdaMin + rateStepSize*rateIndex
    currentRate = math.exp(((tempRate-lambdaMin)*math.log(lambdaMax)+(lambdaMax-tempRate)*math.log(lambdaMin))/(lambdaMax-lambdaMin))
    failed = False
    totWeight = 0.0
    meanNum = 0.0
    sqrDev = 0.0
    try:
        with open(currentLoc+"/ovEnHist.dat", 'r') as f:
            lines = f.readlines()
            if len(lines) != 2*sysSize:
                failed = True
                print("Wrong number of items in histogram!\n")
            weights = []
            for line in lines:
                words = line.split()
                val = float(words[1])
                weights.append(val)
                totWeight += val
            if totWeight != 0.0:
                for index in range(0, len(weights)):
                    weights[index] = weights[index]/totWeight
                    meanNum += index*weights[index]
                for index in range(0, len(weights)):
                    sqrDev += weights[index]*(index - meanNum)*(index - meanNum)
                errNum = math.sqrt(sqrDev/float(numPasses))
    except (IOError, LookupError):
        failed = True

    if failed == False:
        enData.append([currentRate, meanNum, sqrDev])
    else:
        failedRuns.append("2dPeriodic.py "+str(avConc)+" "+str(currentRate)+" "+str(sysWidth)+" "+str(sysLength)+" "+str(analInterval)+" "+str(numStepsEquilib)+" "+" "+str(numStepsAnal)+" "+str(numStepsReq)+" "+str(numPasses)+" "+dataLocation+str(rateIndex)+"\n")

with open(resultDir+"/"+dataLocation+"/enMeans.dat", 'w') as f:
    for index in enData:
        f.write(str(index[0])+" "+str(index[1])+"\n")

with open(resultDir+"/"+dataLocation+"/enPerParticle.dat", 'w') as f:
    for index in enData:
        f.write(str(index[0])+" "+str(index[1]/(avConc*sysSize))+"\n")

with open(resultDir+"/"+dataLocation+"/enErr.dat", 'w') as f:
    for index in enData:
        f.write(str(index[0])+" "+str(index[2])+"\n")

with open(resultDir+"/"+dataLocation+"failedRuns.proc", 'w') as f:
    for index in failedRuns:
        f.write(index)
        with open("failedRuns/testInput."+str(jobIndex), 'w') as g:
            g.write(index)
            jobIndex += 1

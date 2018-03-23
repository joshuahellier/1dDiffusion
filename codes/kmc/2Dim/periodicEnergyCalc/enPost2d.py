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
dataLocation = "dim2Runs/periodic/periodicSmall"
lambdaMin = 0.01
lambdaMax = 100.0
rateStepSize = (lambdaMax-lambdaMin)/float(numLambda-1)
concMax = 0.99
concMin = 0.01
concStepSize = (concMax-concMin)/float(numConcs-1)

jobIndex = 1

runningJobs = []

failedRuns = []

sysSize = sysWidth*sysLength

enData = []

for rateIndex in range(0, numLambda):
    tempRate = lambdaMin + rateStepSize*rateIndex
    currentRate = (lambdaMax - lambdaMin)*(math.exp(aParam*(tempRate-lambdaMin)/(lambdaMax-lambdaMin))-1.0)/(math.exp(aParam)-1) + lambdaMin
    for concIndex in range(0, numConcs):
        conc = concMin + concStepSize*concIndex
        jobInput = "2dPeriodic.py "+str(conc)+" "+str(currentRate)+" "+str(sysWidth)+" "+str(sysLength)+" "+str(analInterval)+" "+str(numStepsEquilib)+" "+str(numStepsAnal)+" "+str(numStepsReq)+" "+str(numPasses)+" "+dataLocation+str(rateIndex)+"/"+str(concIndex)+"\n"
        currentLoc = resultDir+"/"+dataLocation+"/"+str(rateIndex)+"/"+str(concIndex)
        failed = False    
        totWeight = 0.0
        meanNum = 0.0
        sqrDev = 0.0
        try:
            with open(currentLoc+"/ovEnHist.dat", 'r') as f:
                lines = f.readlines()
                if len(lines) != 2*sysSize:
                    print("Wrong number of things in histogram.")
                    failed = True
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
            enData.append([currentRate, conc, meanNum, errNum])
        else:
            failedRuns.append(jobInput)
    
with open(resultDir+"/"+dataLocation+"/enMeans.dat", 'w') as f:
    for index in enData:
        f.write(str(index[0])+" "+str(index[1])+" "+str(index[2])+"\n")

with open(resultDir+"/"+dataLocation+"/enPerParticle.dat", 'w') as f:
    for index in enData:
        f.write(str(index[0])+" "+str(index[1])+" "+str(index[2]/(index[1]*sysSize))+"\n")

with open(resultDir+"/"+dataLocation+"/enErr.dat", 'w') as f:
    for index in enData:
        f.write(str(index[0])+" "+str(index[1])+" "+str(index[3])+"\n")

with open(resultDir+"/"+dataLocation+"failedRuns.proc", 'w') as f:
    for index in failedRuns:
        f.write(index)
        with open("jobInputs/testInput."+str(jobIndex), 'w') as g:
            g.write(index)
            jobIndex += 1

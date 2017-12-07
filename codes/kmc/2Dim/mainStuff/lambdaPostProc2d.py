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
numLambda = 512
numStepsEquilib = 1600000
numStepsAnal = 16000
numStepsSnapshot = 1000
numStepsReq = 16000
sysWidth = 32
sysLength = 32
analInterval = 1
numPasses = 100
timeInterval = 1.0
dataLocation = "dim2Runs/lambdaScan1/"
lambdaMin = 0.05
lambdaMax = 1.25
rateStepSize = (lambdaMax-lambdaMin)/float(numLambda-1)
jobIndex = 1
botConc = 0.75
topConc = 0.25

runningJobs = []
failedRuns = []
rateData = []
flowMoments = []

for rateIndex in range(0, numLambda):
    currentLoc = resultDir+"/"+dataLocation+str(rateIndex)
    currentRate = lambdaMin + rateStepSize*rateIndex
    inTopVals = []
    outTopVals = []
    inBotVals = []
    outBotVals = []
    failed = False
    try:
        with open(currentLoc+"/inTop.dat", 'r') as f:
            lines = f.readlines()
            if len(lines) != numPasses:
                failed = True
                print("wrongLength")
            for line in lines:
                inTopVals.append(float(line))
    except IOError:
        failed = True
        print("ioError")
    try:
        with open(currentLoc+"/outTop.dat", 'r') as f:
            lines = f.readlines()
            if len(lines) != numPasses:
                failed = True
            for line in lines:
                outTopVals.append(float(line))
    except IOError:
        failed = True
    try:
        with open(currentLoc+"/inBot.dat", 'r') as f:
            lines = f.readlines()
            if len(lines) != numPasses:
                failed = True
            for line in lines:
                inBotVals.append(float(line))
    except IOError:
        failed = True
    try:
        with open(currentLoc+"/outBot.dat", 'r') as f:
            lines = f.readlines()
            if len(lines) != numPasses:
                failed = True
            for line in lines:
                outBotVals.append(float(line))
    except IOError:
        failed = True

    totWeight = 0.0
    meanNum = 0.0
    sqrDev = 0.0

    try:
        with open(currentLoc+"/ovNumHist.dat", 'r') as f:
            lines = f.readlines()
            if len(lines) != sysSize:
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
        total = 0.0
        flows = []
        for index in range(0, numPasses):
            flows.append(0.5*((inBotVals[index]-outBotVals[index]) + (outTopVals[index] - inTopVals[index])))
            total += flows[-1]
        flowMean = total/float(numPasses)
        squaredDev = 0.0
        for index in range(0, numPasses):
            squaredDev += (flows[index]-flowMean)*(flows[index]-flowMean)
        stdErr = math.sqrt(squaredDev)/float(numPasses)
        rateData.append([currentRate, flowMean, stdErr, meanNum, errNum, meanNumBlk, errNumBlk])
        rateDesc = stats.describe(flows)
        flowMoments.append(rateDesc)
    else:
        failedRuns.append("2dSteadyFlow.py "+str(botConc)+" "+str(topConc)+" "+str(currentRate)+" "+str(sysWidth)+" "+str(sysLength)+" "+str(analInterval)+" "+str(numStepsEquilib)+" "+str(numStepsSnapshot)+" "+str(numStepsAnal)+" "+str(numStepsReq)+" "+str(numPasses)+" "+str(timeInterval)+" "+dataLocation+str(rateIndex)+"\n")
with open(resultDir+"/"+dataLocation+"/rateMeans.dat", 'w') as f:
    for index in rateData:
        f.write(str(index[0])+" "+str(index[1])+"\n")
with open(resultDir+"/"+dataLocation+"/rateErrs.dat", 'w') as f:
    for index in rateData:
        if index[1] != 0.0:
            f.write(str(index[0])+" "+str(100.0*index[2]/abs(index[1]))+"\n")
        else:
            f.write(str(index[0])+" "+str(-1.0)+"\n")

with open(resultDir+"/"+dataLocation+"/flowMeans.dat", 'w') as f:
    for i in range(0, len(rateData)):
        f.write(str(rateData[i][0])+" "+str(flowMoments[i][2])+"\n")

with open(resultDir+"/"+dataLocation+"/flowVars.dat", 'w') as f:
    for i in range(0, len(rateData)):
        f.write(str(rateData[i][0])+" "+str(flowMoments[i][3])+"\n")

with open(resultDir+"/"+dataLocation+"/flowSkew.dat", 'w') as f:
    for i in range(0, len(rateData)):
        f.write(str(rateData[i][0])+" "+str(flowMoments[i][4])+"\n")

with open(resultDir+"/"+dataLocation+"/flowKurt.dat", 'w') as f:
    for i in range(0, len(rateData)):
        f.write(str(rateData[i][0])+" "+str(flowMoments[i][5])+"\n")

with open(resultDir+"/"+dataLocation+"/densMeans.dat", 'w') as f:
    for index in rateData:
        f.write(str(index[0])+" "+str(index[3]/float(sysSize))+"\n")
with open(resultDir+"/"+dataLocation+"/densErrs.dat", 'w') as f:
    for index in rateData:
        if index[3] != 0.0:
            f.write(str(index[0])+" "+str(100.0*index[4]/abs(index[3]))+"\n")
        else:
            f.write(str(index[0])+" "+str(-1.0)+"\n")

with open(resultDir+"/"+dataLocation+"/histMeans.dat", 'w') as f:
    for index in rateData:
        f.write(str(index[0])+" "+str(index[5])+"\n")
with open(resultDir+"/"+dataLocation+"/histErrs.dat", 'w') as f:
    for index in rateData:
        if index[5] != 0.0:
            f.write(str(index[0])+" "+str(100.0*index[6]/abs(index[5]))+"\n")
        else:
            f.write(str(index[0])+" "+str(-1.0)+"\n")

with open(resultDir+"/"+dataLocation+"failedRuns.proc", 'w') as f:
    for index in failedRuns:
        f.write(index)
        with open("failedRuns/testInput."+str(jobIndex), 'w') as g:
            g.write(index)
            jobIndex += 1

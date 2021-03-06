import subprocess
import sys
import os
import math

# This code is meant to manage running multiple instances of my KMCLib codes at the same time,
# in the name of time efficiency
resultDir = os.environ.get('RESULTS')
if resultDir == None :
    print ("WARNING! $RESULTS not set! Attempt to write results will fail!\n")

numConcs = 12
numLambda = 12
numStepsEquilib = 1600000
numStepsAnal = 16000
numStepsSnapshot = 1000
numStepsReq = 16000
sysWidth = 16
sysLength = 16
analInterval = 1
numPasses = 100
timeInterval = 1.0
dataLocation = "dim2Runs/attempt1/32x32/"
lambdaMin = 0.05
lambdaMax = 1.25
rateStepSize = (lambdaMax-lambdaMin)/float(numLambda-1)
concMax = 0.99
concMin = 0.01
concStepSize = (concMax-concMin)/float(numConcs-1)

jobIndex = 1

runningJobs = []

failedRuns = []

sysSize = sysWidth*(sysLength+4)

for rateIndex in range(0, numLambda):
    currentRate = lambdaMin + rateStepSize*rateIndex
    rateData = []
    for botConcIndex in range(0, numConcs):
        botConc = concMin + concStepSize*botConcIndex
        for topConcIndex in range(0, numConcs):
            topConc = concMin + concStepSize*topConcIndex
            currentLoc = resultDir+"/"+dataLocation+str(rateIndex)+"/"+str(botConcIndex)+"/"+str(topConcIndex)
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
                rateData.append([botConc, topConc, flowMean, stdErr, meanNum, errNum])
            else:
                failedRuns.append("concFlow.py "+str(botConc)+" "+str(topConc)+" "+str(currentRate)+" "+str(sysSize)+" "+str(analInterval)+" "+str(numStepsEquilib)+" "+str(numStepsSnapshot)+" "+str(numStepsAnal)+" "+str(numStepsReq)+" "+str(numPasses)+" "+str(timeInterval)+" "+dataLocation+str(rateIndex)+"/"+str(botConcIndex)+"/"+str(topConcIndex)+"\n")
    with open(resultDir+"/"+dataLocation+str(rateIndex)+"/rateMeans.dat", 'w') as f:
        for index in rateData:
            f.write(str(index[0])+" "+str(index[1])+" "+str(index[2])+"\n")
    with open(resultDir+"/"+dataLocation+str(rateIndex)+"/rateErrs.dat", 'w') as f:
        for index in rateData:
            if index[2] != 0.0:
                f.write(str(index[0])+" "+str(index[1])+" "+str(100.0*index[3]/abs(index[2]))+"\n")
            else:
                f.write(str(index[0])+" "+str(index[1])+" "+str(-1.0)+"\n")
    with open(resultDir+"/"+dataLocation+str(rateIndex)+"/densMeans.dat", 'w') as f:
        for index in rateData:
            f.write(str(index[0])+" "+str(index[1])+" "+str(index[4]/float(sysSize))+"\n")
    with open(resultDir+"/"+dataLocation+str(rateIndex)+"/densErrs.dat", 'w') as f:
        for index in rateData:
            if index[2] != 0.0:
                f.write(str(index[0])+" "+str(index[1])+" "+str(100.0*index[5]/abs(index[4]))+"\n")
            else:
                f.write(str(index[0])+" "+str(index[1])+" "+str(-1.0)+"\n")

with open(resultDir+"/"+dataLocation+"failedRuns.proc", 'w') as f:
    for index in failedRuns:
        f.write(index)
        with open("jobInputs/testInput."+str(jobIndex), 'w') as g:
            g.write(index)
            jobIndex += 1

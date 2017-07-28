import subprocess
import sys
import os
import math

# This code is meant to manage running multiple instances of my KMCLib codes at the same time,
# in the name of time efficiency
resultDir = os.environ.get('RESULTS')
if resultDir == None :
    print ("WARNING! $RESULTS not set! Attempt to write results will fail!\n")
numConcs = 16
numLambda = 4
numStepsEquilib = 160000000
numStepsAnal = 80000000
numStepsSnapshot = 1000
numStepsReq = 16000000
sysSize = 124
analInterval = 1
numPasses = 10
timeInterval = 100.0
dataLocation = "batchJobs/concRuns/attempt1/"
lambdaMin = 0.1
lambdaMax = 0.4
rateStepSize = (lambdaMax-lambdaMin)/float(numLambda-1)
concMax = 0.97
concMin = 0.03
concStepSize = (concMax-concMin)/float(numConcs-1)

jobIndex = 1

runningJobs = []

failedRuns = []

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
                rateData.append([botConc, topConc, flowMean, stdErr])
            else:
                failedRuns.append("concFlow.py "+str(botConc)+" "+str(topConc)+" "+str(currentRate)+" "+str(sysSize)+" "+str(analInterval)+" "+str(numStepsEquilib)+" "+str(numStepsSnapshot)+" "+str(numStepsAnal)+" "+str(numStepsReq)+" "+str(numPasses)+" "+str(timeInterval)+" "+dataLocation+str(rateIndex)+"/"+str(botConcIndex)+"/"+str(topConcIndex)+"\n")
    with open(resultDir+"/"+dataLocation+str(rateIndex)+"/rateMeans.proc", 'w') as f:
        for index in rateData:
            f.write(str(index[0])+" "+str(index[1])+" "+str(index[2])+"\n")
    with open(resultDir+"/"+dataLocation+str(rateIndex)+"/rateErrs.proc", 'w') as f:
        for index in rateData:
            f.write(str(index[0])+" "+str(index[1])+" "+str(index[3])+"\n")


with open(resultDir+"/"+dataLocation+"failedRuns.proc", 'w') as f:
    for index in failedRuns:
        f.write(index)
        with open("jobInputs/testInput."+str(jobIndex), 'w') as g:
            g.write(jobInput)
            jobIndex += 1

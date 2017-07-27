import subprocess
import sys
import os

# This code is meant to manage running multiple instances of my KMCLib codes at the same time,
# in the name of time efficiency
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
dataLocation = "batchJobs/concRuns/postTest/"
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
            currentLoc = "$RESULTS/"+dataLocation+str(rateIndex)+"/"+str(botConcIndex)+"/"+str(topConcIndex)
            inTopVals = []
            outTopVals = []
            inBotVals = []
            outBotVals = []
            failed = False
            try:
                with open(currentLoc+"inTop.dat", 'r') as f:
                    lines = f.readlines()
                    if len(lines) != numPasses:
                        failed = True
                        break
                    for line in lines:
                        inTopVals.append(float(line))
            except IOError:
                failed = True
            try:
                with open(currentLoc+"outTop.dat", 'r') as f:
                    lines = f.readlines()
                    if len(lines) != numPasses:
                        failed = True
                        break
                    for line in lines:
                        outTopVals.append(float(line))
            except IOError:
                failed = True
            try:
                with open(currentLoc+"inBot.dat", 'r') as f:
                    lines = f.readlines()
                    if len(lines) != numPasses:
                        failed = True
                        break
                    for line in lines:
                        inBotVals.append(float(line))
            except IOError:
                failed = True
            try:
                with open(currentLoc+"outBot.dat", 'r') as f:
                    lines = f.readlines()
                    if len(lines) != numPasses:
                        failed = True
                        break
                    for line in lines:
                        outBotVals.append(float(line))
            except IOError:
                failed = True

            if failed == False:
                total = 0.0
                flows = []
                for index in range(0, numPasses):
                    flow.append(0.5*((inBot[index]-outBot[index]) + (outTop[index] - inTop[index])))
                    total += flow[-1]
                flowMean = total/float(numPasses)
                squaredDev = 0.0
                for index in range(0, numPasses):
                    squaredDev += (flow[index]-flowMean)*(flow[index]-flowMean)
                stdErr = math.sqrt(squaredDev)/float(numPasses)
                rateData.append([botConc, topConc, flowMean, stdErr])
            else:
                failedRuns.append("$RESULTS/"+dataLocation+str(rateIndex)+"/"+str(botConcIndex)+"/"+str(topConcIndex)+"\n")
    with open("$RESULTS/"+dataLocation+str(rateIndex)+"/rateMeans.proc", 'w') as f:
        for index in rateData:
            f.write(str(rateData[index][0])+" "+str(rateData[index][1])+" "+str(rateData[index][2])+"\n")
    with open("$RESULTS/"+dataLocation+str(rateIndex)+"/rateErrs.proc", 'w') as f:
        for index in rateData:
            f.write(str(rateData[index][0])+" "+str(rateData[index][1])+" "+str(rateData[index][3])+"\n")

with open("$RESULTS/"+dataLocation+"failedRuns.proc", 'w') as f:
    for index in failedRuns:
        f.write(index)

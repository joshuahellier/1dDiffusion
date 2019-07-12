import subprocess
import sys
import os
import math

# This code is meant to manage running multiple instances of my KMCLib codes at the same time,
# in the name of time efficiency
numConcDiff = 8
numConcs = 24
numLambda = 12
numStepsEquilib = 160000
numStepsAnal = 16000
numStepsSnapshot = 1000
numStepsReq = 16000
sysSize = 32
analInterval = 1
numPasses = 10000
timeInterval = 100.0
dataLocation = "batchJobs/mainRuns/thesisCorrectionData/diffCoeff/L32/"
lambdaMin = 0.01
lambdaMax = 10.0
concDiffMin = -0.05
concDiffMax = 0.05
rateStepSize = (lambdaMax-lambdaMin)/float(numLambda-1)
diffStepSize = (concDiffMax - concDiffMin)/float(numConcDiff-1)
concMax = 0.97
concMin = 0.03
concStepSize = (concMax-concMin)/float(numConcs-1)

jobIndex = 1

runningJobs = []

for rateIndex in range(0, numLambda):
    tempRate = lambdaMin + rateStepSize*rateIndex
    currentRate = math.exp(((tempRate-lambdaMin)*math.log(lambdaMax)+(lambdaMax-tempRate)*math.log(lambdaMin))/(lambdaMax-lambdaMin))
    for concIndex in range(0, numConcs):
        currentConc = concMin + concStepSize*concIndex
        for concDiffIndex in range(0, numConcDiff):
            currentConcDiff = diffStepSize*concDiffIndex + concDiffMin
            botConc = currentConc - 0.5*currentConcDiff
            topConc = currentConc + 0.5*currentConcDiff
            jobInput = "tempSteadyFlow.py "+str(botConc)+" "+str(topConc)+" "+str(currentRate)+" "+str(sysSize)+" "+str(analInterval)+" "+str(numStepsEquilib)+" "+str(numStepsSnapshot)+" "+str(numStepsAnal)+" "+str(numStepsReq)+" "+str(numPasses)+" "+str(timeInterval)+" "+dataLocation+str(rateIndex)+"/"+str(concIndex)+"/"+str(concDiffIndex)+" "+str(rateIndex)+"m"+str(concIndex)+"m"+str(concDiffIndex)+"\n"
            if not os.path.exists(dataLocation+str(rateIndex)+"/"+str(concIndex)+"/"+str(concDiffIndex)+"/composition")
                with open("failedRuns/testInput."+str(jobIndex), 'w') as f:
                    f.write(jobInput)
                jobIndex += 1

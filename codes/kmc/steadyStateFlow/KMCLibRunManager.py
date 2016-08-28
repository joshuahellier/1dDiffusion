import subprocess
import sys
import os

# This code is meant to manage running multiple instances of my KMCLib codes at the same time,
# in the name of time efficiency

numCores = 6
numConcDiff = 6
numConcs = 8
numLambda = 3
numStepsEquilib = 10000000
numStepsAnal = 100000
numStepsSnapshot = 100000
numStepsReq = 500000
sysSize = 60
analInterval = 1
numPasses = 8
timeInterval = 1.0
dataLocation = "steadyStateFlow/newTests/attempt1/"
lambdaMin = 0.01
lambdaMax = 1.5
concDiffMin = -0.2
concDiffMax = 0.2
rateStepSize = (lambdaMax-lambdaMin)/float(numLambda-1)
diffStepSize = (concDiffMax - concDiffMin)/float(numConcDiff-1)
concMax = 0.9
concMin = 0.1
concStepSize = (concMax-concMin)/float(numConcs-1)

jobsStarted = 0
coresUsed = 0

runningJobs = []

for rateIndex in range(0, numLambda):
    currentRate = lambdaMin + rateStepSize*rateIndex
    for concIndex in range(0, numConcs):
        currentConc = concMin + concStepSize*concIndex
        jobsStarted = 0
        while jobsStarted<numConcDiff:
            coresUsed = 0
            runningJobs = []
            while (coresUsed<numCores) and (jobsStarted<numConcDiff):
                currentConcDiff = diffStepSize*jobsStarted + concDiffMin
                botConc = currentConc - 0.5*currentConcDiff
                topConc = currentConc + 0.5*currentConcDiff
                jobInput = "python steadyStateFlow.py "+str(botConc)+" "+str(topConc)+" "+str(currentRate)+" "+str(sysSize)+" "+str(analInterval)+" "+str(numStepsEquilib)+" "+str(numStepsSnapshot)+" "+str(numStepsAnal)+" "+str(numStepsReq)+" "+str(numPasses)+" "+str(timeInterval)+" "+dataLocation+str(rateIndex)+"/"+str(concIndex)+"/"+str(jobsStarted)+" >/dev/null"
                p = subprocess.Popen(jobInput, shell=True)
                runningJobs.append(p)
                print "Starting job "+str(jobsStarted+1)+" on core "+str(coresUsed+1)
                coresUsed += 1
                jobsStarted += 1
            exit_codes = [p.wait() for p in runningJobs]
print "All runs complete."

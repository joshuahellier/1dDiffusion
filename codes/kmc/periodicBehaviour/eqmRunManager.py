import subprocess
import sys
import os

# This code is meant to manage running multiple instances of my KMCLib codes at the same time,
# in the name of time efficiency

numCores = 6
totalRuns = 18
maxAvConc = 0.18
minAvConc = 0.01
numSteps = 10000000
equilSteps = 10000
fullRate = sys.argv[1]
sysSize = 1024
dataLocation = "1DTiO/1dEqm/runManagerTest2/"+str(sysSize)+"/"+str(fullRate)+"/"

concStepSize = (maxAvConc-minAvConc)/float(totalRuns-1)
jobsStarted = 0
coresUsed = 0
totalRuns = 18

runningJobs = []

while jobsStarted<totalRuns:
    coresUsed = 0
    runningJobs = []
    while (coresUsed<numCores) and (jobsStarted<totalRuns):
#        jobInput = ["python 1dCustom.py", str(avConc), str(minConcDiff+float(jobsStarted)*concStepSize), str(fullRate), str(sysSize), str(numSteps), str(transTime), dataLocation+str(jobsStarted)]
        jobInput = "python periodicEqm.py "+str(concStepSize*jobsStarted+minAvConc)+" "+str(fullRate)+" "+str(sysSize)+" "+str(numSteps)+" "+str(equilSteps)+" "+dataLocation+str(jobsStarted)+" >/dev/null"
        p = subprocess.Popen(jobInput, shell=True)
        runningJobs.append(p)
        print "Starting job "+str(jobsStarted+1)+" on core "+str(coresUsed+1)
        coresUsed += 1
        jobsStarted += 1
    exit_codes = [p.wait() for p in runningJobs]
print "All runs complete."

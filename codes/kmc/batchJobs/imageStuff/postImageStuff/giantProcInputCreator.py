import subprocess
import sys
import os

# This code is meant to manage running multiple instances of my KMCLib codes at the same time,
# in the name of time efficiency

numConcs = 24
numLambda = 12
dataLocation = "batchJobs/imagingRuns/attempt6c"
jobIndex = 1

runningJobs = []

for rateIndex in range(0, numLambda):
    for concIndex in range(0, numConcs):
        jobInput = "giantProcessor.py "+dataLocation+"/"+str(rateIndex)+"/"+str(concIndex)+"\n"
        with open("postProcInputs/postInput."+str(jobIndex), 'w') as f:
            f.write(jobInput)
        jobIndex += 1

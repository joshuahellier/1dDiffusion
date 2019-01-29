import subprocess
import sys
import os
import math

# This code is meant to manage running multiple instances of my KMCLib codes at the same time. Of course, not every calculation has been in exactly this format, but it gives the gist.
# It produces the contents of "testInput.n" where n is the number of the batch job; this is supposed to be input which can follow "python " in the command line. In this case, we have
# set it up to call concFlow.py , with associated command line inputs. This calculation run uses constant boundary conditions and other run parameters, and scans through \lambda
# values from 10^-6 to 10^6 with logarithmically even-spaced steps (as in, they appear even on a logarithmic graph).

numLambda = 2048
numStepsEquilib = 4000000
numStepsAnal = 16000
numStepsReq = 16000
sysSize = 64
analInterval = 1
numPasses = 10000
timeInterval = 1.0
dataLocation = "batchJobs/concRuns/exampleSweep/"
lambdaMin = 10.0**(-6)
lambdaMax = 10.0**(6)
aParam = 1.0
rateStepSize = (lambdaMax-lambdaMin)/float(numLambda-1)
jobIndex = 1
botConc = 0.6
topConc = 0.4

for rateIndex in range(0, numLambda):
    tempRate = lambdaMin + rateStepSize*rateIndex
    currentRate = math.exp(((tempRate-lambdaMin)*math.log(lambdaMax)+(lambdaMax-tempRate)*math.log(lambdaMin))/(lambdaMax-lambdaMin))
    jobInput = "concFlow.py "+str(botConc)+" "+str(topConc)+" "+str(currentRate)+" "+str(sysSize)+" "+str(analInterval)+" "+str(numStepsEquilib)+" "+str(numStepsAnal)+" "+str(numStepsReq)+" "+str(numPasses)+" "+str(timeInterval)+" "+dataLocation+str(rateIndex)+"\n"
    with open("jobInputs/testInput."+str(jobIndex), 'w') as f:
        f.write(jobInput)
        jobIndex += 1

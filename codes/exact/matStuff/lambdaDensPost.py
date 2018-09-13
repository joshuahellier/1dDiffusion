import subprocess
import sys
import os
import math

# This code is meant to manage running multiple instances of my KMCLib codes at the same time,
# in the name of time efficiency
resultDir = os.environ.get('RESULTS')
if resultDir == None :
    print ("WARNING! $RESULTS not set! Attempt to write results will fail!\n")
numLambda = 32
numDensDiff = 32
sysSize = 10
numVecs = 1
dataLocation = "exactSolns/concDiffRuns/firstAttempt/"
longDatLoc = resultDir+"/"+dataLocation
lambdaMin = 10.0**(-2)
lambdaMax = 10.0**(2)
densDiffMin = 0.0
densDiffMax = 0.999
avDens = 0.5
rateStepSize = (lambdaMax-lambdaMin)/float(numLambda-1)
densStepSize = (densDiffMax-densDiffMin)/float(numDensDiff-1)
jobIndex = 1
boundMult = 1000.0
tolerance = 10.0**(-18)
runningJobs = []
currentList = []
entropyList = []
densityList = []
eigenvalueList = []

for rateIndex in range(0, numLambda):
    tempRate = lambdaMin + rateStepSize*rateIndex
#    currentRate = tempRate
    currentRate = math.exp(((tempRate-lambdaMin)*math.log(lambdaMax)+(lambdaMax-tempRate)*math.log(lambdaMin))/(lambdaMax-lambdaMin))
    for densIndex in range(0, numDensDiff):
        densDiff = densDiffMin + densIndex*densStepSize
        botConc = avDens + 0.5*densDiff
        topConc = avDens - 0.5*densDiff
        jobInput = "simpleGroundStateFinder.py "+str(botConc)+" "+str(topConc)+" "+str(currentRate)+" "+str(sysSize)+" "+str(numVecs)+" "+str(boundMult)+" "+str(tolerance)+" "+dataLocation+str(rateIndex)+"/"+str(densIndex)+"\n"
        try:
            with open(longDatLoc+str(rateIndex)+"/"+str(densIndex)+"/currVec0.dat", 'r') as f:
                lines = f.readlines()
                tempCurrent = lines[int(len(lines)/2)]
                currentList.append(str(tempRate)+", "+str(densDiff)+", "+tempCurrent)
            with open(longDatLoc+str(rateIndex)+"/"+str(densIndex)+"/densVec0.dat", 'r') as f:
                lines = f.readlines()
                tempDens = 0.0
                for lineIndex in range(0, sysSize):
                    tempDens += float(lines[lineIndex])
                densityList.append(str(tempRate)+", "+str(densDiff)+", "+str(tempDens/sysSize)+"\n")
            with open(longDatLoc+str(rateIndex)+"/"+str(densIndex)+"/eigenvalues.dat", 'r') as f:
                lines = f.readlines()
                eigenvalue = lines[0]
                eigenvalueList.append(str(tempRate)+", "+str(densDiff)+", "+eigenvalue)
            with open(longDatLoc+str(rateIndex)+"/"+str(densIndex)+"/groundEntropy.dat", 'r') as f:
                lines = f.readlines()
                entropy = lines[0]
                entropyList.append(str(tempRate)+", "+str(densDiff)+", "+entropy)
        except IOError:
            with open("jobInputs/testInput."+str(jobIndex), 'w') as f:
                f.write(jobInput)
                jobIndex += 1

with open(longDatLoc+"eigSet.dat", 'w') as f:
    for eig in eigenvalueList:
        f.write(eig)

with open(longDatLoc+"currSet.dat", 'w') as f:
    for curr in currentList:
        f.write(curr)

with open(longDatLoc+"entSet.dat", 'w') as f:
    for ent in entropyList:
        f.write(ent)

with open(longDatLoc+"densSet.dat", 'w') as f:
    for dens in densityList:
        f.write(dens)

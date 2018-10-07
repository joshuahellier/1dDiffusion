import subprocess
import sys
import os
import math

# This code is meant to manage running multiple instances of my KMCLib codes at the same time,
# in the name of time efficiency
resultDir = os.environ.get('RESULTS')
if resultDir == None :
    print ("WARNING! $RESULTS not set! Attempt to write results will fail!\n")
numLambda = 64
numDensDiff = 64
sysSize = 10
numVecs = 1
dataLocation = "exactSolns/densityLambdaRuns/firstAttempt/"
longDatLoc = resultDir+"/"+dataLocation
lambdaMin = 10.0**(-2)
lambdaMax = 10.0**(2)
densMin = 0.001
densMax = 0.999
densDiff = 0.1
botDensMax = densMax
botDensMin = densMin+densDiff
rateStepSize = (lambdaMax-lambdaMin)/float(numLambda-1)
densStepSize = (botDensMax-botDensMin)/float(numDensDiff-1)
jobIndex = 1
boundMult = 1000.0
tolerance = 10.0**(-18)
runningJobs = []
currentList = []
entropyList = []
densityList = []
eigenvalueList = []
autoCorrTimeList = []
autoCorrTimeErr = []

for rateIndex in range(0, numLambda):
    tempRate = lambdaMin + rateStepSize*rateIndex
#    currentRate = tempRate
    currentRate = math.exp(((tempRate-lambdaMin)*math.log(lambdaMax)+(lambdaMax-tempRate)*math.log(lambdaMin))/(lambdaMax-lambdaMin))
    for densIndex in range(0, numDensDiff):
        botConc = densStepSize*densIndex+botDensMin
        topConc = botConc - densDiff
        avDens = botConc - 0.5*densDiff
        jobInput = "simpleGroundStateFinder.py "+str(botConc)+" "+str(topConc)+" "+str(currentRate)+" "+str(sysSize)+" "+str(numVecs)+" "+str(boundMult)+" "+str(tolerance)+" "+dataLocation+str(rateIndex)+"/"+str(densIndex)+"\n"
        try:
            with open(longDatLoc+str(rateIndex)+"/"+str(densIndex)+"/currVec0.dat", 'r') as f:
                lines = f.readlines()
                tempCurrent = lines[int(len(lines)/2)]
                currentList.append(str(currentRate)+" "+str(avDens)+" "+tempCurrent+"\n")
            with open(longDatLoc+str(rateIndex)+"/"+str(densIndex)+"/densVec0.dat", 'r') as f:
                lines = f.readlines()
                tempDens = 0.0
                for lineIndex in range(0, sysSize):
                    tempDens += float(lines[lineIndex])
                densityList.append(str(currentRate)+" "+str(avDens)+" "+str(tempDens/sysSize)+"\n")
            with open(longDatLoc+str(rateIndex)+"/"+str(densIndex)+"/eigenvalues.dat", 'r') as f:
                lines = f.readlines()
                eigenvalue = lines[0]
                eigenvalueList.append(str(currentRate)+" "+str(avDens)+" "+eigenvalue+"\n")
            with open(longDatLoc+str(rateIndex)+"/"+str(densIndex)+"/groundEntropy.dat", 'r') as f:
                lines = f.readlines()
                entropy = lines[0]
                entropyList.append(str(currentRate)+" "+str(avDens)+" "+entropy+"\n")
            with open(longDatLoc+str(rateIndex)+"/"+str(densIndex)+"/autoCorrTime.dat", 'r') as f:
                lines = f.readlines()
                autoCorrTime = lines[0]
                autoCorrRelErr = lines[1]
                autoCorrTimeList.append(str(currentRate)+" "+str(avDens)+" "+autoCorrTimeList+"\n")
                autoCorrTimeErr.append(str(currentRate)+" "+str(avDens)+" "+autoCorrRelErr+"\n")
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

with open(longDatLoc+"autoCorrTimeSet.dat", 'w') as f:
    for corr in autoCorrTimeList:
        f.write(corr)

with open(longDatLoc+"autoCorrTimeErr.dat", 'w') as f:
    for err in autoCorrTimeErr:
        f.write(err)

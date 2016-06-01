import sys
import os
import numpy
import cPickle as pickle
import postProcessorUtilities as pPU

timeChunkSize = float(sys.argv[2])

resultDir = os.environ.get('RESULTS')
if resultDir == None :
    print "WARNING! $RESULTS not set! Attempt to write results will fail!\n"

fileInfo = sys.argv[1]
resultsPlace = resultDir+"/"+fileInfo+"/"

if not os.path.exists(resultsPlace):
    print"WARNING! The results directory requested does not exist! Perhaps there is some typo...\n"
    exit()



resultsTable = []
lines = []
words = []



#Firstly, get rid of any files which could cause trouble and crash things
fileName = resultsPlace+"mainResults.p"
try:
    os.remove(fileName)
except OSError:
    pass

fileName = resultsPlace+"regressionData.dat"
try:
    os.remove(fileName)
except OSError:
    pass



directoryList = os.listdir(resultsPlace)

#g = open(resultsPlace+"regressionData.dat", 'w')





for files in directoryList:
    sites = []
    times = []
    steps = []
    types = []
    typesTimeAverage = []
    currentDir = resultsPlace+files

    print("Considering file "+currentDir+"\n")
    execfile(currentDir+"/traj.tr")
    print("Execution successful!\n")


    with open(currentDir + "/settings", 'r') as f:
        lines = f.readlines()
    words = (lines[2]).split()
    sysSize = int(words[2])
    words = (lines[0]).split()
    avConc = float(words[2])
    words = (lines[3]).split()
    numSteps = int(words[2])
    words = (lines[1]).split()
    fullRate = float(words[2])
    timeChunkSize = (times[-1]-times[0])/float(sysSize-1)

    weightings = pPU.weightingsFinder(times, timeChunkSize)
    numTypes = len(types[1])
    typeStats = []

    numBonds = []
    
    with open(currentDir+"/types.dat", "w") as kindFile:
        for typeList in types:
            #print(typeList)
            currentNumBonds = 0
            for kind in range(0, len(typeList)):
                #print(str(kind))
                kindFile.write(typeList[kind])
                if (typeList[kind-1]=="O") and (typeList[kind]=="O"):
                    currentNumBonds += 1
            kindFile.write("\n")
            numBonds.append(currentNumBonds)
    
    with open(currentDir+"/typeStats.dat", "w") as typeFile:
        for typeIndex in range(0, numTypes):
            typeHistory = []
            for chunkWeights in weightings:
                tempTotal = 0.0
                realTotal = 0.0
                for weight in chunkWeights[1]:
                    temp = types[weight[0]]
                    realTotal += weight[1]
                    if temp[typeIndex] == "O":
                        tempTotal += weight[1]
                typeFile.write(str(tempTotal/realTotal)+" ")
            typeFile.write("\n")

    with open(currentDir+"/numBonds.dat", "w") as bondFile:
        for chunkWeights in weightings:
            tempTotal = 0.0
            print(chunkWeights)
            for weight in chunkWeights[1]:
                tempTotal += float(numBonds[weight[0]])*weight[1]
            bondFile.write(str(chunkWeights[0]*timeChunkSize+times[0])+" "+str(tempTotal/(timeChunkSize*avConc*numTypes)-avConc*avConc)+"\n")

            
    weightings = pPU.weightingsFinder(times, (times[-1]-times[0])/3.0)
    tempTotal = 0.0
    provWeights = weightings[-2]
    for weight in provWeights[1]:
        tempTotal += float(numBonds[weight[0]])*weight[1]
    avBonds = tempTotal*3.0/((times[-1]-times[0])*avConc*numTypes)

    with open(currentDir+"/extraInfo.dat", "w") as infoFile:
        infoFile.write(str(avConc)+" "+str(fullRate)+" "+str(avBonds - avConc*avConc))"""

    #print(str(diffConc)+" "+topInRate+" "+topInErr+" "+topOutRate+" "+topOutErr+" "+botInRate+" "+botInErr+" "+botOutRate+" "+botOutErr)
#pickle.dump(resultsTable, open(resultsPlace+"mainResults.p", "wb"))

"""
flow = []
flowErr = []
gradient = []

for i in resultsTable:
    flow.append(i[1][0]+i[4][0]-i[2][0]-i[3][0])
    flowErr.append(numpy.sqrt(i[1][1]**2+i[4][1]**2+i[2][1]**2+i[3][1]**2))
    gradient.append(i[0]/float(sysSize))
    #print(str(gradient[-1])+" "+str(flow[-1])+" "+str(flowErr[-1]))

import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import statsmodels.formula.api as sm

x_list = gradient
y_list = flow
y_err = flowErr

# put x and y into a pandas DataFrame, and the weights into a Series
ws = pd.DataFrame({
    'x': x_list,
    'y': y_list
})
weights = pd.Series(y_err)

wls_fit = sm.wls('x ~ y', data=ws, weights=1.0 / ((weights)**2)).fit()
ols_fit = sm.ols('x ~ y', data=ws).fit()

# show the fit summary by calling wls_fit.summary()
# wls fit r-squared is 0.754
# ols fit r-squared is 0.701

with open(resultsPlace+"regressionData.dat", 'a') as f:
    f.writelines([str(wls_fit.summary())+"\n", str(wls_fit.params[0])+" "+str(wls_fit.bse[0])+"\n", str(wls_fit.params[1])+" "+str(wls_fit.bse[1])+"\n"])
    """


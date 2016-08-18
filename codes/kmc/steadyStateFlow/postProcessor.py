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
    print "WARNING! The results directory requested does not exist! Perhaps there is some typo...\n"
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

g = open(resultsPlace+"regressionData.dat", 'w')

for i in directoryList:

    sites = []
    times = []
    steps = []
    types = []
    typesTimeAverage = []
    currentDir = resultsPlace+i
    print("Considering file "+currentDir+"\n")

    #execfile(currentDir+"/traj.tr")

    with open(currentDir + "/settings", 'r') as f:
        lines = f.readlines()
    words = (lines[0]).split()
    botConc = float(words[2])
    words = (lines[1]).split()
    topConc = float(words[2])
    words = (lines[2]).split()
    fullRate = float(words[2])
    words = (lines[3]).split()
    sysSize = int(words[2])+4
    words = (lines[4]).split()
    timeInterval = float(words[2])

    with open(currentDir + "/procOxInTop.dat", 'r') as f:
        lines = f.readlines()
    words = (lines[-1]).split()
    rateAndErr = (words[12]).split('+/-')
    topInRate = rateAndErr[0]
    topInErr = rateAndErr[1]

    with open(currentDir + "/procOxOutTop.dat", 'r') as f:
        lines = f.readlines()
    words = (lines[-1]).split()
    rateAndErr = (words[12]).split('+/-')
    topOutRate = rateAndErr[0]
    topOutErr = rateAndErr[1]

    with open(currentDir + "/procOxInBot.dat", 'r') as f:
        lines = f.readlines()
    words = (lines[-1]).split()
    rateAndErr = (words[12]).split('+/-')
    botInRate = rateAndErr[0]
    botInErr = rateAndErr[1]

    with open(currentDir + "/procOxOutBot.dat", 'r') as f:
        lines = f.readlines()
    words = (lines[-1]).split()
    rateAndErr = (words[12]).split('+/-')
    botOutRate = rateAndErr[0]
    botOutErr = rateAndErr[1]

    resultsTable.append([(botConc, topConc), (float(topInRate), float(topInErr)), (float(topOutRate), float(topOutErr)), (float(botInRate), float(botInErr)), (float(botOutRate), float(botOutErr)), fullRate])
    
    typeHistory = []
    finalTime = 0.0
    initialTime = 0.0
    typeFile = open(currentDir+"/typeStats.dat", "w")
    typeChangeTable = []
    for index in range(0, sysSize):
        typeChangeTable.append([])
    with open(currentDir + "/trajRecord.tr", 'r') as f:
        for line in f:
            words = line.split()
            typeChangeTable[int(words[2])].append((0.5*(float(words[0])+float(words[1])), words[3]))
            finalTime = float(words[1])
    print("Finished reading from file.\n")
    with open(currentDir + "/trajRecord.tr", 'r') as f:
        line = f.readline()
        words = line.split()
        initialTime = float(words[0])

    numTimeChunks = sysSize
    timeChunkSize = (finalTime-initialTime)/float(sysSize)
    for siteIndex in range(2, sysSize-2):
        changes = typeChangeTable[siteIndex]
        chunkStart = 0
        chunkEnd = 0
        currentLength = len(changes)
        #print("Number of changes is "+str(currentLength))
        for timeChunkIndex in range (1, numTimeChunks-1):
            while chunkStart+1<currentLength and changes[chunkStart+1][0] < timeChunkIndex*timeChunkSize+initialTime:
                chunkStart += 1
            while chunkEnd+1<currentLength and changes[chunkEnd+1][0] < (timeChunkIndex+1)*timeChunkSize+initialTime:
                chunkEnd += 1
            #print("chunkStart = "+str(chunkStart)+"; chunkEnd = "+str(chunkEnd)+"\n")
            tempTotal = 0.0
            overallTotal = 0.0
            if chunkStart == chunkEnd:
                if changes[chunkStart][1] == "O":
                    tempTotal += timeChunkSize
                overallTotal += timeChunkSize
            else:
                if changes[chunkStart][1] == "O":
                    tempTotal += changes[chunkStart+1][0] - (timeChunkIndex*timeChunkSize+initialTime)
                overallTotal += changes[chunkStart+1][0] - (timeChunkIndex*timeChunkSize+initialTime)
                for timeIndex in range(chunkStart+1, chunkEnd):
                    if changes[timeIndex][1] == "O":
                        tempTotal += changes[timeIndex+1][0] - changes[timeIndex][0]
                        #print("O "+str(changes[timeIndex+1][0] - changes[timeIndex][0]))
                    #else:
                        #print("V "+str(changes[timeIndex+1][0] - changes[timeIndex][0]))
                    overallTotal += changes[timeIndex+1][0] - changes[timeIndex][0]
                        #print("O")
                    #else:
                        #print("V")
                if changes[chunkEnd][1] == "O":
                    tempTotal += (timeChunkIndex+1)*timeChunkSize+initialTime - changes[chunkEnd][0]
                overallTotal += (timeChunkIndex+1)*timeChunkSize+initialTime - changes[chunkEnd][0]
            typeFile.write(str(tempTotal/overallTotal)+" ")
        typeFile.write("\n")
        #print("Site "+str(siteIndex)+" complete.\n")
    typeFile.close()




    #print(str(diffConc)+" "+topInRate+" "+topInErr+" "+topOutRate+" "+topOutErr+" "+botInRate+" "+botInErr+" "+botOutRate+" "+botOutErr)
    g.write(str(botConc)+" "+str(topConc)+" "+topInRate+" "+topInErr+" "+topOutRate+" "+topOutErr+" "+botInRate+" "+botInErr+" "+botOutRate+" "+botOutErr+"\n")
g.write("\n")
g.close()
pickle.dump(resultsTable, open(resultsPlace+"mainResults.p", "wb"))

flow = []
flowErr = []
gradient = []

for i in resultsTable:
    flow.append(i[1][0]+i[4][0]-i[2][0]-i[3][0])
    flowErr.append(numpy.sqrt(i[1][1]**2+i[4][1]**2+i[2][1]**2+i[3][1]**2))
    gradient.append(i[0][1]-i[0][0])
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
# This stuff works, but is far too slow =(
    for siteIndex in range(2, sysSize-2):
        changeTimes = []
        timeOccupation = []
        previousType = "V"
        for steps in typeChangeTable[siteIndex]:
            changeTimes.append(steps[0])
            if previousType == "O":
                timeOccupation.append(1.0)
            else:
                timeOccupation.append(0.0)
            changeTimes.append(steps[1])
            previousType = steps[2]
            if previousType == "O":
                timeOccupation.append(1.0)
            else:
                timeOccupation.append(0.0)
        print("Finished calculating weightings for site "+str(siteIndex)+".\n")
        typeChangeTable[siteIndex] = []
        # So at this point, we have a load of times and what their weightings should be multiplied by.
        # Therefore at this point, we should find the times relevant to a particular time chunk, copy these into a separate list
        # which is shifted to bring things back to zero at the start of the relvant timeChunk, then feed that list to pPU.weightingsFinder.
        chunkStart = 0
        chunkEnd = 0
        for timeChunkIndex in range (1, numTimeChunks-1):
            while changeTimes[chunkStart+1] < timeChunkIndex*timeChunkSize:
                chunkStart += 1
            while changeTimes[chunkEnd] < (timeChunkIndex+1)*timeChunkSize:
                chunkEnd += 1
            tempTimeList = []
            tempOccupancies = []
            for timeIndex in range(chunkStart, chunkEnd+1):
                tempTimeList.append(changeTimes[timeIndex]-(timeChunkIndex-1)*timeChunkSize)
                tempOccupancies.append(timeOccupation[timeIndex])
            weightings = pPU.weightingsFinder(tempTimeList, timeChunkSize)
            tempTotal = 0.0
            chunkWeights = weightings[1]
            for weight in chunkWeights[1]:
                tempTotal += tempOccupancies[weight[0]]*weight[1]
            typeFile.write(str(tempTotal*float(sysSize)/finalTime)+" ")"""


#    weightings = pPU.weightingsFinder(times, timeChunkSize)
#    numTypes = len(types[1])
#    typeStats = []
#    
#    with open(currentDir+"/types.dat", "w") as kindFile:
#        for typeList in types:
#            #print(typeList)
#            for kind in range(0, len(typeList)):
#                #print(str(kind))
#                kindFile.write(typeList[kind])
#            kindFile.write("\n")
#    
#    for typeIndex in range(0, numTypes):
#        typeHistory = []
#        for chunkWeights in weightings:
#            tempTotal = 0.0
#            for weight in chunkWeights[1]:
#                temp = types[weight[0]]
#                if temp[typeIndex] == "O":
#                    tempTotal += weight[1]
#            typeHistory.append([chunkWeights[0], tempTotal/timeChunkSize])
#        typeStats.append(typeHistory)
#    
#    with open(currentDir+"/typeStats.dat", "w") as typeFile:
#        for typeHistory in typeStats:
#            for chunk in typeHistory:
#                typeFile.write(str(chunk[1])+" ")
#            typeFile.write("\n") 
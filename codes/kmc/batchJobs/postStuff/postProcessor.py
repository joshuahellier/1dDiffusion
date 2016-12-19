import sys
import os
import numpy
import math

timeChunkSize = 0.0

resultDir = os.environ.get('RESULTS')
if resultDir == None :
    print ("WARNING! $RESULTS not set! Attempt to write results will fail!\n")

fileInfo = sys.argv[1]
resultsPlace = resultDir+"/"+fileInfo+"/"

if not os.path.exists(resultsPlace):
    print ("WARNING! The results directory requested does not exist! Perhaps there is some typo...\n")
    exit()



resultsTable = []
inTopResults = []
outTopResults = []
inBotResults = []
outBotResults = []
topFlowResults = []
botFlowResults = []
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

fileName = resultsPlace+"mathFormatData.dat"
try:
    os.remove(fileName)
except OSError:
    pass

fileName = resultsPlace+"topFlowData.dat"
try:
    os.remove(fileName)
except OSError:
    pass

fileName = resultsPlace+"botFlowData.dat"
try:
    os.remove(fileName)
except OSError:
    pass

fileName = resultsPlace+"inTopData.dat"
try:
    os.remove(fileName)
except OSError:
    pass

fileName = resultsPlace+"outBotData.dat"
try:
    os.remove(fileName)
except OSError:
    pass

fileName = resultsPlace+"inBotData.dat"
try:
    os.remove(fileName)
except OSError:
    pass

fileName = resultsPlace+"outTopData.dat"
try:
    os.remove(fileName)
except OSError:
    pass

fileName = resultsPlace+"concData.dat"
try:
    os.remove(fileName)
except OSError:
    pass

fileName = resultsPlace+"redConcData.dat"
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

    currentList = os.listdir(currentDir+"/outTop")
    totalTime = 0.0
    totalCounts = 0
    totalSquareSum = 0.0
    totalRateSum = 0.0
    totalRateSum = 0.0
    totalSquareSum = 0.0
    totalRateTopSum = 0.0
    totalTopSquareSum = 0.0
    totalRateBotSum = 0.0
    totalBotSquareSum = 0.0
    totalRateInTopSum = 0.0
    totalRateOutTopSum = 0.0
    totalRateInBotSum = 0.0
    totalRateOutBotSum = 0.0
    totalInTopSquareSum = 0.0
    totalOutTopSquareSum = 0.0
    totalInBotSquareSum = 0.0
    totalOutBotSquareSum = 0.0
    totalDensity = 0.0
    totalSquareDensity = 0.0
    for passNum in range(0, len(currentList)):

        with open(currentDir +"/outTop/outTop"+str(passNum)+".dat", 'r') as f:
            lines = f.readlines()
            words = (lines[-1]).split()
            timeStep = float(words[-1])
            totalTime += timeStep
            outTop = int(words[-2])

        with open(currentDir +"/inTop/inTop"+str(passNum)+".dat", 'r') as f:
            lines = f.readlines()
            words = (lines[-1]).split()
            inTop = int(words[-2])

        with open(currentDir +"/outBot/outBot"+str(passNum)+".dat", 'r') as f:
            lines = f.readlines()
            words = (lines[-1]).split()
            outBot = int(words[-2])

        with open(currentDir +"/inBot/inBot"+str(passNum)+".dat", 'r') as f:
            lines = f.readlines()
            words = (lines[-1]).split()
            inBot = int(words[-2])

        if timeStep != 0.0:
            rate = float(inBot + outTop - inTop - outBot)/(2.0*timeStep)
            rateTop = float(outTop-inTop)/timeStep
            rateBot = float(inBot-outBot)/timeStep
            rateInTop = float(inTop)/timeStep
            rateOutTop = float(outTop)/timeStep
            rateInBot = float(inBot)/timeStep
            rateOutBot = float(outBot)/timeStep
        else:
            rate = 0.0
            rateTop = 0.0
            rateBot = 0.0


        totalRateSum += rate
        totalSquareSum += rate*rate
        totalRateTopSum += rateTop
        totalTopSquareSum += rateTop*rateTop
        totalRateBotSum += rateBot
        totalBotSquareSum += rateBot*rateBot
        totalRateInTopSum += rateInTop
        totalRateOutTopSum += rateOutTop
        totalRateInBotSum += rateInBot
        totalRateOutBotSum += rateOutBot
        totalInTopSquareSum += rateInTop*rateInTop
        totalOutTopSquareSum += rateOutTop*rateOutTop
        totalInBotSquareSum += rateInBot*rateInBot
        totalOutBotSquareSum += rateOutBot*rateOutBot

        oxConc = 0.0
        with open(currentDir+"/composition/composition"+str(passNum)+".dat", 'r') as f:
            lines = f.readlines()
            for lineIndex in range(1, len(lines)):
                words = lines[lineIndex].split()
                oxyTot = float(words[1])
                vacTot = float(words[2])
                oxConc = oxyTot/(oxyTot+vacTot)
        totalDensity += oxConc
        totalSquareDensity += oxConc*oxConc

    flowMean = totalRateSum/len(currentList)
    flowErr = numpy.sqrt((totalSquareSum - totalRateSum*totalRateSum/len(currentList))/(len(currentList)-1))
    flowTopMean = totalRateTopSum/len(currentList)
    flowTopErr = numpy.sqrt((totalTopSquareSum - totalRateTopSum*totalRateTopSum/len(currentList))/(len(currentList)-1))
    flowBotMean = totalRateBotSum/len(currentList)
    flowBotErr = numpy.sqrt((totalBotSquareSum - totalRateBotSum*totalRateBotSum/len(currentList))/(len(currentList)-1))
    flowInBotMean = totalRateInBotSum/len(currentList)
    flowInBotErr = numpy.sqrt((totalInBotSquareSum - totalRateInBotSum*totalRateInBotSum/len(currentList))/(len(currentList)-1))
    flowOutBotMean = totalRateOutBotSum/len(currentList)
    flowOutBotErr = numpy.sqrt((totalOutBotSquareSum - totalRateOutBotSum*totalRateOutBotSum/len(currentList))/(len(currentList)-1))
    flowInTopMean = totalRateInTopSum/len(currentList)
    flowInTopErr = numpy.sqrt((totalInTopSquareSum - totalRateInTopSum*totalRateInTopSum/len(currentList))/(len(currentList)-1))
    flowOutTopMean = totalRateOutTopSum/len(currentList)
    flowOutTopErr = numpy.sqrt((totalOutTopSquareSum - totalRateOutTopSum*totalRateOutTopSum/len(currentList))/(len(currentList)-1))

    densityMean = totalDensity/len(currentList)
    densityErr = numpy.sqrt((totalSquareDensity-totalDensity*totalDensity/len(currentList))/(len(currentList)-1))

    

    if not (math.isnan(flowMean) or math.isnan(flowErr)):
        resultsTable.append([(botConc, topConc), (flowMean, flowErr), (densityMean, densityErr), fullRate])

    if not(math.isnan(flowInTopMean) or math.isnan(flowInTopErr)):
        inTopResults.append(str((botConc-topConc)/float(sysSize-4))+" "+str(flowInTopMean)+" "+str(flowInTopErr)+"\n")

    if not(math.isnan(flowInBotMean) or math.isnan(flowInBotErr)):
        inBotResults.append(str((botConc-topConc)/float(sysSize-4))+" "+str(flowInBotMean)+" "+str(flowInBotErr)+"\n")

    if not(math.isnan(flowOutTopMean) or math.isnan(flowOutTopErr)):
        outTopResults.append(str((botConc-topConc)/float(sysSize-4))+" "+str(flowOutTopMean)+" "+str(flowOutTopErr)+"\n")

    if not(math.isnan(flowOutBotMean) or math.isnan(flowOutBotErr)):
        outBotResults.append(str((botConc-topConc)/float(sysSize-4))+" "+str(flowOutBotMean)+" "+str(flowOutBotErr)+"\n")

    if not(math.isnan(flowTopMean) or math.isnan(flowTopErr)):
        topFlowResults.append(str((botConc-topConc)/float(sysSize-4))+" "+str(flowTopMean)+" "+str(flowTopErr)+"\n")

    if not(math.isnan(flowBotMean) or math.isnan(flowBotErr)):
        botFlowResults.append(str((botConc-topConc)/float(sysSize-4))+" "+str(flowBotMean)+" "+str(flowBotErr)+"\n")
    """
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
    typeFile.close() """


    #print(str(diffConc)+" "+topInRate+" "+topInErr+" "+topOutRate+" "+topOutErr+" "+botInRate+" "+botInErr+" "+botOutRate+" "+botOutErr)
    if not (math.isnan(flowMean) or math.isnan(flowMean)):
        g.write(str(botConc)+" "+str(topConc)+" "+str(densityMean)+" "+str(densityErr)+" "+str(flowMean)+" "+str(flowErr)+"\n")
g.write("\n")
g.close()
#pickle.dump(resultsTable, open(resultsPlace+"mainResults.p", "wb"))


flow = []
flowErr = []
gradient = []

with open(resultsPlace+"mathFormatData.dat", 'w') as f:
    for i in resultsTable:
        f.write(str((i[0][0]-i[0][1])/float(sysSize))+" "+str(i[1][0])+" "+str(i[1][1])+"\n")

with open(resultsPlace+"concData.dat", 'w') as f:
    for i in resultsTable:
        f.write(str((i[0][0]+i[0][1])/2.0)+" "+str(i[2][0])+" "+str(i[2][1])+"\n")

with open(resultsPlace+"redConcData.dat", 'w') as f:
    concTotal = 0.0
    concVarTot = 0.0
    avConc = 0.0
    for i in resultsTable:
        concTotal += i[2][0]
        concVarTot += i[2][1]*i[2][1]
        avConc = 0.5*(i[0][0]+i[0][1])
    measConc = concTotal/len(resultsTable)
    measErr = numpy.sqrt(concVarTot)/len(resultsTable)
    tableEntry = str(avConc)+" "+str(measConc)+" "+str(measErr)
    f.write(tableEntry)

with open(resultsPlace+"topFlowData.dat", 'w') as f:
    for i in topFlowResults:
        f.write(i)

with open(resultsPlace+"botFlowData.dat", 'w') as f:
    for i in botFlowResults:
        f.write(i)

with open(resultsPlace+"inTopData.dat", 'w') as f:
    for i in inTopResults:
        f.write(i)

with open(resultsPlace+"outTopData.dat", 'w') as f:
    for i in outTopResults:
        f.write(i)

with open(resultsPlace+"inBotData.dat", 'w') as f:
    for i in inBotResults:
        f.write(i)

with open(resultsPlace+"outBotData.dat", 'w') as f:
    for i in outBotResults:
        f.write(i)

for i in resultsTable:
    flow.append(i[1][0])
    flowErr.append(i[1][1])
    gradient.append((i[0][0]-i[0][1])/float(sysSize-4))
    #print(str(gradient[-1])+" "+str(flow[-1])+" "+str(flowErr[-1]))


import pandas as pd
import numpy as np
import statsmodels.formula.api as sm

y_list = gradient
x_list = flow
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

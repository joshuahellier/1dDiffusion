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

    outTopData = []
    inTopData = []
    outBotData = []
    inBotData = []

    with open(currentDir +"/outTop.dat", 'r') as f:
        outTopData = f.readlines()

    with open(currentDir +"/inTop.dat", 'r') as f:
        inTopData = f.readlines()

    with open(currentDir +"/outBot.dat", 'r') as f:
        outBotData = f.readlines()

    with open(currentDir +"/inBot.dat", 'r') as f:
        inBotData = f.readlines()

    totalTime = 0.0
    totalCounts = 0
    totalSquareSum = 0.0
    totalRateSum = 0.0
    totalDensity = 0.0
    totalSquareDensity = 0.0
    numPasses = len(outTopData)
    for passNum in range(0, numPasses):

        rate = (float(inBotData[passNum]) + float(outTopData[passNum]) - float(inTopData[passNum]) - float(outBotData[passNum]))/2.0
        totalRateSum += rate
        totalSquareSum += rate*rate

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

    if not (numPasses==0 or numPasses==1):
        flowMean = totalRateSum/numPasses
        flowErr = numpy.sqrt((totalSquareSum - totalRateSum*totalRateSum/numPasses)/(numPasses-1))

        densityMean = totalDensity/numPasses
        densityErr = numpy.sqrt((totalSquareDensity-totalDensity*totalDensity/numPasses)/(numPasses-1))

    

        if not (math.isnan(flowMean) or math.isnan(flowErr)):
            resultsTable.append([(botConc, topConc), (flowMean, flowErr), (densityMean, densityErr), fullRate])

        if not (math.isnan(flowMean) or math.isnan(flowMean)):
            g.write(str(botConc)+" "+str(topConc)+" "+str(densityMean)+" "+str(densityErr)+" "+str(flowMean)+" "+str(flowErr)+"\n")

g.write("\n")
g.close()

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


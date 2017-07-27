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

numChunks = int(sys.argv[2])

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
"""
fileName = resultsPlace+"mainResults.p"
try:
    os.remove(fileName)
except OSError:
    pass
"""

directoryList = os.listdir(resultsPlace)

for i in directoryList:

    sites = []
    times = []
    steps = []
    types = []
    typesTimeAverage = []
    currentDir = resultsPlace+i
    print("Considering file "+currentDir+"\n")

    #execfile(currentDir+"/traj.tr")

    with open(currentDir + "/settings2", 'r') as f:
        lines = f.readlines()
    words = (lines[0]).split()
    botConc = float(words[2])
    words = (lines[1]).split()
    topConc = float(words[2])
    words = (lines[2]).split()
    fullRate = float(words[2])
    words = (lines[3]).split()
    sysSize = int(words[2])+4

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

    numTimeChunks = numChunks
    timeChunkSize = (finalTime-initialTime)/numChunks
    densityTable = []
    for siteIndex in range(2, sysSize-2):
        tempArray = []
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
            tempArray.append(tempTotal/overallTotal)
        typeFile.write("\n")
        densityTable.append(tempArray)
    spaceLagWidth = 24
    timeLagWidth = 2
    targetSite = 64
    correlationTable = []
    targetAverage = 0.0
    targList = densityTable[targetSite]
    for i in targList:
        targetAverage += i
    targetAverage/=float(numTimeChunks)
    for spaceLag in range(-spaceLagWidth, spaceLagWidth):
        lagAverage = 0.0
        lagList = densityTable[targetSite+spaceLag]
        for i in lagList:
            lagAverage += i
        lagAverage/=float(numTimeChunks)
        tempList = []
        for timeLag in range(-timeLagWidth, timeLagWidth):
            corrAverage = 0.0
            for timeIndex in range(timeLagWidth, numTimeChunks-timeLagWidth-2):
                corrAverage += targList[timeIndex]*lagList[timeIndex+timeLag]
            corrAverage/=float(numTimeChunks-2*timeLagWidth-2)
            tempList.append(corrAverage-targetAverage*lagAverage)
        correlationTable.append(tempList)
    typeFile.close()
    normaliser = correlationTable[spaceLagWidth][timeLagWidth]
    with open(currentDir+"/corrData.dat", 'w') as corrFile:
        for spaceLag in range(-spaceLagWidth, spaceLagWidth):
            timeLag = 0
            corrFile.write(str(spaceLag)+" "+str(correlationTable[spaceLag+spaceLagWidth][timeLag+timeLagWidth]/normaliser)+"\n")
print("Process appears to have successfully exited.\n")

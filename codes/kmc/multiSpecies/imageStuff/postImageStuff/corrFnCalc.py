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

dataLimit = int(sys.argv[3])

if not os.path.exists(resultsPlace):
    print ("WARNING! The results directory requested does not exist! Perhaps there is some typo...\n")
    exit()

directoryList = os.listdir(resultsPlace)

for i in directoryList:
    correlations = []
    currentDir = resultsPlace+i
    print("Considering file "+currentDir+"\n")
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
    
    # First, let's gather information about the time interval we're actually working over,
    # and for the site we'll be focussing on
    centreSite = sysSize/2
    finalTime = 0.0
    initialTime = 0.0
    siteRecord = []
    initFlag = False
    counter = 0
    with open(currentDir+"/trajRecord.tr", "r") as  typeFile:
        for line in typeFile:
            words = line.split()
            if initFlag==False:
                initFlag = True
                initialTime = float(words[0])
            finalTime = float(words[1])
            if int(words[2])==centreSite:
                siteRecord.append((0.5*(float(words[0]) + float(words[1])), words[3]))
            counter+=1
            if counter>dataLimit:
                break
    numTimeChunks = numChunks
    timeChunkSize = (finalTime-initialTime)/numChunks
    centreRecord = []
    if True:
        changes = siteRecord
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
            centreRecord.append(tempTotal/overallTotal)
    centreDensity = 0.0
    for density in centreRecord:
        centreDensity += density
    centreDensity/=len(centreRecord)
    print("Done central thread.")
    spaceLagWidth = int(sysSize/4)
    for spaceLag in range(-spaceLagWidth, spaceLagWidth+1):
        currentRecord = []
        siteRecord = []
        counter = 0
        with open(currentDir+"/trajRecord.tr", "r") as  typeFile:
            for line in typeFile:
                words = line.split()
                if int(words[2])==centreSite+spaceLag:
                    siteRecord.append((0.5*(float(words[0]) + float(words[1])), words[3]))
                counter+=1
                if counter>dataLimit:
       	       	    break
        changes = siteRecord
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
            currentRecord.append(tempTotal/overallTotal)
        lagDensity = 0.0
        for density in currentRecord:
            lagDensity += density
        lagDensity/=len(currentRecord)
        
        corrFn = 0.0
        for index in range(0, len(currentRecord)):
            corrFn += currentRecord[index]*centreRecord[index]
        corrFn/=len(currentRecord)
        corrFn -= lagDensity*centreDensity
        correlations.append(str(spaceLag)+" "+str(corrFn)+"\n")
        print("Done "+str(spaceLag)+".")
    with open(currentDir+"/corrData.dat", 'w') as corrFile:
        for entry in correlations:
            corrFile.write(entry)

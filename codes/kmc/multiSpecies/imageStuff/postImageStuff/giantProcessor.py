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

    giantDirs = os.listdir(currentDir+"/giantStats")
    maxExp = int(math.floor(math.log(sysSize-4, 2)))
    flucs = []
    denss = []
    for j in range(0, maxExp):
        flucs.append([])
        denss.append([])
    for giantData in giantDirs:
        with open(currentDir+"/giantStats/"+giantData) as f:
            lines = f.readlines()
            for j in range(0, maxExp):
                words = (lines[j]).split()
                flucs[j].append(float(words[2]))
                denss[j].append(float(words[1]))
    results = []
    for j in range(0, maxExp):
        meanFluc = sum(flucs[j])/float(len(flucs[j]))
        diffs = []
        for item in flucs[j]:
            diffs.append((item - meanFluc)*(item - meanFluc))
        diffSum = (sum(diffs)/float(len(diffs)))
        stdDevFluc = math.sqrt(diffSum)
        meanDens = sum(denss[j])/float(len(denss[j]))
        diffs = []
        for item in denss[j]:
            diffs.append((item - meanDens)*(item - meanDens))
        diffSum = (sum(diffs)/float(len(diffs)))
        stdDevDens = math.sqrt(diffSum)
        results.append(str(2*j)+" "+str(meanDens)+" "+str(stdDevDens)+" "+str(meanFluc)+" "+str(stdDevFluc)+"\n")
    with open(currentDir+"/procGiantData.pro", 'w') as f:
        for item in results:
            f.write(item)

print("Process appears to have successfully exited.\n")

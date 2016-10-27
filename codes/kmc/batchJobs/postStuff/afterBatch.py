import sys
import os
import numpy
import subprocess

resultDir = os.environ.get('RESULTS')
if resultDir == None :
    print ("WARNING! $RESULTS not set! Attempt to write results will fail!\n")

fileInfo = sys.argv[1]
resultsPlace = resultDir+"/"+fileInfo+"/"

if not os.path.exists(resultsPlace):
    print ("WARNING! The results directory requested does not exist! Perhaps there is some typo...\n")
    exit()

#Firstly, get rid of any files which could cause trouble and crash things

topDirectoryList = os.listdir(resultsPlace)
fullRate = 0.0
avConc = 0.0

for topLevel in topDirectoryList:
    fileName = resultsPlace+topLevel+"/overallData.dat"
    try:
        os.remove(fileName)
    except OSError:
        pass
    midDirectoryList = os.listdir(resultsPlace+topLevel)
    resultsTable = []
    concTable = []
    for midLevel in midDirectoryList:
        location = fileInfo+"/"+topLevel+"/"+midLevel

        with open(resultDir+"/"+location+"/0/settings") as f:
            lines = f.readlines()
            words = lines[0].split()
            botConc = float(words[-1])
            words = lines[1].split()
            topConc = float(words[-1])
            avConc = 0.5*(topConc+botConc)
            words = lines[2].split()
            fullRate = float(words[-1])
        tableEntry = ""
        try:
            with open(resultDir+"/"+location+"/regressionData.dat") as f:
                lines = f.readlines()
                words = lines[-1].split()
                tableEntry = str(avConc)+" "+str(words[0])+" "+str(words[1])
        except OSError:
             tableEntry = ""
        resultsTable.append(tableEntry)

        try:
            with open(resultDir+"/"+location+"/concData.dat") as f:
                lines = f.readlines()
                concTotal = 0.0
                concVarTot = 0.0
                avConc = 0.0
                for line in lines:
                    words = line.split()
                    concTotal += float(words[1])
                    concVarTot += float(words[2])*float(words[2])
                    avConc = float(words[0])
                measConc = concTotal/len(lines[0])
                measErr = numpy.sqrt(concVarTot)/len(lines[0])
                tableEntry = str(avConc)+" "+str(measConc)+" "+str(measErr)
        except OSError:
            tableEntry = ""
        concTable.append(tableEntry)
    with open(resultsPlace+topLevel+"/"+"overallData.dat", 'w') as f:
        for res in resultsTable:
            f.write(res+"\n")


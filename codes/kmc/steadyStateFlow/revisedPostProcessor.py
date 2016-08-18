import sys
import os
import numpy
import subprocess

resultDir = os.environ.get('RESULTS')
if resultDir == None :
    print "WARNING! $RESULTS not set! Attempt to write results will fail!\n"

fileInfo = sys.argv[1]
resultsPlace = resultDir+"/"+fileInfo+"/"

if not os.path.exists(resultsPlace):
    print "WARNING! The results directory requested does not exist! Perhaps there is some typo...\n"
    exit()

resultsTable = []

#Firstly, get rid of any files which could cause trouble and crash things
fileName = resultsPlace+"resultSummary.dat"
try:
    os.remove(fileName)
except OSError:
    pass

topDirectoryList = os.listdir(resultsPlace)


for topLevel in topDirectoryList:
    midDirectoryList = os.listdir(resultsPlace+topLevel)
    for midLevel in midDirectoryList:
        location = fileInfo+"/"+topLevel+"/"+midLevel
        print location
        jobInput = "python postProcessor.py "+location+" "+str(0.0)
        p = subprocess.Popen(jobInput, shell=True)
        exitCodes = p.wait()
        with open(resultsPlace+topLevel+"/"+midLevel+"/regressionData.dat", 'r') as f:
            lines = f.readlines()
        words = (lines[-1]).split()
        rate = float(words[0])
        error = float(words[1])
        resultsTable.append(topLevel+" "+midLevel+" "+str(rate)+" "+str(error)+"\n")
        

with open(resultsPlace+"resultSummary.dat", 'w') as g:
    for result in resultsTable:
        g.write(result)

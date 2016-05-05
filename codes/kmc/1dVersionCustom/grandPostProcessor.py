import subprocess
import sys
import os

resultDir = os.environ.get('RESULTS')
if resultDir == None :
    print "WARNING! $RESULTS not set! Attempt to write results will fail!\n"

fileInfo = sys.argv[1]
resultsPlace = resultDir+"/"+fileInfo+"/"
if not os.path.exists(resultsPlace):
    print"WARNING! The results directory requested does not exist! Perhaps there is some typo...\n"
    exit()
directoryList = os.listdir(resultsPlace)

for i in directoryList:
    jobInput = "python postProcessor.py "+fileInfo+"/"+i
    p = subprocess.Popen(jobInput, shell=True)
    exitCodes = p.wait()

resultsTable = []
lines = []

for i in directoryList:
    fullRate = float(i)
    with open(resultsPlace + i + "/regressionData.dat", 'r') as f:
        lines = f.readlines()
    words = (lines[-1]).split()
    resultsTable.append([fullRate, float(words[0]), float(words[1])])
    print(i+" "+words[0]+" "+words[1])

with open(resultsPlace+"flowResponse.dat", 'w') as f:
    for i in resultsTable:
        f.write(str(i[0])+" "+str(i[1])+" "+str(i[2])+"\n")

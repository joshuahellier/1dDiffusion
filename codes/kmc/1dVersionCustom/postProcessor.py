import sys
import os
import numpy
import cPickle as pickle

resultDir = os.environ.get('RESULTS')
if resultDir == None :
    print "WARNING! $RESULTS not set! Attempt to write results will fail!\n"

fileInfo = sys.argv[1]
resultsPlace = resultDir+"/"+fileInfo+"/"

if not os.path.exists(resultsPlace):
    print"WARNING! The results directory requested does not exist! Perhaps there is some typo...\n"
    exit()

directoryList = os.listdir(resultsPlace)

resultsTable = []
lines = []
words = []

g = open(resultsPlace+"regressionData.dat", 'w')

for i in directoryList:
    sites = []
    times = []
    steps = []
    types = []
    typesTimeAverage = []
    currentDir = resultsPlace+i

    execfile(currentDir+"/traj.tr")

    with open(currentDir + "/settings", 'r') as f:
        lines = f.readlines()
    words = (lines[1]).split()
    diffConc = float(words[2])
    words = (lines[3]).split()
    sysSize = int(words[2])
    words = (lines[3]).split()
    timeInterval = int(words[2])

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

    resultsTable.append([diffConc, (float(topInRate), float(topInErr)), (float(topOutRate), float(topOutErr)), (float(botInRate), float(botInErr)), (float(botOutRate), float(botOutErr))])

    print("Testing!\n")
    # Now to try to work out time-averaged occupation from the traj.tr files.
    weightings = []
    chunklets = []
    currentChunklet = []
    timeChunkIndex = 0
    mainIndex = 0
    """Just for now!"""
    timeInterval = 100000.0
    for j in times:
        print(j)
        if float(j) < float(timeChunkIndex+1)*timeInterval:
            currentChunklet.append(mainIndex)
        else:
            chunklets.append(currentChunklet)
            currentChunklet = []
            currentChunklet.append(mainIndex)
            timeChunkIndex = timeChunkIndex+1
        mainIndex = mainIndex + 1

    for j in chunklets:
        print(j)

    print("Done testing!\n")
            
    #print(str(diffConc)+" "+topInRate+" "+topInErr+" "+topOutRate+" "+topOutErr+" "+botInRate+" "+botInErr+" "+botOutRate+" "+botOutErr)
    g.write(str(diffConc)+" "+topInRate+" "+topInErr+" "+topOutRate+" "+topOutErr+" "+botInRate+" "+botInErr+" "+botOutRate+" "+botOutErr+"\n")
g.write("\n")
g.close()
pickle.dump(resultsTable, open(resultsPlace+"mainResults.p", "wb"))

flow = []
flowErr = []
gradient = []

for i in resultsTable:
    flow.append(i[1][0]+i[4][0]-i[2][0]-i[3][0])
    flowErr.append(numpy.sqrt(i[1][1]**2+i[4][1]**2+i[2][1]**2+i[3][1]**2))
    gradient.append(i[0]/float(sysSize))
    print(str(gradient[-1])+" "+str(flow[-1])+" "+str(flowErr[-1]))

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
# let's plot our data
plt.clf()
fig = plt.figure()
ax = fig.add_subplot(111, axisbg='w')
ws.plot(
    kind='scatter',
    x='x',
    y='y',
    style='o',
    alpha=1.,
    ax=ax,
    title='Flow as a function of gradient',
    edgecolor='#ff8300',
    s=40
)

# weighted prediction
wp, = ax.plot(
    wls_fit.predict(),
    ws['y'],
    color='#e55ea2',
    lw=1.,
    alpha=1.0,
)

# unweighted prediction
op, = ax.plot(  
    ols_fit.predict(),
    ws['y'],
    color='k',
    ls='solid',
    lw=1,
    alpha=1.0,
)
leg = plt.legend(
    (op, wp),
    ('Ordinary Least Squares', 'Weighted Least Squares'),
    loc='upper left',
    fontsize=8)

plt.tight_layout()
fig.set_size_inches(6.40, 5.12)
plt.savefig(resultsPlace+"so.png", dpi=100, alpha=True)
plt.show()
"""



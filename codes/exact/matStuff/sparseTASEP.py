import scipy.sparse as sp
import scipy.sparse.linalg as la
import numpy as np
import math as m
import time
import sys
import os

resultDir = os.environ.get('RESULTS')
if resultDir == None :
    print ("WARNING! $RESULTS not set! Attempt to write results will fail!\n")

botLoad = float(sys.argv[1])
topUnload = float(sys.argv[2])
L = np.uint32(int(sys.argv[3]))
numVecs = int(sys.argv[4])
tolerance = float(sys.argv[5])
fileInfo = sys.argv[6]

resultsPlace = resultDir+"/"+fileInfo+"/"

if not os.path.exists(resultsPlace):
    os.makedirs(resultsPlace)

with open(resultsPlace+'settings', 'w') as f:
    f.write('BotLoad = ' + str(botLoad) +'\n')
    f.write('TopUnload = ' + str(topUnload) +'\n')
    f.write('SysSize = ' + str(L) +'\n')
    f.write('NumVecs = ' + str(numVecs)+'\n')
    f.write('Tolerance = ' +str(tolerance)+'\n')

N = np.uint32(2**(L))

rateMatrix = sp.lil_matrix((N, N), dtype = np.float64)
densityMatrix = sp.lil_matrix((L, N), dtype = np.float64)
currentMatrix = sp.lil_matrix((L-1, N), dtype = np.float64)


for i in range(0, N):
    state = format(i, '032b')
    totLeakage = 0.0
    if True:
        position = 32-L
        if state[position] == '1':
            pass
        else:
            newState = state[:position]+'1'+state[(position+1):]
#            print state
#            print newState
            j = np.uint32(int(newState, 2))
#            print format(j, '032b')+"\n"
            rateMatrix[j, i] += botLoad
            totLeakage += botLoad
    for position in range(32 - L , 31):
        if state[position] == '1':
            densityMatrix[position-(32-L), i] = 1
            if state[position+1] == '0':
                newState = state[:(position)]+'0'+'1'+state[(position+2):]
#                print state
#                print newState
                j = np.uint32(int(newState, 2))
#                print format(j, '032b')+"\n"
                if True:
                    rateMatrix[j, i] += 1.0
                    currentMatrix[position  - (32-L), i] += 1.0
                    totLeakage += 1.0
    if True:
        position = 31
        if state[position] == '1':
            densityMatrix[position-(32-L), i] = 1
            newState = state[:position]+'0'+state[(position+1):]
#            print state
#            print newState
            j = np.uint32(int(newState, 2))
#            print format(j, '032b')+"\n"
            rateMatrix[j, i] += topUnload
            totLeakage += topUnload
        else:
            pass
    rateMatrix[i, i] -= totLeakage

print("RateMatrix created.")

cscRateMatrix = rateMatrix.tocsc()
cscDensityMatrix = densityMatrix.tocsc()
cscCurrentMatrix = currentMatrix.tocsc()

print("RateMatrix reformatted.")

t0 = time.clock()
vals, vecs = la.eigs(cscRateMatrix, k=numVecs, sigma=0.0, tol=tolerance, maxiter=10000*N)
errs = []
for index in range(0, numVecs):
    vecs[:, index] = np.sign(vecs[N/2, index])*vecs[:, index]/(np.linalg.norm(vecs[:, index], 1))
    errs.append(2.0*np.linalg.norm(cscRateMatrix.dot(vecs[:, index])-vals[index]*vecs[:, index], 1)/(np.linalg.norm(cscRateMatrix.dot(vecs[:, index]), 1)+np.abs(vals[index])*np.linalg.norm(vecs[:, index], 1)))
t1 = time.clock()

print(str(t1-t0)+"s for csc eigenvector find\n")

#print("So final result for the eigenvalues is "+str(vals)+"\n")
#print("|Ax-lambda x| = ")
#for index in range(0, numVecs):
#    print str(np.linalg.norm(cscRateMatrix.dot(vecs[:, index])-vals[index]*vecs[:, index], 1))+" with |x| = "+str(np.linalg.norm(vecs[:, index], 1))

#print("\nThe mean occupation should be:\n")
avDens = cscDensityMatrix.dot(vecs)
#print avDens
#print("\nThe mean current should be:\n")
avCurr = cscCurrentMatrix.dot(vecs)
#print avCurr


with open(resultsPlace+'eigenvalues.dat', 'w') as f:
    for eig in vals:
        f.write(str(np.real(eig))+'\n')

with open(resultsPlace+'fullEigenvalues.dat', 'w') as f:
    for eig in vals:
        f.write(str(eig)+'\n')

for index in range(0, numVecs):
    with open(resultsPlace+'densVec'+str(index)+'.dat', 'w') as f:
        for position in range(0, L):
            f.write(str(np.real(avDens[position, index]))+'\n')

#for index in range(0, numVecs):
#    with open(resultsPlace+'fullDensVec'+str(index)+'.dat', 'w') as f:
#        for position in range(0, L+4):
#            f.write(str(avDens[position, index])+' ')

for index in range(0, numVecs):
    with open(resultsPlace+'currVec'+str(index)+'.dat', 'w') as f:
        for position in range(0, L-1):
            f.write(str(np.real(avCurr[position, index]))+'\n')

#for index in range(0, numVecs):
#    with open(resultsPlace+'fullCurrVec'+str(index)+'.dat', 'w') as f:
#        for position in range(0, L+3):
#            f.write(str(avCurr[position, index])+' ')

with open(resultsPlace+'eigenErrs.dat', 'w') as f:
    for err in errs:
        f.write(str(err)+'\n')

entropy = 0.0
for i in range(0, N):
    temp = vecs[i, 0]
    if temp > 0.0:
        entropy += - temp*m.log(2, temp)

with open(resultsPlace+'groundEntropy.dat', 'w') as f:
    f.write(str(np.real(entropy))+'\n')

#solvedSoln = la.lsmr(cscRateMatrix, b)
#print solvedSoln
#print("\nThe mean occupation should be:\n")
#newAvDens = cscDensityMatrix.dot(solvedSoln)
#print newAvDens
#print("\nThe mean current should be:\n")
#newAvCurr = cscCurrentMatrix.dot(solvedSoln)
#print newAvCurr

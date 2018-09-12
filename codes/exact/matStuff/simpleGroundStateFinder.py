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

botConc = float(sys.argv[1])
topConc = float(sys.argv[2])
l = float(sys.argv[3])
L = np.uint32(int(sys.argv[4]))
numVecs = int(sys.argv[5])
boundMult = float(sys.argv[6])
tolerance = float(sys.argv[7])
fileInfo = sys.argv[8]


resultsPlace = resultDir+"/"+fileInfo+"/"

if not os.path.exists(resultsPlace):
    os.makedirs(resultsPlace)

with open(resultsPlace+'settings', 'w') as f:
    f.write('BotConcentration = ' + str(botConc) +'\n')
    f.write('TopConcentration = ' + str(topConc) +'\n')
    f.write('Lambda = ' + str(l) +'\n')
    f.write('SysSize = ' + str(L) +'\n')
    f.write('NumVecs = ' + str(numVecs)+'\n')
    f.write('BoundMult = ' + str(boundMult)+'\n')
    f.write('Tolerance = ' +str(tolerance)+'\n')

N = np.uint32(2**(L+4))

rateMatrix = sp.lil_matrix((N, N), dtype = np.float64)
densityMatrix = sp.lil_matrix((L+4, N), dtype = np.float64)
currentMatrix = sp.lil_matrix((L+3, N), dtype = np.float64)

topIncRate = (1.0+l)*boundMult*m.sqrt(l*topConc/(1.0-topConc))
topOutRate = (1.0+l)*boundMult*m.sqrt(l*(1.0-topConc)/topConc)
botIncRate = (1.0+l)*boundMult*m.sqrt(l*botConc/(1.0-botConc))
botOutRate = (1.0+l)*boundMult*m.sqrt(l*(1.0-botConc)/botConc)


t0 = time.clock()
for i in range(0, N):
    state = format(i, '032b')
    totLeakage = 0.0
    for position in range(32 - 4 - L, 32-2 - L):
        if state[position] == '1':
            newState = state[:position]+'0'+state[(position+1):]
#            print state
#            print newState
            j = np.uint32(int(newState, 2))
#            print format(j, '032b')+"\n"
            rateMatrix[j, i] += botOutRate
            totLeakage += botOutRate
            densityMatrix[position-(32-4-L), i] = 1
        else:
            newState = state[:position]+'1'+state[(position+1):]
#            print state
#            print newState
            j = np.uint32(int(newState, 2))
#            print format(j, '032b')+"\n"
            rateMatrix[j, i] += botIncRate
            totLeakage += botIncRate
    for position in range(32-3 - L , 32-1):
        if state[position] == '1':
            densityMatrix[position-(32-4-L), i] = 1
            if state[position-1] == '0':
                newState = state[:(position-1)]+'1'+'0'+state[(position+1):]
#                print state
#                print newState
                j = np.uint32(int(newState, 2))
#                print format(j, '032b')+"\n"
                if state[position+1] == '0':
                    rateMatrix[j, i] += 1.0
                    currentMatrix[position - (32-3-L), i] -= 1.0
                    totLeakage += 1.0
                else:
                    rateMatrix[j, i] += l
                    currentMatrix[position - (32-3-L), i] -= l
                    totLeakage += l
            if state[position+1] == '0':
                newState = state[:(position)]+'0'+'1'+state[(position+2):]
#                print state
#                print newState
                j = np.uint32(int(newState, 2))
#                print format(j, '032b')+"\n"
                if state[position-1] == '0':
                    rateMatrix[j, i] += 1.0
                    currentMatrix[position + 1 - (32-3-L), i] += 1.0
                    totLeakage += 1.0
                else:
                    rateMatrix[j, i] += l
                    currentMatrix[position + 1 - (32-3-L), i] += l
                    totLeakage += l
    for position in range(32 - 2, 32):
        if state[position] == '1':
            densityMatrix[position-(32-4-L), i] = 1
            newState = state[:position]+'0'+state[(position+1):]
#            print state
#            print newState
            j = np.uint32(int(newState, 2))
#            print format(j, '032b')+"\n"
            rateMatrix[j, i] += topOutRate
            totLeakage += topOutRate
        else:
            newState = state[:position]+'1'+state[(position+1):]
#            print state
#            print newState
            j = np.uint32(int(newState, 2))
#            print format(j, '032b')+"\n"
            rateMatrix[j, i] += topIncRate
            totLeakage += topIncRate
    rateMatrix[i, i] -= totLeakage



#print("RateMatrix created.")

cscRateMatrix = rateMatrix.tocsc()
cscDensityMatrix = densityMatrix.tocsc()
cscCurrentMatrix = currentMatrix.tocsc()

#print("RateMatrix reformatted.")

valsLR, vecsLR = la.eigs(cscRateMatrix, k=numVecs, tol=tolerance, which='LR', maxiter=100*N)

errs = []
for index in range(0, numVecs):
    vecsLR[:, index] = np.sign(vecsLR[N/2, index])*vecsLR[:, index]/(np.linalg.norm(vecsLR[:, index], 1))
    errs.append(2.0*np.linalg.norm(cscRateMatrix.dot(vecsLR[:, index])-valsLR[index]*vecsLR[:, index], 1)/(np.linalg.norm(cscRateMatrix.dot(vecsLR[:, index]), 1)+np.abs(valsLR[index])*np.linalg.norm(vecsLR[:, index], 1)))

t1 = time.clock()

print(str(t1-t0)+"s for computation of this session's eigenpairs.\n")


avDens = cscDensityMatrix.dot(vecsLR)
#print avDens
#print("\nThe mean current should be:\n")
avCurr = cscCurrentMatrix.dot(vecsLR)
#print avCurr


with open(resultsPlace+'eigenvalues.dat', 'w') as f:
    for eig in valsLR:
        f.write(str(np.real(eig))+'\n')

#with open(resultsPlace+'fullEigenvalues.dat', 'w') as f:
#    for eig in vals:
#        f.write(str(eig)+'\n')

with open(resultsPlace+'fullEigenvalues.dat', 'w') as f:
    for eig in valsLR:
        f.write(str(eig)+'\n')
#    for eig in valsSR:
#        f.write(str(eig)+'\n')
#    for eig in valsLI:
#        f.write(str(eig)+'\n')
#    for eig in valsSI:
#        f.write(str(eig)+'\n')




for index in range(0, 1):
    with open(resultsPlace+'densVec'+str(index)+'.dat', 'w') as f:
        for position in range(0, L+4):
            f.write(str(np.real(avDens[position, index]))+'\n')

#for index in range(0, numVecs):
#    with open(resultsPlace+'fullDensVec'+str(index)+'.dat', 'w') as f:
#        for position in range(0, L+4):
#            f.write(str(avDens[position, index])+' ')

for index in range(0, 1):
    with open(resultsPlace+'currVec'+str(index)+'.dat', 'w') as f:
        for position in range(0, L+3):
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
    temp = vecsLR[i, 0]
    if temp > 0.0:
        entropy += - temp*m.log(2, temp)

with open(resultsPlace+'groundEntropy.dat', 'w') as f:
    f.write(str(np.real(entropy))+'\n')



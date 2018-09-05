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
minLambda = float(sys.argv[8])
maxLambda = float(sys.argv[9])
fileInfo = sys.argv[10]


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
    f.write('MinLambda = ' +str(minLambda)+'\n')
    f.write('MaxLambda = ' +str(maxLambda)+'\n')

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
valsSR, vecsSR = la.eigs(cscRateMatrix, k=numVecs, tol=tolerance, which='SR', maxiter=100*N)
valsLI, vecsLI = la.eigs(cscRateMatrix, k=numVecs, tol=tolerance, which='LI', maxiter=100*N)
valsSI, vecsSI = la.eigs(cscRateMatrix, k=numVecs, tol=tolerance, which='SI', maxiter=100*N)
errs = []
for index in range(0, numVecs):
    vecsLR[:, index] = np.sign(vecsLR[N/2, index])*vecsLR[:, index]/(np.linalg.norm(vecsLR[:, index], 1))
    errs.append(2.0*np.linalg.norm(cscRateMatrix.dot(vecsLR[:, index])-valsLR[index]*vecsLR[:, index], 1)/(np.linalg.norm(cscRateMatrix.dot(vecsLR[:, index]), 1)+np.abs(valsLR[index])*np.linalg.norm(vecsLR[:, index], 1)))
    vecsSR[:, index] = np.sign(vecsSR[N/2, index])*vecsSR[:, index]/(np.linalg.norm(vecsSR[:, index], 1))
    errs.append(2.0*np.linalg.norm(cscRateMatrix.dot(vecsSR[:, index])-valsSR[index]*vecsSR[:, index], 1)/(np.linalg.norm(cscRateMatrix.dot(vecsSR[:, index]), 1)+np.abs(valsSR[index])*np.linalg.norm(vecsSR[:, index], 1)))
    vecsLI[:, index] = np.sign(vecsLI[N/2, index])*vecsLI[:, index]/(np.linalg.norm(vecsLI[:, index], 1))
    errs.append(2.0*np.linalg.norm(cscRateMatrix.dot(vecsLI[:, index])-valsLI[index]*vecsLI[:, index], 1)/(np.linalg.norm(cscRateMatrix.dot(vecsLI[:, index]), 1)+np.abs(valsLI[index])*np.linalg.norm(vecsLI[:, index], 1)))
    vecsSI[:, index] = np.sign(vecsSI[N/2, index])*vecsSI[:, index]/(np.linalg.norm(vecsSI[:, index], 1))
    errs.append(2.0*np.linalg.norm(cscRateMatrix.dot(vecsSI[:, index])-valsSI[index]*vecsSI[:, index], 1)/(np.linalg.norm(cscRateMatrix.dot(vecsSI[:, index]), 1)+np.abs(valsSI[index])*np.linalg.norm(vecsSI[:, index], 1)))

t1 = time.clock()

print(str(t1-t0)+"s for computation of this session's eigenpairs.\n")

print("Computing additional eigenvectors.")

t0 = time.clock()

l = minLambda
rateMatrix = sp.lil_matrix((N, N), dtype = np.float64)
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
#            densityMatrix[position-(32-4-L), i] = 1
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
#            densityMatrix[position-(32-4-L), i] = 1
            if state[position-1] == '0':
                newState = state[:(position-1)]+'1'+'0'+state[(position+1):]
#                print state
#                print newState
                j = np.uint32(int(newState, 2))
#                print format(j, '032b')+"\n"
                if state[position+1] == '0':
                    rateMatrix[j, i] += 1.0
#                    currentMatrix[position - (32-3-L), i] -= 1.0
                    totLeakage += 1.0
                else:
                    rateMatrix[j, i] += l
#                    currentMatrix[position - (32-3-L), i] -= l
                    totLeakage += l
            if state[position+1] == '0':
                newState = state[:(position)]+'0'+'1'+state[(position+2):]
#                print state
#                print newState
                j = np.uint32(int(newState, 2))
#                print format(j, '032b')+"\n"
                if state[position-1] == '0':
                    rateMatrix[j, i] += 1.0
#                    currentMatrix[position + 1 - (32-3-L), i] += 1.0
                    totLeakage += 1.0
                else:
                    rateMatrix[j, i] += l
#                    currentMatrix[position + 1 - (32-3-L), i] += l
                    totLeakage += l
    for position in range(32 - 2, 32):
        if state[position] == '1':
#            densityMatrix[position-(32-4-L), i] = 1
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
cscRateMatrix = rateMatrix.tocsc()


vals, vecMinLambda = la.eigs(cscRateMatrix, k=1, tol=1.0*tolerance, sigma=0.0, maxiter=100*N)

rateMatrix = sp.lil_matrix((N, N), dtype = np.float64)
l = maxLambda
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
#            densityMatrix[position-(32-4-L), i] = 1
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
#            densityMatrix[position-(32-4-L), i] = 1
            if state[position-1] == '0':
                newState = state[:(position-1)]+'1'+'0'+state[(position+1):]
#                print state
#                print newState
                j = np.uint32(int(newState, 2))
#                print format(j, '032b')+"\n"
                if state[position+1] == '0':
                    rateMatrix[j, i] += 1.0
#                    currentMatrix[position - (32-3-L), i] -= 1.0
                    totLeakage += 1.0
                else:
                    rateMatrix[j, i] += l
#                    currentMatrix[position - (32-3-L), i] -= l
                    totLeakage += l
            if state[position+1] == '0':
                newState = state[:(position)]+'0'+'1'+state[(position+2):]
#                print state
#                print newState
                j = np.uint32(int(newState, 2))
#                print format(j, '032b')+"\n"
                if state[position-1] == '0':
                    rateMatrix[j, i] += 1.0
#                    currentMatrix[position + 1 - (32-3-L), i] += 1.0
                    totLeakage += 1.0
                else:
                    rateMatrix[j, i] += l
#                    currentMatrix[position + 1 - (32-3-L), i] += l
                    totLeakage += l
    for position in range(32 - 2, 32):
        if state[position] == '1':
#            densityMatrix[position-(32-4-L), i] = 1
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
cscRateMatrix = rateMatrix.tocsc()


vals, vecMaxLambda = la.eigs(cscRateMatrix, k=1, tol=1.0*tolerance, sigma=0.0, maxiter=100*N)


rateMatrix = sp.lil_matrix((N, N), dtype = np.float64)
l = 1.0
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
#            densityMatrix[position-(32-4-L), i] = 1
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
#            densityMatrix[position-(32-4-L), i] = 1
            if state[position-1] == '0':
                newState = state[:(position-1)]+'1'+'0'+state[(position+1):]
#                print state
#                print newState
                j = np.uint32(int(newState, 2))
#                print format(j, '032b')+"\n"
                if state[position+1] == '0':
                    rateMatrix[j, i] += 1.0
#                    currentMatrix[position - (32-3-L), i] -= 1.0
                    totLeakage += 1.0
                else:
                    rateMatrix[j, i] += l
#                    currentMatrix[position - (32-3-L), i] -= l
                    totLeakage += l
            if state[position+1] == '0':
                newState = state[:(position)]+'0'+'1'+state[(position+2):]
#                print state
#                print newState
                j = np.uint32(int(newState, 2))
#                print format(j, '032b')+"\n"
                if state[position-1] == '0':
                    rateMatrix[j, i] += 1.0
#                    currentMatrix[position + 1 - (32-3-L), i] += 1.0
                    totLeakage += 1.0
                else:
                    rateMatrix[j, i] += l
#                    currentMatrix[position + 1 - (32-3-L), i] += l
                    totLeakage += l
    for position in range(32 - 2, 32):
        if state[position] == '1':
#            densityMatrix[position-(32-4-L), i] = 1
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
cscRateMatrix = rateMatrix.tocsc()


vals, vecOneLambda = la.eigs(cscRateMatrix, k=1, tol=1.0*tolerance, sigma=0.0, maxiter=100*N)

t1 = time.clock()
print(str(t1-t0)+"s for computation of the additional eigenvectors.\n")

#print("So final result for the eigenvalues is "+str(vals)+"\n")
#print("|Ax-lambda x| = ")
#for index in range(0, numVecs):
#    print str(np.linalg.norm(cscRateMatrix.dot(vecs[:, index])-vals[index]*vecs[:, index], 1))+" with |x| = "+str(np.linalg.norm(vecs[:, index], 1))

#print("\nThe mean occupation should be:\n")
avDens = cscDensityMatrix.dot(vecsLR)
#print avDens
#print("\nThe mean current should be:\n")
avCurr = cscCurrentMatrix.dot(vecsLR)
#print avCurr


with open(resultsPlace+'eigenvalues.dat', 'w') as f:
    for eig in valsLR:
        f.write(str(np.real(eig))+' ')

#with open(resultsPlace+'fullEigenvalues.dat', 'w') as f:
#    for eig in vals:
#        f.write(str(eig)+' ')

with open(resultsPlace+'fullEigenvalues.dat', 'w') as f:
    for eig in valsLR:
        f.write(str(eig)+'\n')
    for eig in valsSR:
        f.write(str(eig)+'\n')
    for eig in valsLI:
        f.write(str(eig)+'\n')
    for eig in valsSI:
        f.write(str(eig)+'\n')




for index in range(0, 1):
    with open(resultsPlace+'densVec'+str(index)+'.dat', 'w') as f:
        for position in range(0, L+4):
            f.write(str(np.real(avDens[position, index]))+' ')

#for index in range(0, numVecs):
#    with open(resultsPlace+'fullDensVec'+str(index)+'.dat', 'w') as f:
#        for position in range(0, L+4):
#            f.write(str(avDens[position, index])+' ')

for index in range(0, 1):
    with open(resultsPlace+'currVec'+str(index)+'.dat', 'w') as f:
        for position in range(0, L+3):
            f.write(str(np.real(avCurr[position, index]))+' ')

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

with open(resultsPlace+'maxProd.dat', 'w') as f:
    for i in range(0, numVecs):
        f.write(str(abs(np.sign(vecMaxLambda[N/2, 0])*np.vdot(vecMaxLambda[:, 0], vecsLR[:, i])/(np.linalg.norm(vecMaxLambda[:, 0], 2)*np.linalg.norm(vecsLR[:, i], 2))))+'\n')

with open(resultsPlace+'minProd.dat', 'w') as f:
    for i in range(0, numVecs):
        f.write(str(abs(np.sign(vecMinLambda[N/2, 0])*np.vdot(vecMinLambda[:, 0], vecsLR[:, i])/(np.linalg.norm(vecMinLambda[:, 0], 2)*np.linalg.norm(vecsLR[:, i], 2))))+'\n')

with open(resultsPlace+'oneProd.dat', 'w') as f:
    for i in range(0, numVecs):
        f.write(str(abs(np.sign(vecOneLambda[N/2, 0])*np.vdot(vecOneLambda[:, 0], vecsLR[:, i])/(np.linalg.norm(vecOneLambda[:, 0], 2)*np.linalg.norm(vecsLR[:, i], 2))))+'\n')

with open(resultsPlace+'multiProds.dat', 'w') as f:
    for i in range(0, numVecs):
        for j in range(0, numVecs):
            f.write(str(abs(np.vdot(vecsLR[:, j], vecsLR[:, i]))/(np.linalg.norm(vecsLR[:, j], 2)*np.linalg.norm(vecsLR[:, i], 2)))+' ')
        f.write('\n')
    

#solvedSoln = la.lsmr(cscRateMatrix, b)
#print solvedSoln
#print("\nThe mean occupation should be:\n")
#newAvDens = cscDensityMatrix.dot(solvedSoln)
#print newAvDens
#print("\nThe mean current should be:\n")
#newAvCurr = cscCurrentMatrix.dot(solvedSoln)
#print newAvCurr

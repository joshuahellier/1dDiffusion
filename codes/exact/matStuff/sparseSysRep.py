import scipy.sparse as sp
import scipy.sparse.linalg as la
import numpy as np
import bitstring as bs
import math as m
import time

L = np.uint32(8)

N = np.uint32(2**(L+4))

rateMatrix = sp.lil_matrix((N, N), dtype = np.float64)
densityMatrix = sp.lil_matrix((L+4, N), dtype = np.float64)
currentMatrix = sp.lil_matrix((L+3, N), dtype = np.float64)

l = 0.01

topConc = 0.4

botConc = 0.6

boundMult = 100.0

topIncRate = boundMult*m.sqrt(l*topConc/(1.0-topConc))
topOutRate = boundMult*m.sqrt(l*(1.0-topConc)/topConc)
botIncRate = boundMult*m.sqrt(l*botConc/(1.0-botConc))
botOutRate = boundMult*m.sqrt(l*(1.0-botConc)/botConc)


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

print("RateMatrix created.")

cscRateMatrix = rateMatrix.tocsc()
cscDensityMatrix = densityMatrix.tocsc()
cscCurrentMatrix = currentMatrix.tocsc()
#print cscRateMatrix
#print cscDensityMatrix
#csrRateMatrix = rateMatrix.tocsr()

print("RateMatrix reformatted.")

t0 = time.clock()
vals, vecs = la.eigs(cscRateMatrix, k=1, which='SM')
vecs = -vecs/np.linalg.norm(vecs, 1)
t1 = time.clock()
#la.eigs(csrRateMatrix)
#t2 = time.clock()
print(str(t1-t0)+"s for csc eigenvector find\n")

#print("Eigenvalues:")
#for val in vals:
#    print val
#print("\n")

#print("Eigenvectors:")
#for vec in vecs:
#    print vec

print("So final result for eigenvalue is "+str(vals[0])+"\n")
print("|Ax-lambda x| = "+str(np.linalg.norm(cscRateMatrix.dot(vecs)-vals[0]*vecs, 1))+" with |x| = "+str(np.linalg.norm(vecs, 1)))
#for el in vecs:
#    print(el[0])
#v = cscRateMatrix.dot(vecs)
#print(v)
print("\nThe mean occupation should be:\n")
avDens = cscDensityMatrix.dot(vecs)
print avDens
print("\nThe mean current should be:\n")
avCurr = cscCurrentMatrix.dot(vecs)
print avCurr

state = "abcdefgh"
position = 3
print state[position]
newState = state[:position]+'0'+state[(position+1):]
print newState

#solvedSoln = la.lsmr(cscRateMatrix, b)
#print solvedSoln
#print("\nThe mean occupation should be:\n")
#newAvDens = cscDensityMatrix.dot(solvedSoln)
#print newAvDens
#print("\nThe mean current should be:\n")
#newAvCurr = cscCurrentMatrix.dot(solvedSoln)
#print newAvCurr

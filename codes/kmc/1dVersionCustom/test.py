import postProcessorUtilities as pPU
import random
timePoints = []
currentTime = 0.0
timePoints.append(currentTime)
for i in (0, 100):
    timePoints.append(random.uniform(0.0, 1000.0))
timePoints.sort()

print(timePoints)

weights = pPU.weightingsFinder(timePoints, 10.0)
for i in weights:
    total = 0.0
    for j in i[1]:
        total += j[1]
    print(str(total)+"\n")
print("\n")
grandTotal = 0.0
for i in weights:
    print("In "+str(i[0])+"\n")
    total = 0.0
    for j in i[1]:
        print(str(j[0])+" "+str(j[1])+"\n")
        total += j[1]
    grandTotal += total
    print("Total = "+str(total))
print(grandTotal)

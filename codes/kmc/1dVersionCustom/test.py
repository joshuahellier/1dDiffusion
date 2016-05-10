import postProcessorUtilities as pPU
timePoints = [0.0, 0.1, 1.1, 1.2, 1.3, 2.4, 5.2]
weights = pPU.weightingsFinder(timePoints, 1.0)
for i in weights:
    total = 0.0
    for j in i[1]:
        total += j[1]
    print(str(total)+"\n")
print("\n")
for i in weights:
    print("In "+str(i[0])+"\n")
    total = 0.0
    for j in i[1]:
        print(str(j[0])+" "+str(j[1])+"\n")
        total += j[1]
    print("Total = "+str(total))

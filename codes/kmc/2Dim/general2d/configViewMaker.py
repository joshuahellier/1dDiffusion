import sys
import os
import numpy
import math

sysLength = int(sys.argv[1])
sysWidth = int(sys.argv[2])
empth = sys.argv[3]
fileLoc = sys.argv[4]

execfile(fileLoc+"/equilib.traj")

if not os.path.exists(fileLoc+"/snapshots"):
    os.makedirs(fileLoc+"/snapshots")

for shotIndex in range(0, len(types)):
    typeList = types[shotIndex]
    with open(fileLoc+"/snapshots/finalSnapshot"+str(shotIndex)+".dat", 'w') as f:
        for yIndex in range(0, sysLength+4):
            for xIndex in range(0, sysWidth):
                if(typeList[(sysLength+4)*xIndex+yIndex]==empth):
                    f.write(str(xIndex)+" "+str(yIndex)+" 1\n")
                else:
                    f.write(str(xIndex)+" "+str(yIndex)+" 0\n")


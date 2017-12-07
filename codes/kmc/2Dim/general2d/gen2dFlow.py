import sys
import os
import math
import shutil

resultDir = os.environ.get('RESULTS')
if resultDir == None :
    print ("WARNING! $RESULTS not set! Attempt to write results will fail!\n")

# Expecting input botConc, topConc, rateConstFull, sysSize, analInterval, numStepsEquilib, numStepsSnapshot, numStepsAnal, numStepsReq, numPasses, timeInterval,  fileCode

from KMCLib import *
from KMCLib.Backend import Backend
import numpy
from RateCalc import *
from DensHist import *

botConc = float(sys.argv[1])
topConc = float(sys.argv[2])
lambda1 = float(sys.argv[3])
lambda2 = float(sys.argv[4])
lambda3 = float(sys.argv[5])
lambda4 = float(sys.argv[6])
lambda5 = float(sys.argv[7])
sysWidth = int(sys.argv[8])
sysLength = int(sys.argv[9])
analInterval = int(sys.argv[10])
numStepsEquilib = int(sys.argv[11])
numStepsSnapshot = int(sys.argv[12])
numStepsAnal = int(sys.argv[13])
numStepsReq = int(sys.argv[14])
numPasses = int(sys.argv[15])
timeInterval = float(sys.argv[16])
fileInfo = sys.argv[17]

resultsPlace = resultDir+"/"+fileInfo+"/"

if not os.path.exists(resultsPlace):
    os.makedirs(resultsPlace)

with open(resultsPlace+'settings', 'w') as f:
    f.write('BotConcentration = ' + str(botConc) +'\n')
    f.write('TopConcentration = ' + str(topConc) +'\n')
    f.write('Lambda1 = ' + str(lambda1) +'\n')
    f.write('Lambda2 = ' + str(lambda2) +'\n')
    f.write('Lambda3 = ' + str(lambda3) +'\n')
    f.write('Lambda4 = ' + str(lambda4) +'\n')
    f.write('Lambda5 = ' + str(lambda5) +'\n')
    f.write('SysWidth = ' + str(sysWidth) +'\n')
    f.write('SysLength = ' + str(sysLength) +'\n')
    f.write('TimeInterval = ' + str(timeInterval) +'\n')
    f.write('AnalInterval = ' +str(analInterval) + '\n')
    f.write('NumStepsEquilib = '+str(numStepsEquilib) +'\n')
    f.write('NumStepsSnapshot = '+str(numStepsSnapshot)+'\n')
    f.write('NumStepsAnal = '+str(numStepsAnal) +'\n')

"""I've put this in the file to make command line input easier"""
# Load the configuration and interactions.
# We're in 2d
cell_vectors = [[1.0,0.0,0.0],
                [0.0,1.0,0.0],
                [0.0,0.0,1.0]]

# Only bothering with one set
basis_points = [[0.0, 0.0, 0.0]]

unit_cell = KMCUnitCell(cell_vectors=cell_vectors,
                        basis_points=basis_points)

# Define the lattice.
xRep = sysWidth
yRep = sysLength + 4
zRep = 1
numPoints = xRep*zRep*yRep
lattice = KMCLattice(unit_cell=unit_cell,
                     repetitions=(xRep,yRep,zRep),
                     periodic=(True, True, False))

# Generate the initial types. There's double-layered section of "To" at the top and "Bo" at the bottom
avConc = 0.5*(botConc+topConc)

types = []

for yIndex in range(0, 2):
    for xIndex in range(0, xRep):
        random = numpy.random.rand()
        if random < botConc:
            types.append((xIndex, yIndex, 0, 0, "BoO"))
        else:
            types.append((xIndex, yIndex, 0, 0, "BoV"))

for yIndex in range(2, yRep-2):
    for xIndex in range(0, xRep):
        random = numpy.random.rand()
        if random < avConc:
            types.append((xIndex, yIndex, 0, 0, "O"))
        else:
            types.append((xIndex, yIndex, 0, 0, "V"))
for yIndex in range(yRep-2, yRep):
    for xIndex in range(0, xRep):
        random = numpy.random.rand()
        if random < topConc:
            types.append((xIndex, yIndex, 0, 0, "ToO"))
        else:
            types.append((xIndex, yIndex, 0, 0, "ToV"))        

# Setup the configuration.
configuration = KMCConfiguration(lattice=lattice,
                                 types=types,
                                 possible_types=["O","V","ToV","BoV", "ToO", "BoO"], default_type="V")


# Rates.
topSpawn = math.sqrt(topConc/(1.0-topConc))
botSpawn = math.sqrt(botConc/(1.0-botConc))
topDespawn = 1.0/topSpawn
botDespawn = 1.0/botSpawn

#
##
###
"""I've put the processes in here to make it easier to adjust them via command line arguments."""

# Fill the list of processes.
processes = []

# Only on the first set of basis_points for O/V
basis_sites     = [0]

# Bulk processes

# right_______________________________________________________________________________________________
#1
elements_before = ["O", "V", "V", "V", "V"]
elements_after  = ["V", "O", "V", "V", "V"]
coordinates = [[0.0, 0.0,  0.0], [1.0, 0.0, 0.0], [0.0, 1.0, 0.0], [-1.0, 0.0, 0.0], [0.0, -1.0, 0.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=1.0))
#2
elements_before = ["O", "V", "V", "O", "V"]
elements_after  = ["V", "O", "V", "O", "V"]
coordinates = [[0.0, 0.0,  0.0], [1.0, 0.0, 0.0], [0.0, 1.0, 0.0], [-1.0, 0.0, 0.0], [0.0, -1.0, 0.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=lambda1))
#3
elements_before = ["O", "V", "O", "V", "V"]
elements_after  = ["V", "O", "O", "V", "V"]
coordinates = [[0.0, 0.0,  0.0], [1.0, 0.0, 0.0], [0.0, 1.0, 0.0], [-1.0, 0.0, 0.0], [0.0, -1.0, 0.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=lambda2))
#4
elements_before = ["O", "V", "V", "V", "O"]
elements_after  = ["V", "O", "V", "V", "O"]
coordinates = [[0.0, 0.0,  0.0], [1.0, 0.0, 0.0], [0.0, 1.0, 0.0], [-1.0, 0.0, 0.0], [0.0, -1.0, 0.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=lambda2))
#5
elements_before = ["O", "V", "O", "V", "O"]
elements_after  = ["V", "O", "O", "V", "O"]
coordinates = [[0.0, 0.0,  0.0], [1.0, 0.0, 0.0], [0.0, 1.0, 0.0], [-1.0, 0.0, 0.0], [0.0, -1.0, 0.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=lambda3))
#6
elements_before = ["O", "V", "O", "O", "V"]
elements_after  = ["V", "O", "O", "O", "V"]
coordinates = [[0.0, 0.0,  0.0], [1.0, 0.0, 0.0], [0.0, 1.0, 0.0], [-1.0, 0.0, 0.0], [0.0, -1.0, 0.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=lambda4))
#7
elements_before = ["O", "V", "V", "O", "O"]
elements_after  = ["V", "O", "V", "O", "O"]
coordinates = [[0.0, 0.0,  0.0], [1.0, 0.0, 0.0], [0.0, 1.0, 0.0], [-1.0, 0.0, 0.0], [0.0, -1.0, 0.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=lambda4))
#8
elements_before = ["O", "V", "O", "O", "O"]
elements_after  = ["V", "O", "O", "O", "O"]
coordinates = [[0.0, 0.0,  0.0], [1.0, 0.0, 0.0], [0.0, 1.0, 0.0], [-1.0, 0.0, 0.0], [0.0, -1.0, 0.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=lambda5))



# up__________________________________________________________________________________________________
#9
elements_before = ["O", "V", "V", "V", "V"]
elements_after  = ["V", "O", "V", "V", "V"]
coordinates = [[0.0, 0.0,  0.0], [0.0, 1.0, 0.0], [-1.0, 0.0, 0.0], [0.0, -1.0, 0.0], [1.0, 0.0, 0.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=1.0))
#10
elements_before = ["O", "V", "V", "O", "V"]
elements_after  = ["V", "O", "V", "O", "V"]
coordinates = [[0.0, 0.0,  0.0], [0.0, 1.0, 0.0], [-1.0, 0.0, 0.0], [0.0, -1.0, 0.0], [1.0, 0.0, 0.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=lambda1))
#11
elements_before = ["O", "V", "O", "V", "V"]
elements_after  = ["V", "O", "O", "V", "V"]
coordinates = [[0.0, 0.0,  0.0], [0.0, 1.0, 0.0], [-1.0, 0.0, 0.0], [0.0, -1.0, 0.0], [1.0, 0.0, 0.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=lambda2))
#12
elements_before = ["O", "V", "V", "V", "O"]
elements_after  = ["V", "O", "V", "V", "O"]
coordinates = [[0.0, 0.0,  0.0], [0.0, 1.0, 0.0], [-1.0, 0.0, 0.0], [0.0, -1.0, 0.0], [1.0, 0.0, 0.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=lambda2))
#13
elements_before = ["O", "V", "O", "V", "O"]
elements_after  = ["V", "O", "O", "V", "O"]
coordinates = [[0.0, 0.0,  0.0], [0.0, 1.0, 0.0], [-1.0, 0.0, 0.0], [0.0, -1.0, 0.0], [1.0, 0.0, 0.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=lambda3))
#14
elements_before = ["O", "V", "O", "O", "V"]
elements_after  = ["V", "O", "O", "O", "V"]
coordinates = [[0.0, 0.0,  0.0], [0.0, 1.0, 0.0], [-1.0, 0.0, 0.0], [0.0, -1.0, 0.0], [1.0, 0.0, 0.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=lambda4))
#15
elements_before = ["O", "V", "V", "O", "O"]
elements_after  = ["V", "O", "V", "O", "O"]
coordinates = [[0.0, 0.0,  0.0], [0.0, 1.0, 0.0], [-1.0, 0.0, 0.0], [0.0, -1.0, 0.0], [1.0, 0.0, 0.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=lambda4))
#16
elements_before = ["O", "V", "O", "O", "O"]
elements_after  = ["V", "O", "O", "O", "O"]
coordinates = [[0.0, 0.0,  0.0], [0.0, 1.0, 0.0], [-1.0, 0.0, 0.0], [0.0, -1.0, 0.0], [1.0, 0.0, 0.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=lambda5))




# left________________________________________________________________________________________________
#17
elements_before = ["O", "V", "V", "V", "V"]
elements_after  = ["V", "O", "V", "V", "V"]
coordinates = [[0.0, 0.0,  0.0], [-1.0, 0.0, 0.0], [0.0, -1.0, 0.0], [1.0, 0.0, 0.0], [0.0, 1.0, 0.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=1.0))
#18
elements_before = ["O", "V", "V", "O", "V"]
elements_after  = ["V", "O", "V", "O", "V"]
coordinates = [[0.0, 0.0,  0.0], [-1.0, 0.0, 0.0], [0.0, -1.0, 0.0], [1.0, 0.0, 0.0], [0.0, 1.0, 0.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=lambda1))
#19
elements_before = ["O", "V", "O", "V", "V"]
elements_after  = ["V", "O", "O", "V", "V"]
coordinates = [[0.0, 0.0,  0.0], [-1.0, 0.0, 0.0], [0.0, -1.0, 0.0], [1.0, 0.0, 0.0], [0.0, 1.0, 0.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=lambda2))
#20
elements_before = ["O", "V", "V", "V", "O"]
elements_after  = ["V", "O", "V", "V", "O"]
coordinates = [[0.0, 0.0,  0.0], [-1.0, 0.0, 0.0], [0.0, -1.0, 0.0], [1.0, 0.0, 0.0], [0.0, 1.0, 0.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=lambda2))
#21
elements_before = ["O", "V", "O", "V", "O"]
elements_after  = ["V", "O", "O", "V", "O"]
coordinates = [[0.0, 0.0,  0.0], [-1.0, 0.0, 0.0], [0.0, -1.0, 0.0], [1.0, 0.0, 0.0], [0.0, 1.0, 0.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=lambda3))
#22
elements_before = ["O", "V", "O", "O", "V"]
elements_after  = ["V", "O", "O", "O", "V"]
coordinates = [[0.0, 0.0,  0.0], [-1.0, 0.0, 0.0], [0.0, -1.0, 0.0], [1.0, 0.0, 0.0], [0.0, 1.0, 0.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=lambda4))
#23
elements_before = ["O", "V", "V", "O", "O"]
elements_after  = ["V", "O", "V", "O", "O"]
coordinates = [[0.0, 0.0,  0.0], [-1.0, 0.0, 0.0], [0.0, -1.0, 0.0], [1.0, 0.0, 0.0], [0.0, 1.0, 0.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=lambda4))
#24
elements_before = ["O", "V", "O", "O", "O"]
elements_after  = ["V", "O", "O", "O", "O"]
coordinates = [[0.0, 0.0,  0.0], [-1.0, 0.0, 0.0], [0.0, -1.0, 0.0], [1.0, 0.0, 0.0], [0.0, 1.0, 0.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=lambda5))


# down________________________________________________________________________________________________
#25
elements_before = ["O", "V", "V", "V", "V"]
elements_after  = ["V", "O", "V", "V", "V"]
coordinates = [[0.0, 0.0,  0.0], [0.0, -1.0, 0.0], [1.0, 0.0, 0.0], [0.0, 1.0, 0.0], [-1.0, 0.0, 0.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=1.0))
#26
elements_before = ["O", "V", "V", "O", "V"]
elements_after  = ["V", "O", "V", "O", "V"]
coordinates = [[0.0, 0.0,  0.0], [0.0, -1.0, 0.0], [1.0, 0.0, 0.0], [0.0, 1.0, 0.0], [-1.0, 0.0, 0.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=lambda1))
#27
elements_before = ["O", "V", "O", "V", "V"]
elements_after  = ["V", "O", "O", "V", "V"]
coordinates = [[0.0, 0.0,  0.0], [0.0, -1.0, 0.0], [1.0, 0.0, 0.0], [0.0, 1.0, 0.0], [-1.0, 0.0, 0.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=lambda2))
#28
elements_before = ["O", "V", "V", "V", "O"]
elements_after  = ["V", "O", "V", "V", "O"]
coordinates = [[0.0, 0.0,  0.0], [0.0, -1.0, 0.0], [1.0, 0.0, 0.0], [0.0, 1.0, 0.0], [-1.0, 0.0, 0.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=lambda2))
#29
elements_before = ["O", "V", "O", "V", "O"]
elements_after  = ["V", "O", "O", "V", "O"]
coordinates = [[0.0, 0.0,  0.0], [0.0, -1.0, 0.0], [1.0, 0.0, 0.0], [0.0, 1.0, 0.0], [-1.0, 0.0, 0.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=lambda3))
#30
elements_before = ["O", "V", "O", "O", "V"]
elements_after  = ["V", "O", "O", "O", "V"]
coordinates = [[0.0, 0.0,  0.0], [0.0, -1.0, 0.0], [1.0, 0.0, 0.0], [0.0, 1.0, 0.0], [-1.0, 0.0, 0.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=lambda4))
#31
elements_before = ["O", "V", "V", "O", "O"]
elements_after  = ["V", "O", "V", "O", "O"]
coordinates = [[0.0, 0.0,  0.0], [0.0, -1.0, 0.0], [1.0, 0.0, 0.0], [0.0, 1.0, 0.0], [-1.0, 0.0, 0.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=lambda4))
#32
elements_before = ["O", "V", "O", "O", "O"]
elements_after  = ["V", "O", "O", "O", "O"]
coordinates = [[0.0, 0.0,  0.0], [0.0, -1.0, 0.0], [1.0, 0.0, 0.0], [0.0, 1.0, 0.0], [-1.0, 0.0, 0.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=lambda5))

#_____________________________________________________________________________________________________



# Oxygen annihilation at the top boundary
#_____________________________________________________________________________________________________
#33
elements_before = ["O", "ToV", "V", "V", "V"]
elements_after  = ["V", "ToV", "V", "V", "V"]
coordinates = [[0.0, 0.0,  0.0], [0.0, 1.0, 0.0], [-1.0, 0.0, 0.0], [0.0, -1.0, 0.0], [1.0, 0.0, 0.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=1.0))
#34
elements_before = ["O", "ToV", "V", "O", "V"]
elements_after  = ["V", "ToV", "V", "O", "V"]
coordinates = [[0.0, 0.0,  0.0], [0.0, 1.0, 0.0], [-1.0, 0.0, 0.0], [0.0, -1.0, 0.0], [1.0, 0.0, 0.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=lambda1))
#35
elements_before = ["O", "ToV", "O", "V", "V"]
elements_after  = ["V", "ToV", "O", "V", "V"]
coordinates = [[0.0, 0.0,  0.0], [0.0, 1.0, 0.0], [-1.0, 0.0, 0.0], [0.0, -1.0, 0.0], [1.0, 0.0, 0.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=lambda2))
#36
elements_before = ["O", "ToV", "V", "V", "O"]
elements_after  = ["V", "ToV", "V", "V", "O"]
coordinates = [[0.0, 0.0,  0.0], [0.0, 1.0, 0.0], [-1.0, 0.0, 0.0], [0.0, -1.0, 0.0], [1.0, 0.0, 0.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=lambda2))
#37
elements_before = ["O", "ToV", "O", "V", "O"]
elements_after  = ["V", "ToV", "O", "V", "O"]
coordinates = [[0.0, 0.0,  0.0], [0.0, 1.0, 0.0], [-1.0, 0.0, 0.0], [0.0, -1.0, 0.0], [1.0, 0.0, 0.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=lambda3))
#38
elements_before = ["O", "ToV", "O", "O", "V"]
elements_after  = ["V", "ToV", "O", "O", "V"]
coordinates = [[0.0, 0.0,  0.0], [0.0, 1.0, 0.0], [-1.0, 0.0, 0.0], [0.0, -1.0, 0.0], [1.0, 0.0, 0.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=lambda4))
#39
elements_before = ["O", "ToV", "V", "O", "O"]
elements_after  = ["V", "ToV", "V", "O", "O"]
coordinates = [[0.0, 0.0,  0.0], [0.0, 1.0, 0.0], [-1.0, 0.0, 0.0], [0.0, -1.0, 0.0], [1.0, 0.0, 0.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=lambda4))
#40
elements_before = ["O", "ToV", "O", "O", "O"]
elements_after  = ["V", "ToV", "O", "O", "O"]
coordinates = [[0.0, 0.0,  0.0], [0.0, 1.0, 0.0], [-1.0, 0.0, 0.0], [0.0, -1.0, 0.0], [1.0, 0.0, 0.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=lambda5))


#Oxygen creation at the top boundary
#_____________________________________________________________________________________________________
#41

elements_before = ["ToO", "V", "ToV", "ToV", "ToV"]
elements_after  = ["ToO", "O", "ToV", "ToV", "ToV"]
coordinates = [[0.0, 0.0,  0.0], [0.0, -1.0, 0.0], [1.0, 0.0, 0.0], [0.0, 1.0, 0.0], [-1.0, 0.0, 0.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=1.0))
#42
elements_before = ["ToO", "V", "ToV", "ToO", "ToV"]
elements_after  = ["ToO", "O", "ToV", "ToO", "ToV"]
coordinates = [[0.0, 0.0,  0.0], [0.0, -1.0, 0.0], [1.0, 0.0, 0.0], [0.0, 1.0, 0.0], [-1.0, 0.0, 0.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=lambda1))
#43
elements_before = ["ToO", "V", "ToO", "ToV", "ToV"]
elements_after  = ["ToO", "O", "ToO", "ToV", "ToV"]
coordinates = [[0.0, 0.0,  0.0], [0.0, -1.0, 0.0], [1.0, 0.0, 0.0], [0.0, 1.0, 0.0], [-1.0, 0.0, 0.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=lambda2))
#44
elements_before = ["ToO", "V", "ToV", "ToV", "ToO"]
elements_after  = ["ToO", "O", "ToV", "ToV", "ToO"]
coordinates = [[0.0, 0.0,  0.0], [0.0, -1.0, 0.0], [1.0, 0.0, 0.0], [0.0, 1.0, 0.0], [-1.0, 0.0, 0.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=lambda2))
#45
elements_before = ["ToO", "V", "ToO", "ToV", "ToO"]
elements_after  = ["ToO", "O", "ToO", "ToV", "ToO"]
coordinates = [[0.0, 0.0,  0.0], [0.0, -1.0, 0.0], [1.0, 0.0, 0.0], [0.0, 1.0, 0.0], [-1.0, 0.0, 0.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=lambda3))
#46
elements_before = ["ToO", "V", "ToO", "ToO", "ToV"]
elements_after  = ["ToO", "O", "ToO", "ToO", "ToV"]
coordinates = [[0.0, 0.0,  0.0], [0.0, -1.0, 0.0], [1.0, 0.0, 0.0], [0.0, 1.0, 0.0], [-1.0, 0.0, 0.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=lambda4))
#47
elements_before = ["ToO", "V", "ToV", "ToO", "ToO"]
elements_after  = ["ToO", "O", "ToV", "ToO", "ToO"]
coordinates = [[0.0, 0.0,  0.0], [0.0, -1.0, 0.0], [1.0, 0.0, 0.0], [0.0, 1.0, 0.0], [-1.0, 0.0, 0.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=lambda4))
#48
elements_before = ["ToO", "V", "ToO", "ToO", "ToO"]
elements_after  = ["ToO", "O", "ToO", "ToO", "ToO"]
coordinates = [[0.0, 0.0,  0.0], [0.0, -1.0, 0.0], [1.0, 0.0, 0.0], [0.0, 1.0, 0.0], [-1.0, 0.0, 0.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=lambda5))

# Oxygen annihilation at the bottom boundary
#_____________________________________________________________________________________________________
#49
elements_before = ["O", "ToV", "V", "V", "V"]
elements_after  = ["V", "ToV", "V", "V", "V"]
coordinates = [[0.0, 0.0,  0.0], [0.0, -1.0, 0.0], [1.0, 0.0, 0.0], [0.0, 1.0, 0.0], [-1.0, 0.0, 0.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=1.0))
#50
elements_before = ["O", "ToV", "V", "O", "V"]
elements_after  = ["V", "ToV", "V", "O", "V"]
coordinates = [[0.0, 0.0,  0.0], [0.0, -1.0, 0.0], [1.0, 0.0, 0.0], [0.0, 1.0, 0.0], [-1.0, 0.0, 0.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=lambda1))
#51
elements_before = ["O", "ToV", "O", "V", "V"]
elements_after  = ["V", "ToV", "O", "V", "V"]
coordinates = [[0.0, 0.0,  0.0], [0.0, -1.0, 0.0], [1.0, 0.0, 0.0], [0.0, 1.0, 0.0], [-1.0, 0.0, 0.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=lambda2))

#52
elements_before = ["O", "ToV", "V", "V", "O"]
elements_after  = ["V", "ToV", "V", "V", "O"]
coordinates = [[0.0, 0.0,  0.0], [0.0, -1.0, 0.0], [1.0, 0.0, 0.0], [0.0, 1.0, 0.0], [-1.0, 0.0, 0.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=lambda2))
#53
elements_before = ["O", "ToV", "O", "V", "O"]
elements_after  = ["V", "ToV", "O", "V", "O"]
coordinates = [[0.0, 0.0,  0.0], [0.0, -1.0, 0.0], [1.0, 0.0, 0.0], [0.0, 1.0, 0.0], [-1.0, 0.0, 0.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=lambda3))
#54
elements_before = ["O", "ToV", "O", "O", "V"]
elements_after  = ["V", "ToV", "O", "O", "V"]
coordinates = [[0.0, 0.0,  0.0], [0.0, -1.0, 0.0], [1.0, 0.0, 0.0], [0.0, 1.0, 0.0], [-1.0, 0.0, 0.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=lambda4))
#55
elements_before = ["O", "ToV", "V", "O", "O"]
elements_after  = ["V", "ToV", "V", "O", "O"]
coordinates = [[0.0, 0.0,  0.0], [0.0, -1.0, 0.0], [1.0, 0.0, 0.0], [0.0, 1.0, 0.0], [-1.0, 0.0, 0.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=lambda4))
#56
elements_before = ["O", "ToV", "O", "O", "O"]
elements_after  = ["V", "ToV", "O", "O", "O"]
coordinates = [[0.0, 0.0,  0.0], [0.0, -1.0, 0.0], [1.0, 0.0, 0.0], [0.0, 1.0, 0.0], [-1.0, 0.0, 0.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=lambda5))
#_____________________________________________________________________________________________________

#Oxygen creation at the bottom boundary
#_____________________________________________________________________________________________________

#57
elements_before = ["ToO", "V", "ToV", "ToV", "ToV"]
elements_after  = ["ToO", "O", "ToV", "ToV", "ToV"]
coordinates = [[0.0, 0.0,  0.0], [0.0, 1.0, 0.0], [-1.0, 0.0, 0.0], [0.0, -1.0, 0.0], [1.0, 0.0, 0.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=1.0))
#58
elements_before = ["ToO", "V", "ToV", "ToO", "ToV"]
elements_after  = ["ToO", "O", "ToV", "ToO", "ToV"]
coordinates = [[0.0, 0.0,  0.0], [0.0, 1.0, 0.0], [-1.0, 0.0, 0.0], [0.0, -1.0, 0.0], [1.0, 0.0, 0.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=lambda1))
#59
elements_before = ["ToO", "V", "ToO", "ToV", "ToV"]
elements_after  = ["ToO", "O", "ToO", "ToV", "ToV"]
coordinates = [[0.0, 0.0,  0.0], [0.0, 1.0, 0.0], [-1.0, 0.0, 0.0], [0.0, -1.0, 0.0], [1.0, 0.0, 0.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=lambda2))
#60
elements_before = ["ToO", "V", "ToV", "ToV", "ToO"]
elements_after  = ["ToO", "O", "ToV", "ToV", "ToO"]
coordinates = [[0.0, 0.0,  0.0], [0.0, 1.0, 0.0], [-1.0, 0.0, 0.0], [0.0, -1.0, 0.0], [1.0, 0.0, 0.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=lambda2))
#61
elements_before = ["ToO", "V", "ToO", "ToV", "ToO"]
elements_after  = ["ToO", "O", "ToO", "ToV", "ToO"]
coordinates = [[0.0, 0.0,  0.0], [0.0, 1.0, 0.0], [-1.0, 0.0, 0.0], [0.0, -1.0, 0.0], [1.0, 0.0, 0.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=lambda3))
#62
elements_before = ["ToO", "V", "ToO", "ToO", "ToV"]
elements_after  = ["ToO", "O", "ToO", "ToO", "ToV"]
coordinates = [[0.0, 0.0,  0.0], [0.0, 1.0, 0.0], [-1.0, 0.0, 0.0], [0.0, -1.0, 0.0], [1.0, 0.0, 0.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=lambda4))
#63
elements_before = ["ToO", "V", "ToV", "ToO", "ToO"]
elements_after  = ["ToO", "O", "ToV", "ToO", "ToO"]
coordinates = [[0.0, 0.0,  0.0], [0.0, 1.0, 0.0], [-1.0, 0.0, 0.0], [0.0, -1.0, 0.0], [1.0, 0.0, 0.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=lambda4))
#64
elements_before = ["ToO", "V", "ToO", "ToO", "ToO"]
elements_after  = ["ToO", "O", "ToO", "ToO", "ToO"]
coordinates = [[0.0, 0.0,  0.0], [0.0, 1.0, 0.0], [-1.0, 0.0, 0.0], [0.0, -1.0, 0.0], [1.0, 0.0, 0.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=lambda5))

#_____________________________________________________________________________________________________

# Boundary Oxygen creation at the bottom boundary
#65
elements_before = ["BoV"]
elements_after  = ["BoO"]
coordinates = [[0.0, 0.0, 0.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=botSpawn))

# Boundary Oxygen annihilation at the bottom boundary
#66
elements_before = ["BoO"]
elements_after  = ["BoV"]
coordinates = [[0.0, 0.0, 0.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=botDespawn))

# Boundary Oxygen creation at the top boundary
#67
elements_before = ["ToV"]
elements_after  = ["ToO"]
coordinates = [[0.0, 0.0, 0.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=topSpawn))

# Boundary Oxygen annihilation at the bottom boundary
#68
elements_before = ["ToO"]
elements_after  = ["ToV"]
coordinates = [[0.0, 0.0, 0.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=topDespawn))


# Create the interactions object.
interactions = KMCInteractions(processes, implicit_wildcards=True)

"""End of processes"""
###
##
#

# Create the model.
model = KMCLatticeModel(configuration, interactions)

compositionTracker = Composition(time_interval=timeInterval)

# Define the parameters; not entirely sure if these are sensible or not...
control_parameters_equilib = KMCControlParameters(number_of_steps=numStepsEquilib, analysis_interval=numStepsEquilib/100,
                                          dump_interval=numStepsEquilib/10)

control_parameters_req = KMCControlParameters(number_of_steps=numStepsReq, analysis_interval=numStepsReq/100,
                                          dump_interval=numStepsReq/10)

control_parameters_anal = KMCControlParameters(number_of_steps=numStepsAnal, analysis_interval=1,
                                          dump_interval=numStepsAnal/10)

# Run the simulation - save trajectory to resultsPlace, which should by now exist

model.run(control_parameters_equilib, trajectory_filename=(resultsPlace+"equilib.traj"))


with open(resultsPlace+"inBot.dat", 'w') as f:
    pass
with open(resultsPlace+"outBot.dat", 'w') as f:
    pass
with open(resultsPlace+"inTop.dat", 'w') as f:
    pass
with open(resultsPlace+"outTop.dat", 'w') as f:
    pass


if not os.path.exists(resultsPlace+"numHists"):
    os.makedirs(resultsPlace+"numHists")


ovNumHist = []
for index in range(0, numPoints):
    ovNumHist.append(0.0)



for passNum in range(0, numPasses):
    processStatsOxInBot = RateCalc(processes=[7])
    processStatsOxOutBot = RateCalc(processes=[6])
    processStatsOxInTop = RateCalc(processes=[5])
    processStatsOxOutTop = RateCalc(processes=[4])
    numHist = DensHist(spec=["O"], inProc=[7, 5], outProc=[6, 4])
    model.run(control_parameters_req, trajectory_filename=("/dev/null"))
    model.run(control_parameters_anal, trajectory_filename=("/dev/null"), analysis=[processStatsOxInBot, processStatsOxOutBot, processStatsOxInTop, processStatsOxOutTop, numHist])

    with open(resultsPlace+"inBot.dat", 'a') as f:
        processStatsOxInBot.printResults(f)
    with open(resultsPlace+"outBot.dat", 'a') as f:
        processStatsOxOutBot.printResults(f)
    with open(resultsPlace+"inTop.dat", 'a') as f:
        processStatsOxInTop.printResults(f)
    with open(resultsPlace+"outTop.dat", 'a') as f:
        processStatsOxOutTop.printResults(f)
    with open(resultsPlace+"numHists/numHist"+str(passNum)+".dat", 'w') as f:
        pass
    with open(resultsPlace+"numHists/numHist"+str(passNum)+".dat", 'a') as f:
        numHist.printResults(f)
    with open(resultsPlace+"numHists/numHist"+str(passNum)+".dat", 'r') as f:
        lines = f.readlines()
        for index in range(0, numPoints):
            words = lines[index].split()
            ovNumHist[index] += float(words[1])
    os.remove(resultsPlace+"numHists/numHist"+str(passNum)+".dat")

with open(resultsPlace+"ovNumHist.dat", 'w') as f:
    for index in range(0, numPoints):
        f.write(str(index)+" "+str(ovNumHist[index])+"\n")

shutil.rmtree(resultsPlace+"numHists", ignore_errors=True)


print("Process would appear to have succesfully terminated! How very suspicious...")

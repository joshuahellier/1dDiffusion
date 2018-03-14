import sys
import os
import math
import shutil
from random import randint

resultDir = os.environ.get('RESULTS')
if resultDir == None :
    print ("WARNING! $RESULTS not set! Attempt to write results will fail!\n")

# Expecting input

from KMCLib import *
from KMCLib.Backend import Backend
import numpy
#from RateCalc import *
from DensHist import *
from energyStats2d import *

ovConc = float(sys.argv[1])
rateConstFull = float(sys.argv[2])
sysWidth = int(sys.argv[3])
sysLength = int(sys.argv[4])
analInterval = int(sys.argv[5])
numStepsEquilib = int(sys.argv[6])
numStepsAnal = int(sys.argv[7])
numStepsReq = int(sys.argv[8])
numPasses = int(sys.argv[9])
fileInfo = sys.argv[10]

resultsPlace = resultDir+"/"+fileInfo+"/"

if not os.path.exists(resultsPlace):
    os.makedirs(resultsPlace)

with open(resultsPlace+'settings', 'w') as f:
    f.write('OverallConcentration = ' + str(ovConc) +'\n')
    f.write('FullRate = ' + str(rateConstFull) +'\n')
    f.write('SysWidth = ' + str(sysWidth) +'\n')
    f.write('SysLength = ' + str(sysLength) +'\n')
    f.write('AnalInterval = ' +str(analInterval) + '\n')
    f.write('NumStepsEquilib = '+str(numStepsEquilib) +'\n')
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
yRep = sysLength
zRep = 1
numPoints = xRep*zRep*yRep
lattice = KMCLattice(unit_cell=unit_cell,
                     repetitions=(xRep,yRep,zRep),
                     periodic=(True, True, False))

# Generate the initial types

types = []

types = ["V"]*numPoints   

numParticles = int(numPoints*ovConc)
i=0
firstPass = True
while firstPass or ( i <= numParticles and i < numPoints-1 ):
    firstPass = False
    typePos = randint(0, numPoints-1)
    if types[typePos] == "V":
        types[typePos] = "O"
        i += 1

# Setup the configuration.
configuration = KMCConfiguration(lattice=lattice,
                                 types=types,
                                 possible_types=["O","V"])


# Rates.
rateConstEmpty        	= 1.0

#
##
###
"""I've put the processes in here to make it easier to adjust them via command line arguments."""

# Fill the list of processes.
processes = []

# Only on the first set of basis_points for O/V
basis_sites     = [0]

# Bulk processes

# Up
#0
elements_before = ["O", "V"]
elements_after  = ["V", "O"]
coordinates = [[0.0, 0.0,  0.0], [0.0, 1.0, 0.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=1.0))
# Will customise

# Down
#1
elements_before = ["O", "V"]
elements_after  = ["V", "O"]
coordinates = [[0.0, 0.0, 0.0], [0.0, -1.0, 0.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=1.0))
# Will customise

# Left
#2
elements_before = ["O", "V"]
elements_after  = ["V", "O"]
coordinates = [[0.0, 0.0,  0.0], [-1.0, 0.0, 0.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=1.0))
# Will customise

# Right
#3
elements_before = ["O", "V"]
elements_after  = ["V", "O"]
coordinates = [[0.0, 0.0, 0.0], [1.0, 0.0, 0.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=1.0))
# Will customise


# Create the interactions object.
interactions = KMCInteractions(processes, implicit_wildcards=True)


# Define the custom rates calculator, using the lol model as a template
class modelRates2d(KMCRateCalculatorPlugin):
    # Class for defining the custom rates function for the KMCLib paper. 
    def rate(self, geometry, elements_before, elements_after, rate_constant, process_number, global_coordinate):
        numNeighbours = len([e for e in elements_before if e == "O"])
        
        return math.pow(rateConstFull, numNeighbours-1)



    def cutoff(self):
        # Overloaded base class API function 
        return 1.0

interactions.setRateCalculator(rate_calculator=modelRates2d)
"""End of processes"""
###
##
#

# Create the model.
model = KMCLatticeModel(configuration, interactions)


# Define the parameters; not entirely sure if these are sensible or not...
control_parameters_equilib = KMCControlParameters(number_of_steps=numStepsEquilib, analysis_interval=numStepsEquilib/100,
                                          dump_interval=numStepsEquilib/10)

control_parameters_req = KMCControlParameters(number_of_steps=numStepsReq, analysis_interval=numStepsReq/100,
                                          dump_interval=numStepsReq/10)

control_parameters_anal = KMCControlParameters(number_of_steps=numStepsAnal, analysis_interval=1,
                                          dump_interval=numStepsAnal/10)

# Run the simulation - save trajectory to resultsPlace, which should by now exist

model.run(control_parameters_equilib, trajectory_filename=(resultsPlace+"equilib.traj"))



if not os.path.exists(resultsPlace+"enHists"):
    os.makedirs(resultsPlace+"enHists")


ovEnHist = []
for index in range(0, 2*numPoints):
    ovEnHist.append(0.0)



for passNum in range(0, numPasses):
    enHist = energyStats2d(spec=["O"])
    model.run(control_parameters_req, trajectory_filename=("/dev/null"))
    model.run(control_parameters_anal, trajectory_filename=("/dev/null"), analysis=[enHist])
    with open(resultsPlace+"enHists/enHist"+str(passNum)+".dat", 'w') as f:
        pass
    with open(resultsPlace+"enHists/enHist"+str(passNum)+".dat", 'a') as f:
        enHist.printResults(f)
    with open(resultsPlace+"enHists/enHist"+str(passNum)+".dat", 'r') as f:
        lines = f.readlines()
        for index in range(0, 2*numPoints):
            words = lines[index].split()
            ovEnHist[index] += float(words[1])
    os.remove(resultsPlace+"enHists/enHist"+str(passNum)+".dat")

with open(resultsPlace+"ovEnHist.dat", 'w') as f:
    for index in range(0, 2*numPoints):
        f.write(str(index)+" "+str(ovEnHist[index]/float(numPasses))+"\n")

shutil.rmtree(resultsPlace+"enHists", ignore_errors=True)


print("Process would appear to have succesfully terminated! How very suspicious...")

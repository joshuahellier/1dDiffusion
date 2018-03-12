import sys
import os
import math

resultDir = os.environ.get('RESULTS')
if resultDir == None :
    print ("WARNING! $RESULTS not set! Attempt to write results will fail!\n")

# Expecting path from $RESULTS to directory having been made by steadyStateFlow.py then number of steps to image for, then image time parameter, then location for the files to be written to

from KMCLib import *
from KMCLib.Backend import Backend
import numpy
from ImageStats import *

botConc = float(sys.argv[1])

topConc = float(sys.argv[2])

rateConstFull = float(sys.argv[3])

sysSize = int(sys.argv[4])

numImageSteps = int(sys.argv[5])

numStepsEquilib = int(sys.argv[6])

timeInterval = float(sys.argv[7])

resultsPlace = resultDir+"/"+sys.argv[8]+"/"

if not os.path.exists(resultsPlace):
    os.makedirs(resultsPlace)

with open(resultsPlace+'settings', 'w') as f:
    f.write('BotConcentration = ' + str(botConc) +'\n')
    f.write('TopConcentration = ' + str(topConc) +'\n')
    f.write('FullRate = ' + str(rateConstFull) +'\n')
    f.write('SysSize = ' + str(sysSize) +'\n')
    f.write('TimeInterval = ' + str(timeInterval) +'\n')
    f.write('NumImageSteps = ' +str(numImageSteps) + '\n')




"""I've put this in the file to make command line input easier"""
# Load the configuration and interactions.
# We're in 1d, so everything's a bit trivial
cell_vectors = [[1.0,0.0,0.0],
                [0.0,1.0,0.0],
                [0.0,0.0,1.0]]

# Only bothering with one set
basis_points = [[0.0, 0.0, 0.0]]

unit_cell = KMCUnitCell(cell_vectors=cell_vectors,
                        basis_points=basis_points)

# Define the lattice.
xRep = 1
yRep = 1
zRep = sysSize
numPoints = xRep*(zRep+4)*yRep
lattice = KMCLattice(unit_cell=unit_cell,
                     repetitions=(xRep,yRep,zRep+4),
                     periodic=(False, False, True))

avConc = 0.5*(botConc+topConc)
types = ["V"]*numPoints
types[0] = "BoV"
types[1] = "BoV"
types[-2] = "ToV"
types[-1] = "ToV"
for i in range(int(zRep*avConc)):
    # find a site which is not yet occupied by a "O" type.
    pos = int(numpy.random.rand()*zRep+2.0)
    while (types[pos] != "V"):
        pos = int(numpy.random.rand()*zRep+2.0)
    # Set the type.
    types[pos] = "O"

# Setup the configuration.
configuration = KMCConfiguration(lattice=lattice,
                                 types=types,
                                 possible_types=["O","V","ToV","BoV", "ToO", "BoO"])


# Rates.
rateConstEmpty        	= 1.0
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

# Up, empty.
#0
elements_before = ["O", "V"]
elements_after  = ["V", "O"]
coordinates = [[0.0, 0.0,  0.0], [0.0, 0.0, 1.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=1.0))
# Will customise

# Down, empty.
#1
elements_before = ["O", "V"]
elements_after  = ["V", "O"]
coordinates = [[0.0, 0.0, 0.0], [0.0, 0.0, -1.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=1.0))
# Will customise


# Now for Oxygen annihilation at the top boundary
#2
elements_before = ["O", "ToV"]
elements_after  = ["V", "ToV"]
coordinates = [[0.0, 0.0, 0.0], [0.0, 0.0, 1.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=1.0))
# Will customise the rate constant


# Oxygen creation at the top boundary
#3
elements_before = ["ToO", "V"]
elements_after  = ["ToO", "O"]
coordinates = [[0.0, 0.0, 0.0], [0.0, 0.0, -1.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=1.0))

# Now for Oxygen annihilation at the bottom boundary
#4
elements_before = ["O", "BoV"]
elements_after  = ["V", "BoV"]
coordinates = [[0.0, 0.0, 0.0], [0.0, 0.0, -1.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=1.0))
# Obviously the rate constant will be customised


# Oxygen creation at the bottom boundary
#5
elements_before = ["BoO", "V"]
elements_after  = ["BoO", "O"]
coordinates = [[0.0, 0.0, 0.0], [0.0, 0.0, 1.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=1.0))

# Boundary Oxygen creation at the bottom boundary
#6
elements_before = ["BoV"]
elements_after  = ["BoO"]
coordinates = [[0.0, 0.0, 0.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=1.0))

# Boundary Oxygen annihilation at the bottom boundary
#7
elements_before = ["BoO"]
elements_after  = ["BoV"]
coordinates = [[0.0, 0.0, 0.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=1.0))

# Boundary Oxygen creation at the top boundary
#8
elements_before = ["ToV"]
elements_after  = ["ToO"]
coordinates = [[0.0, 0.0, 0.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=1.0))

# Boundary Oxygen annihilation at the bottom boundary
#9
elements_before = ["ToO"]
elements_after  = ["ToV"]
coordinates = [[0.0, 0.0, 0.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=1.0))



# Create the interactions object.
interactions = KMCInteractions(processes, implicit_wildcards=True)


# Define the custom rates calculator, using the lol model as a template
class lolModelRates(KMCRateCalculatorPlugin):
    # Class for defining the custom rates function for the KMCLib paper. 
    def rate(self, geometry, elements_before, elements_after, rate_constant, process_number, global_coordinate):
        if process_number == 0:
            if len([e for e in elements_before if e == "O"]) + len([e for e in elements_before if e == "ToO"]) + len([e for e in elements_before if e == "BoO"]) == 2:
                return rateConstFull
            else:
                return rateConstEmpty

        if process_number == 1:
            if len([e for e in elements_before if e == "O"]) + len([e for e in elements_before if e == "ToO"]) + len([e for e in elements_before if e == "BoO"]) == 2:
                
                return rateConstFull
            else:
                return rateConstEmpty

        if process_number == 2:
            if len([e for e in elements_before if e == "O"]) + len([e for e in elements_before if e == "ToO"]) + len([e for e in elements_before if e == "BoO"]) == 2:
                return rateConstFull
            else:
                return rateConstEmpty

        if process_number == 4:
            if len([e for e in elements_before if e == "O"]) + len([e for e in elements_before if e == "ToO"]) + len([e for e in elements_before if e == "BoO"]) == 2:
                return rateConstFull
            else:
                return rateConstEmpty

        if process_number == 3:
            if len([e for e in elements_before if e == "O"]) + len([e for e in elements_before if e == "ToO"]) + len([e for e in elements_before if e == "BoO"]) == 2:
                return rateConstFull
            else:
                return rateConstEmpty

        if process_number == 5:
            if len([e for e in elements_before if e == "O"]) + len([e for e in elements_before if e == "ToO"]) + len([e for e in elements_before if e == "BoO"]) == 2:
                return rateConstFull
            else:
                return rateConstEmpty

        if process_number == 6:
            return botSpawn

        if process_number == 7:
            return botDespawn

        if process_number == 8:
            return topSpawn

        if process_number == 9:
            return topDespawn


    def cutoff(self):
        # Overloaded base class API function 
        return 1.0

interactions.setRateCalculator(rate_calculator=lolModelRates)




"""End of processes"""
###
##
#

# Create the model.
model = KMCLatticeModel(configuration, interactions)

processStatsOxInBot = ImageStats(processes=[5], time_interval=timeInterval, spatially_resolved=False, anal_Interval = 1, resultsPlace=resultsPlace, processesObject=processes)

# Define the parameters; not entirely sure if these are sensible or not...
control_parameters_snapshot = KMCControlParameters(number_of_steps=numImageSteps, analysis_interval=1,
                                          dump_interval=numImageSteps/sysSize)

control_parameters_equilib = KMCControlParameters(number_of_steps=numStepsEquilib, analysis_interval=numStepsEquilib/100,
                                          dump_interval=numStepsEquilib/100)


# Run the simulation - save trajectory to resultsPlace, which should by now exist

model.run(control_parameters_equilib, trajectory_filename=(resultsPlace+"equilibTraj.tr"))
model.run(control_parameters_snapshot, trajectory_filename=(resultsPlace+"snapTraj.tr"), analysis=[processStatsOxInBot])

print("Process would appear to have succesfully terminated! How very suspicious...")

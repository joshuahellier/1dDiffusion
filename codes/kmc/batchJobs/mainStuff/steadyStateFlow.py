import sys
import os
import math

resultDir = os.environ.get('RESULTS')
if resultDir == None :
    print ("WARNING! $RESULTS not set! Attempt to write results will fail!\n")

# Expecting input botConc, topConc, rateConstFull, sysSize, analInterval, numStepsEquilib, numStepsSnapshot, numStepsAnal, numStepsReq, numPasses, timeInterval,  fileCode

from KMCLib import *
from KMCLib.Backend import Backend
import numpy

botConc = float(sys.argv[1])
topConc = float(sys.argv[2])
rateConstFull = float(sys.argv[3])
sysSize = int(sys.argv[4])
analInterval = int(sys.argv[5])
numStepsEquilib = int(sys.argv[6])
numStepsSnapshot = int(sys.argv[7])
numStepsAnal = int(sys.argv[8])
numStepsReq = int(sys.argv[9])
numPasses = int(sys.argv[10])
timeInterval = float(sys.argv[11])
fileInfo = sys.argv[12]

resultsPlace = resultDir+"/"+fileInfo+"/"

if not os.path.exists(resultsPlace):
    os.makedirs(resultsPlace)

with open(resultsPlace+'settings', 'w') as f:
    f.write('BotConcentration = ' + str(botConc) +'\n')
    f.write('TopConcentration = ' + str(topConc) +'\n')
    f.write('FullRate = ' + str(rateConstFull) +'\n')
    f.write('SysSize = ' + str(sysSize) +'\n')
    f.write('TimeInterval = ' + str(timeInterval) +'\n')
    f.write('AnalInterval = ' +str(analInterval) + '\n')
    f.write('NumStepsEquilib = '+str(numStepsEquilib) +'\n')
    f.write('NumStepsSnapshot = '+str(numStepsSnapshot)+'\n')
    f.write('NumStepsAnal = '+str(numStepsAnal) +'\n')

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

# Generate the initial types. There's double-layered section of "To" at the top and "Bo" at the bottom
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
"""
for i in range(2, numPoints-2):
    if i < numPoints/2:
        types[i] = "O"
    else:
        types[i] = "V"
"""
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


"""I have all the processes explicitly spelled out here; however, for some weird reason this does not work
properly with KMCLib (as in, the processes involving the Bo atoms never seem to fire); hence I have switched
back to using custom rates.

# Bulk processes

# Up, empty.
#0
elements_before = ["O", "V", "V"]
elements_after  = ["V", "O", "V"]
coordinates = [[0.0, 0.0,  0.0], [0.0, 0.0, 1.0], [0.0, 0.0, -1.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=rateConstEmpty))
# Up, full.
#1
elements_before = ["O", "V", "O"]
elements_after  = ["V", "O", "O"]
coordinates = [[0.0, 0.0,  0.0], [0.0, 0.0, 1.0], [0.0, 0.0, -1.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=rateConstFull))

# Down, empty.
#2
elements_before = ["O", "V", "V"]
elements_after  = ["V", "O", "V"]
coordinates = [[0.0, 0.0, 0.0], [0.0, 0.0, -1.0], [0.0, 0.0, 1.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=rateConstEmpty))

# Down, full.
#3
elements_before = ["O", "V", "O"]
elements_after  = ["V", "O", "O"]
coordinates = [[0.0, 0.0, 0.0], [0.0, 0.0, -1.0], [0.0, 0.0, 1.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=rateConstFull))


# Now for Oxygen annihilation at the top boundary (when empty)
#4
elements_before = ["O", "To", "V"]
elements_after  = ["V", "To", "V"]
coordinates = [[0.0, 0.0, 0.0], [0.0, 0.0, 1.0], [0.0, 0.0, -1.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=rateConstEmpty*(1.0-topConc)))

# Now for Oxygen annihilation at the top boundary (when full)
#5
elements_before = ["O", "To", "O"]
elements_after  = ["V", "To", "O"]
coordinates = [[0.0, 0.0, 0.0], [0.0, 0.0, 1.0], [0.0, 0.0, -1.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=rateConstFull*(1.0-topConc)))


# Oxygen creation at the top boundary
#6
elements_before = ["V", "To"]
elements_after  = ["O", "To"]
coordinates = [[0.0, 0.0, 0.0], [0.0, 0.0, 1.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=topConc*(topConc*rateConstFull+(1.0-topConc)*rateConstEmpty)))

# Now for Oxygen annihilation at the bottom boundary, empty.
# Bottom
#7
elements_before = ["Bo", "O", "V"]
elements_after  = ["Bo", "V", "V"]
coordinates = [[0.0, 0.0, 0.0], [0.0, 0.0, 1.0], [0.0, 0.0, 2.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=rateConstEmpty*(1.0-botConc)))

# Now for Oxygen annihilation at the bottom boundary, full.
# Bottom
#8
elements_before = ["Bo", "O", "O"]
elements_after  = ["Bo", "V", "O"]
coordinates = [[0.0, 0.0, 0.0], [0.0, 0.0, 1.0], [0.0, 0.0, 2.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=rateConstFull*(1.0-botConc)))


# Oxygen creation at the bottom boundary
# Bottom
#9
elements_before = ["Bo", "V"]
elements_after  = ["Bo", "O"]
coordinates = [[0.0, 0.0, 0.0], [0.0, 0.0, 1.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=botConc*(rateConstFull*botConc+(1.0-botConc)*rateConstEmpty)))

# Special annoying corner cases for boundaries

# Up, bottom.
#10
elements_before = ["Bo", "O", "V"]
elements_after  = ["Bo", "V", "O"]
coordinates = [[0.0, 0.0, -1.0], [0.0, 0.0, 0.0], [0.0, 0.0, 1.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=(botConc*rateConstFull+(1.0-botConc)*rateConstEmpty)))

# Down, top.
#11
elements_before = ["V", "O", "To"]
elements_after  = ["O", "V", "To"]
coordinates = [[0.0, 0.0, -1.0], [0.0, 0.0, 0.0], [0.0, 0.0, 1.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=(topConc*rateConstFull + (1.0-topConc)*rateConstEmpty)))
"""

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

# Msd stuff; this is producing weird outputs, but probably because my parameter choices are completely wrong,
# so I'm not so worried about that yet
"""msd_analysis = OnTheFlyMSD(history_steps=10000,
                           n_bins=10000,
                           t_max=2000.0,
                           track_type="O")"""

# Trying to find out information about distribution of time steps
#timeStepDistn = TimeStepDistribution(0.1)
processStatsOxInBot = ProcessStatistics(processes=[5], time_interval=timeInterval, spatially_resolved=False, anal_Interval = analInterval, resultsPlace=resultsPlace, processesObject=processes)
processStatsOxOutBot = ProcessStatistics(processes=[4], time_interval=timeInterval, spatially_resolved=False, anal_Interval = analInterval)
processStatsOxInTop = ProcessStatistics(processes=[3], time_interval=timeInterval, spatially_resolved=False, anal_Interval = analInterval)
processStatsOxOutTop = ProcessStatistics(processes=[2], time_interval=timeInterval, spatially_resolved=False, anal_Interval = analInterval)
compositionTracker = Composition(time_interval=timeInterval)

# Define the parameters; not entirely sure if these are sensible or not...
control_parameters_equilib = KMCControlParameters(number_of_steps=numStepsEquilib, analysis_interval=numStepsEquilib/100,
                                          dump_interval=numStepsEquilib/100)

control_parameters_req = KMCControlParameters(number_of_steps=numStepsReq, analysis_interval=numStepsReq/100,
                                          dump_interval=numStepsReq/100)

control_parameters_snapshot = KMCControlParameters(number_of_steps=numStepsSnapshot, analysis_interval=1,
                                          dump_interval=numStepsSnapshot/100)

control_parameters_anal = KMCControlParameters(number_of_steps=numStepsAnal, analysis_interval=1,
                                          dump_interval=numStepsAnal/100)

# Run the simulation - save trajectory to resultsPlace, which should by now exist

model.run(control_parameters_equilib, trajectory_filename=(resultsPlace+"equilibTraj.tr"))

model.run(control_parameters_snapshot, trajectory_filename=(resultsPlace+"snapTraj.tr"), analysis=[processStatsOxInBot, processStatsOxOutBot, processStatsOxInTop, processStatsOxOutTop])

with open(resultsPlace+"procOxInBotSnap.dat", 'w') as f:
    processStatsOxInBot.printResults(f)

with open(resultsPlace+"procOxOutBotSnap.dat", 'w') as f:
    processStatsOxOutBot.printResults(f)

with open(resultsPlace+"procOxInTopSnap.dat", 'w') as f:
    processStatsOxInTop.printResults(f)

with open(resultsPlace+"procOxOutTopSnap.dat", 'w') as f:
    processStatsOxOutTop.printResults(f)

for passNum in range(0, numPasses):
    processStatsOxInBot = ProcessStatistics(processes=[5], time_interval=timeInterval, spatially_resolved=False, anal_Interval = analInterval)
    processStatsOxOutBot = ProcessStatistics(processes=[4], time_interval=timeInterval, spatially_resolved=False, anal_Interval = analInterval)
    processStatsOxInTop = ProcessStatistics(processes=[3], time_interval=timeInterval, spatially_resolved=False, anal_Interval = analInterval)
    processStatsOxOutTop = ProcessStatistics(processes=[2], time_interval=timeInterval, spatially_resolved=False, anal_Interval = analInterval)
    model.run(control_parameters_req, trajectory_filename=(resultsPlace+"mainTraj.tr"))
    model.run(control_parameters_anal, trajectory_filename=(resultsPlace+"mainTraj.tr"), analysis=[processStatsOxInBot, processStatsOxOutBot, processStatsOxInTop, processStatsOxOutTop, compositionTracker])

    if not os.path.exists(resultsPlace+"inBot"):
        os.makedirs(resultsPlace+"inBot")
    if not os.path.exists(resultsPlace+"outBot"):
        os.makedirs(resultsPlace+"outBot")
    if not os.path.exists(resultsPlace+"inTop"):
        os.makedirs(resultsPlace+"inTop")
    if not os.path.exists(resultsPlace+"outTop"):
        os.makedirs(resultsPlace+"outTop")
    if not os.path.exists(resultsPlace+"composition"):
        os.makedirs(resultsPlace+"composition")

    with open(resultsPlace+"inBot/inBot"+str(passNum)+".dat", 'w') as f:
        processStatsOxInBot.printResults(f)
    with open(resultsPlace+"outBot/outBot"+str(passNum)+".dat", 'w') as f:
        processStatsOxOutBot.printResults(f)
    with open(resultsPlace+"inTop/inTop"+str(passNum)+".dat", 'w') as f:
        processStatsOxInTop.printResults(f)
    with open(resultsPlace+"outTop/outTop"+str(passNum)+".dat", 'w') as f:
        processStatsOxOutTop.printResults(f)
    with open(resultsPlace+"composition/composition"+str(passNum)+".dat", 'w') as f:
        compositionTracker.printResults(f)

print("Process would appear to have succesfully terminated! How very suspicious...")

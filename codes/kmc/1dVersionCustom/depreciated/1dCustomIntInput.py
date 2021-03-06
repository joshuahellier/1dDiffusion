import sys
import os

# Don't use this script, it kinda sucks!

resultDir = os.environ.get('RESULTS')
if resultDir == None :
    print "WARNING! $RESULTS not set! Attempt to write results will fail!\n"

# Expecting input avConc, concDiff, rateConstFull, sysSize, numSteps, transTime,  fileCode

from KMCLib import *
from KMCLib.Backend import Backend
import numpy

avConcInt = int(sys.argv[1])
concDiffInt = int(sys.argv[2])
rateConstFullInt = int(sys.argv[3])
sysSize = int(sys.argv[4])
numSteps = int(sys.argv[5])
transTimeInt = int(sys.argv[6])
avConc = 0.001*avConcInt
concDiff = 0.001*concDiffInt
rateConstFull = 0.001*rateConstFullInt
transTime = 0.001*transTimeInt
fileInfo = sys.argv[7]

resultsPlace = resultDir+"/"+fileInfo+"/"

if not os.path.exists(resultsPlace):
    os.makedirs(resultsPlace)

with open(resultsPlace+'/settings', 'w') as f:
    f.write('AverageConcentration=' + str(avConc) +'\n')
    f.write('ConcDifference=' + str(concDiff) +'\n')
    f.write('FullRate=' + str(rateConstFull) +'\n')
    f.write('SysSize=' + str(sysSize) +'\n')
    f.write('TransientTime=' + str(transTime) +'\n')

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

# Generate the initial types. There's double-layered
types = ["V"]*numPoints
types[0] = "Bo"
types[1] = "Bo"
types[-2] = "To"
types[-1] = "To"
for i in range(int(zRep*avConc)):
    # find a site which is not yet occupied by a "D" type.
    pos = int(numpy.random.rand()*zRep+2.0)
    while (types[pos] != "V"):
        pos = int(numpy.random.rand()*zRep+2.0)
    # Set the type.
    types[pos] = "O"

# Setup the configuration.
configuration = KMCConfiguration(lattice=lattice,
                                 types=types,
                                 possible_types=["O","V","To","Bo"])





# Rates.
rateConstEmpty        	= 1.0
topConc 		= avConc + 0.5*concDiff
bottConc		= avConc - 0.5*concDiff

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
elements_before = ["V", "O"]
elements_after  = ["O", "V"]
coordinates = [[0.0, 0.0, 0.0], [0.0, 0.0, 1.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=1.0))
# Will customise


# Now for empty Oxygen annihilation at the top boundary
#2
elements_before = ["O", "To"]
elements_after  = ["V", "To"]
coordinates = [[0.0, 0.0, 0.0], [0.0, 0.0, 1.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=1.0))
# Will customise the rate constant


# Oxygen creation at the top boundary
#3
elements_before = ["V", "To"]
elements_after  = ["O", "To"]
coordinates = [[0.0, 0.0, 0.0], [0.0, 0.0, 1.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=(topConc*rateConstFull+(1.0-topConc)*rateConstEmpty)))

# Now for Oxygen annihilation at the bottom boundary
# Bottom
#4
elements_before = ["Bo", "O"]
elements_after  = ["Bo", "V"]
coordinates = [[0.0, 0.0, 0.0], [0.0, 0.0, 1.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=1.0))
# Obviously the rate constant will be customised


# Oxygen creation at the bottom boundary
# Bottom
#5
elements_before = ["Bo", "V"]
elements_after  = ["Bo", "O"]
coordinates = [[0.0, 0.0, 0.0], [0.0, 0.0, 1.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=(rateConstFull*bottConc+(1.0-bottConc)*rateConstEmpty)))

# Create the interactions object.
interactions = KMCInteractions(processes, implicit_wildcards=True)

# Define the custom rates calculator, using the lol model as a template
class lolModelRates(KMCRateCalculatorPlugin):
    """ Class for defining the custom rates function for the KMCLib paper. """
    def rate(self, geometry, elements_before, elements_after, rate_constant, process_number, global_coordinate):

        if process_number in [0, 1]:
            if len([e for e in elements_before if e == "O"]) == 2:
                return rateConstFull

        if process_number == 2:
            if len([e for e in elements_before if e == "O"]) == 2:
                return rateConstFull

        if process_number == 4:
            if len([e for e in elements_before if e == "O"]) == 2:
                return rateConstFull

        return 1.0

    def cutoff(self):
        """ Overloaded base class API function """
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
processStatsOxInBot = ProcessStatistics(processes=[5], time_interval=100000.0, spatially_resolved=False, transientTime=transTime)
processStatsOxOutBot = ProcessStatistics(processes=[4], time_interval=100000.0, spatially_resolved=False, transientTime=transTime)
processStatsOxInTop = ProcessStatistics(processes=[3], time_interval=100000.0, spatially_resolved=False, transientTime=transTime)
processStatsOxOutTop = ProcessStatistics(processes=[2], time_interval=100000.0, spatially_resolved=False, transientTime=transTime)

# Define the parameters; not entirely sure if these are sensible or not...
control_parameters = KMCControlParameters(number_of_steps=numSteps, analysis_interval=1000,
                                          dump_interval=1000000)

# Run the simulation - save trajectory to resultsPlace, which should by now exist

model.run(control_parameters, trajectory_filename=(resultsPlace+"traj.tr"), analysis=[processStatsOxInBot, processStatsOxOutBot, processStatsOxInTop, processStatsOxOutTop])

"""with open('msdData.data', 'w') as f:
    msd_analysis.printResults(f)"""

"""with open(resultsPlace+"/times.dat", 'w') as f:
    timeStepDistn.printResults(f)"""

with open(resultsPlace+"/procOxInBot.dat", 'w') as f:
    processStatsOxInBot.printResults(f)

with open(resultsPlace+"/procOxOutBot.dat", 'w') as f:
    processStatsOxOutBot.printResults(f)

with open(resultsPlace+"/procOxInTop.dat", 'w') as f:
    processStatsOxInTop.printResults(f)

with open(resultsPlace+"/procOxOutTop.dat", 'w') as f:
    processStatsOxOutTop.printResults(f)

print("Process would appear to have succesfully terminated! How very suspicious...")

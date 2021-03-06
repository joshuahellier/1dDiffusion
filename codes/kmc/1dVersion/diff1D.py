import sys
import os

resultDir = os.environ.get('RESULTS')
if resultDir == None :
    print "WARNING! $RESULTS not set! Attempt to write results will fail!\n"

# Expecting input avConc, concDiff, rateConstFull, fileCode

from KMCLib import *
from KMCLib.Backend import Backend
# Load the configuration and interactions.
configuration = KMCConfigurationFromScript("config.py")


avConc = float(sys.argv[1])
concDiff = float(sys.argv[2])
rateConstFull = float(sys.argv[3])
fileInfo = sys.argv[4]

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
elements_before = ["V", "O", "V"]
elements_after  = ["V", "V", "O"]
coordinates = [[0.0, 0.0, -1.0], [0.0, 0.0,  0.0], [0.0, 0.0, 1.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=rateConstEmpty))

# Down, empty.
#1
elements_before = ["V", "O", "V"]
elements_after  = ["O", "V", "V"]
coordinates = [[0.0, 0.0, -1.0], [0.0, 0.0, 0.0], [0.0, 0.0, 1.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=rateConstEmpty))

# Up, full.
#2
elements_before = ["O", "O", "V"]
elements_after  = ["O", "V", "O"]
coordinates = [[0.0, 0.0, -1.0], [0.0, 0.0, 0.0], [0.0, 0.0, 1.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=rateConstFull))

# Down, full.
#3
elements_before = ["V", "O", "O"]
elements_after  = ["O", "V", "O"]
coordinates = [[0.0, 0.0, -1.0], [0.0, 0.0, 0.0], [0.0, 0.0, 1.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=rateConstFull))

# Special annoying corner cases for boundaries

# Up, bottom.
#4
elements_before = ["Bo", "O", "V"]
elements_after  = ["Bo", "V", "O"]
coordinates = [[0.0, 0.0, -1.0], [0.0, 0.0, 0.0], [0.0, 0.0, 1.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=(bottConc*rateConstFull+(1.0-bottConc)*rateConstEmpty)))

# Down, top.
#5
elements_before = ["V", "O", "To"]
elements_after  = ["O", "V", "To"]
coordinates = [[0.0, 0.0, -1.0], [0.0, 0.0, 0.0], [0.0, 0.0, 1.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=(topConc*rateConstFull + (1.0-topConc)*rateConstEmpty)))

# Now for empty Oxygen annihilation at the top boundary
#6
elements_before = ["V", "O", "To"]
elements_after  = ["V", "V", "To"]
coordinates = [[0.0, 0.0, -1.0], [0.0, 0.0, 0.0], [0.0, 0.0, 1.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=(1.0-topConc)*rateConstEmpty))

# Full Oxygen annihilation at the top boundary
#7
elements_before = ["O", "O", "To"]
elements_after  = ["O", "V", "To"]
coordinates = [[0.0, 0.0, -1.0], [0.0, 0.0, 0.0], [0.0, 0.0, 1.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=(1.0-topConc)*rateConstFull))

# Oxygen creation at the top boundary
#8
elements_before = ["V", "To"]
elements_after  = ["O", "To"]
coordinates = [[0.0, 0.0, 0.0], [0.0, 0.0, 1.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=(topConc*rateConstFull+(1.0-topConc)*rateConstEmpty)))

# Now for empty Oxygen annihilation at the bottom boundary
# Bottom
#9
elements_before = ["Bo", "O", "V"]
elements_after  = ["Bo", "V", "V"]
coordinates = [[0.0, 0.0, -1.0], [0.0, 0.0, 0.0], [0.0, 0.0, 1.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=(1.0-bottConc)*rateConstEmpty))

# Now for full Oxygen annihilation at the bottom boundary
# Bottom
#10
elements_before = ["Bo", "O", "O"]
elements_after  = ["Bo", "V", "O"]
coordinates = [[0.0, 0.0, -1.0], [0.0, 0.0, 0.0], [0.0, 0.0, 1.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=(1.0-bottConc)*rateConstFull))

# Oxygen creation at the bottom boundary
# Bottom
#11
elements_before = ["Bo", "V"]
elements_after  = ["Bo", "O"]
coordinates = [[0.0, 0.0, 0.0], [0.0, 0.0, 1.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=(rateConstFull*bottConc+(1.0-bottConc)*rateConstEmpty)))

# Create the interactions object.
interactions = KMCInteractions(processes,
                               implicit_wildcards=True)


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
timeStepDistn = TimeStepDistribution(0.1)
processStatsOxInBot = ProcessStatistics(processes=[11], time_interval=1000.0, spatially_resolved=False)
processStatsOxOutBot = ProcessStatistics(processes=[9, 10], time_interval=1000.0, spatially_resolved=False)
processStatsOxInTop = ProcessStatistics(processes=[8], time_interval=1000.0, spatially_resolved=False)
processStatsOxOutTop = ProcessStatistics(processes=[6, 7], time_interval=1000.0, spatially_resolved=False)

# Define the parameters; not entirely sure if these are sensible or not...
control_parameters = KMCControlParameters(number_of_steps=100000, analysis_interval=100,
                                          dump_interval=100)

# Run the simulation - save trajectory to the thing below

resultsPlace = resultDir+"/"+fileInfo+"/"

if not os.path.exists(resultsPlace):
    os.makedirs(resultsPlace)

model.run(control_parameters, trajectory_filename=(resultsPlace+"traj.tr"), analysis=[timeStepDistn, processStatsOxInBot, processStatsOxOutBot, processStatsOxInTop, processStatsOxOutTop])

"""with open('msdData.data', 'w') as f:
    msd_analysis.printResults(f)"""

with open(resultsPlace+"/times.dat", 'w') as f:
    timeStepDistn.printResults(f)

with open(resultsPlace+"/procOxInBot.dat", 'w') as f:
    processStatsOxInBot.printResults(f)

with open(resultsPlace+"/procOxOutBot.dat", 'w') as f:
    processStatsOxOutBot.printResults(f)

with open(resultsPlace+"/procOxInTop.dat", 'w') as f:
    processStatsOxInTop.printResults(f)

with open(resultsPlace+"/procOxOutTop.dat", 'w') as f:
    processStatsOxOutTop.printResults(f)

print(topConc)
print(bottConc)
print(rateConstFull)
print(rateConstEmpty)

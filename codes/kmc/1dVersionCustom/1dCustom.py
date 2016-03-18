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
timeStepDistn = TimeStepDistribution(0.1)
processStatsOxInBot = ProcessStatistics(processes=[5], time_interval=10000.0, spatially_resolved=False)
processStatsOxOutBot = ProcessStatistics(processes=[4], time_interval=10000.0, spatially_resolved=False)
processStatsOxInTop = ProcessStatistics(processes=[3], time_interval=10000.0, spatially_resolved=False)
processStatsOxOutTop = ProcessStatistics(processes=[2], time_interval=10000.0, spatially_resolved=False)

# Define the parameters; not entirely sure if these are sensible or not...
control_parameters = KMCControlParameters(number_of_steps=100000000, analysis_interval=1000,
                                          dump_interval=10000)

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

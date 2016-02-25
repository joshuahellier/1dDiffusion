import sys
import os

resultDir = os.environ.get('RESULTS')

# Expecting input avConc, concDiff, rateConstFull, fileCode

from KMCLib import *
from KMCLib.Backend import Backend
# Load the configuration and interactions.
configuration = KMCConfigurationFromScript("config.py")


# Only on the first set of basis_points for O/V
basis_sites     = [0]

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

# Bulk processes
# Up, empty.
elements_before = ["V", "O", "V"]
elements_after  = ["V", "V", "O"]
coordinates = [[0.0, 0.0, -1.0], [0.0, 0.0,  0.0], [0.0, 0.0, 1.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=rateConstEmpty))

# Down, empty.
elements_before = ["V", "O", "V"]
elements_after  = ["O", "V", "V"]
coordinates = [[0.0, 0.0, -1.0], [0.0, 0.0, 0.0], [0.0, 0.0, 1.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=rateConstEmpty))

# Up, full.
elements_before = ["O", "O", "V"]
elements_after  = ["O", "V", "O"]
coordinates = [[0.0, 0.0, -1.0], [0.0, 0.0, 0.0], [0.0, 0.0, 1.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=rateConstFull))

# Down, full.
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
elements_before = ["Bo", "O", "V"]
elements_after  = ["Bo", "V", "O"]
coordinates = [[0.0, 0.0, -1.0], [0.0, 0.0, 0.0], [0.0, 0.0, 1.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=(bottConc*rateConstFull+(1.0-bottConc)*rateConstEmpty)))

# Down, top.
elements_before = ["V", "O", "To"]
elements_after  = ["O", "V", "To"]
coordinates = [[0.0, 0.0, -1.0], [0.0, 0.0, 0.0], [0.0, 0.0, 1.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=(topConc*rateConstFull + (1.0-topConc)*rateConstEmpty)))

# Now for empty Oxygen annihilation at the top boundary
elements_before = ["V", "O", "To"]
elements_after  = ["V", "V", "To"]
coordinates = [[0.0, 0.0, -1.0], [0.0, 0.0, 0.0], [0.0, 0.0, 1.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=(1.0-topConc)*rateConstEmpty))

# Full Oxygen annihilation at the top boundary
elements_before = ["O", "O", "To"]
elements_after  = ["O", "V", "To"]
coordinates = [[0.0, 0.0, -1.0], [0.0, 0.0, 0.0], [0.0, 0.0, 1.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=(1.0-topConc)*rateConstFull))

# Oxygen creation at the top boundary
elements_before = ["O", "To"]
elements_after  = ["V", "To"]
coordinates = [[0.0, 0.0, 0.0], [0.0, 0.0, 1.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=topConc*(topConc*rateConstFull+(1.0-topConc)*rateConstEmpty)))

# Now for empty Oxygen annihilation at the bottom boundary
# Bottom
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
timeStepDistn = TimeStepDistribution(10.0)

# Define the parameters; not entirely sure if these are sensible or not...
control_parameters = KMCControlParameters(number_of_steps=10000, analysis_interval=10,
                                          dump_interval=1)

# Run the simulation - save trajectory to the thing below
model.run(control_parameters, trajectory_filename=(resultDir+"/diff1d/diff1dTraj.tr"), analysis=[timeStepDistn])

"""with open('msdData.data', 'w') as f:
    msd_analysis.printResults(f)"""

with open(resultDir+"/diff1d/times.dat", 'w') as f:
    timeStepDistn.printResults(f)

# This is the main script used to launch KMCLib calculations for our investigation into the SPM (Sticky Particle Model).

import sys
import os
import math
import shutil
from KMCLib import *
from KMCLib.Backend import Backend
import numpy
from RateCalc import *
from DensHist import *
from BlockStats import *
from foldyFloatList import *

#set the top level directory for results to be written into from the variable RESULTS, assumed to be already set in .bashrc or equivalent.
resultDir = os.environ.get('RESULTS')
if resultDir == None :
    print ("WARNING! $RESULTS not set! Attempt to write results will fail!\n")

# Expecting command line input along with the script being called, in the form:
# - botConc, topConc, rateConstFull, sysSize, analInterval, numStepsEquilib, numStepsSnapshot, numStepsAnal, numStepsReq, numPasses, timeInterval,  fileCode - as defined below.
# Note that we perform an initial equilibration run, then we alternate between analysis runs and reequilibration runs numpasses times. Measurements are only taken during
# the analysis runs, but many of these measurements only really mean anything when taken over some period of time. Therefore, each "pass" we take measurements,
# e.g. noting how many particles come in and out of each boundary, over a period of time, then perform a load of KMC steps with no measurement, and repeat several times.
# In this way we can obtain many different measurements of, say, the total current through the system, and hopefully obtain useful information like statistical moments
# of such quantities. The reason we do reequilibration runs is in order to mitigate against temporal autocorrelations, which might ruin some of those moments. 

# Now we convert the command line inputs to the correct types:

# The concentration at the bottom boundary. Should be a floating point number in (0, 1).
botConc = float(sys.argv[1])

# The concentration at the bottom boundary. Should be a floating point number in (0, 1).
topConc = float(sys.argv[2])

# The anomalous diffusion rate, \lambda, as defined for the SPM. Should be a positive floating point number.
rateConstFull = float(sys.argv[3])

# The system size, L as defined in my thesis. The number of lattice sites in the system will therefore be L+4. Should be a positive integer.
sysSize = int(sys.argv[4])

# The interval between analysis routine uses. In order to use a lot of the analysis routines we have made, it should really be set at 1.
analInterval = int(sys.argv[5])

# The number of KMC steps we run initially whilst taking no measurements. This is in order to "equilibrate" the system.
numStepsEquilib = int(sys.argv[6])

# The number of KMC steps performed during each analysis run.
numStepsAnal = int(sys.argv[7])

# The number of KMC steps performed during the relaxation runs, which occur between the analysis runs.
numStepsReq = int(sys.argv[8])

# The number of times we alternate between analysis and reequilibration runs.
numPasses = int(sys.argv[9])

# The coarseness with which we bin timestamps; it is required input for for composition tracker, which we need to measure things like overall density.
timeInterval = float(sys.argv[10])

# The place we're going to put the results, relative to RESULTS.
fileInfo = sys.argv[11]

resultsPlace = resultDir+"/"+fileInfo+"/"

# If the folder to store the results in doesn't exists yet, make it
if not os.path.exists(resultsPlace):
    os.makedirs(resultsPlace)

# Now we put a file called "settings" in the folder, containing the important variables used to set up the calculation. Note that we don't bother with numPasses,
# as it is obvious from the output, or timeInterval, as it should just be set low enough to begin with.
with open(resultsPlace+'settings', 'w') as f:
    f.write('BotConcentration = ' + str(botConc) +'\n')
    f.write('TopConcentration = ' + str(topConc) +'\n')
    f.write('FullRate = ' + str(rateConstFull) +'\n')
    f.write('SysSize = ' + str(sysSize) +'\n')
    f.write('TimeInterval = ' + str(timeInterval) +'\n')
    f.write('AnalInterval = ' +str(analInterval) + '\n')
    f.write('NumStepsEquilib = '+str(numStepsEquilib) +'\n')
    f.write('NumStepsAnal = '+str(numStepsAnal) +'\n')
    f.write('NumStepsReq = '+str(numStepsReq) +'\n')

"""I've put this stuff in the file to make command line input easier"""
# It seems that the developer intended the information about configurations, rates etc to be stored in separate files; however, that actually make it a lot more annoying
# to automate the calculations as batch processes, so instead we do it all in this file.

# We need to specify the unit cell, which is our case is just a 1-d chain. Therefore, let's just use unit cubes.
cell_vectors = [[1.0,0.0,0.0],
                [0.0,1.0,0.0],
                [0.0,0.0,1.0]]

# Let's put the "atoms" at the origin of each cube.
basis_points = [[0.0, 0.0, 0.0]]

unit_cell = KMCUnitCell(cell_vectors=cell_vectors,
                        basis_points=basis_points)

# Define the lattice. zRep = sysSize = L in our convention
xRep = 1
yRep = 1
zRep = sysSize
numPoints = xRep*(zRep+4)*yRep
lattice = KMCLattice(unit_cell=unit_cell,
                     repetitions=(xRep,yRep,zRep+4),
                     periodic=(False, False, True))

# Generate the initial types. We initially fill the system randomly to have a density equal to the average of the top and bottom densities.
# There's double-layered section, initially of "ToV" at the top and "BoV" at the bottom, which are their own thing (see below).
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


# Setup the configuration. We combine the information we already gave about the system geometry, along with a list of possible types:
# O: a particle
# V: a vacancy
# ToV: a vacancy in the top boundary layers
# ToO: a particle in the top boundary layers
# BoO: a particle in the bottom boundary layers
# ToV: a vacancy in the bottom boundary layers
configuration = KMCConfiguration(lattice=lattice,
                                 types=types,
                                 possible_types=["O","V","ToV","BoV", "ToO", "BoO"])


# Rates. rateConstFull=\lambda is already set of course. topSpawn and bottomSpawn are the rates at which vacant boundary sites fill at the boundaries;
# topDespawn and botDespawn are the rates at which particles disappear at the boundaries. Obviously these are chosen so that their ratio is such that the boundaries
# maintain the correct average occupation in equilibrium. We have chosen to multiply all rates by sqrt(rateConstFull) for the reasons described in the thesis.
rateConstEmpty        	= 1.0
topSpawn = math.sqrt(rateConstFull*topConc/(1.0-topConc))
botSpawn = math.sqrt(rateConstFull*botConc/(1.0-botConc))
topDespawn = rateConstFull/topSpawn
botDespawn = rateConstFull/botSpawn

#
##
###
"""I've put the processes in here to make it easier to adjust them via command line arguments."""

# In KMCLib, we basically make a list of allowed processes, by showing how they operate. The algorithm uses pattern recognition to work out which processes are allowed at each
# kmc step.

# Make a list of processesm to fill as we go along.
processes = []

# Only on the first set of basis_points for O/V , because we're only using one point per cell.
basis_sites     = [0]

# To specify a possible transition, we specify the relative coordinates of the site locations, their contents before and after the transition, which set of bases to use 
# (trivial for us as there is only one) and the transition rate. Here we set the transition rate to 1.0, as we will customise it later.

# First, bulk processes. Up means increasing the z-coordinate (the one we're using for our 1d chain); down means decreasing the z-coordinate.


# Move particle into vacancy above.
#0
elements_before = ["O", "V"]
elements_after  = ["V", "O"]
coordinates = [[0.0, 0.0,  0.0], [0.0, 0.0, 1.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=1.0))

# Move particle into adjacency below.
#1
elements_before = ["O", "V"]
elements_after  = ["V", "O"]
coordinates = [[0.0, 0.0, 0.0], [0.0, 0.0, -1.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=1.0))



# Now for particle annihilation at the top boundary. If there's a vacancy in the top layer (a ToV particle), we can move a particle into it.
# In the instance that a particle does this, we actually just destroy it, as once it's in the boundary its value will soon be refreshed anyway.
# 2
elements_before = ["O", "ToV"]
elements_after  = ["V", "ToV"]
coordinates = [[0.0, 0.0, 0.0], [0.0, 0.0, 1.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=1.0))


# Particle creation at the top boundary. Same idea, only now a particle "appears" in the bulk of the system because there was a particle in the adjacent boundary slot.
# Again, we don't actually alter the inner boundary's occupation, as its value should be refreshed.
#3
elements_before = ["ToO", "V"]
elements_after  = ["ToO", "O"]
coordinates = [[0.0, 0.0, 0.0], [0.0, 0.0, -1.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=1.0))

# Particle annihilation at the bottom boundary. Same as for the top boundary.
#4
elements_before = ["O", "BoV"]
elements_after  = ["V", "BoV"]
coordinates = [[0.0, 0.0, 0.0], [0.0, 0.0, -1.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=1.0))


# Particle creation at the bottom boundary. Same as for the top boundary.
#5
elements_before = ["BoO", "V"]
elements_after  = ["BoO", "O"]
coordinates = [[0.0, 0.0, 0.0], [0.0, 0.0, 1.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=1.0))

# Boundary particle creation at the bottom boundary.
#6
elements_before = ["BoV"]
elements_after  = ["BoO"]
coordinates = [[0.0, 0.0, 0.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=1.0))

# Boundary particle annihilation at the bottom boundary
#7
elements_before = ["BoO"]
elements_after  = ["BoV"]
coordinates = [[0.0, 0.0, 0.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=1.0))

# Boundary particle creation at the top boundary
#8
elements_before = ["ToV"]
elements_after  = ["ToO"]
coordinates = [[0.0, 0.0, 0.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=1.0))

# Boundary particle annihilation at the bottom boundary
#9
elements_before = ["ToO"]
elements_after  = ["ToV"]
coordinates = [[0.0, 0.0, 0.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=1.0))


# Create the interactions object. This is the processes we've specified above, plus an instruction to use implicit wildcards (i.e. pattern matching).
interactions = KMCInteractions(processes, implicit_wildcards=True)


# Define the custom rates calculator
class SPMRates(KMCRateCalculatorPlugin):
    # Class for defining the custom rates function. Here is where we determine what rate to use as the transition rate. When defining the rates above, I have noted their position
    # in the list of processes in the comments.
    def rate(self, geometry, elements_before, elements_after, rate_constant, process_number, global_coordinate):
        # For bulk motion, if there's 2 particles in the cell and adjacent cells, use the sticky transition rate; otherwise, use the normal one (set to 1.0 by default).
        if process_number == 0:
            if len([e for e in elements_before if e == "O"]) + len([e for e in elements_before if e == "ToO"]) + len([e for e in elements_before if e == "BoO"]) == 2:
                return rateConstFull
            else:
                return rateConstEmpty

        if process_number == 1:
            # Same idea, for motion in the other direction.
            if len([e for e in elements_before if e == "O"]) + len([e for e in elements_before if e == "ToO"]) + len([e for e in elements_before if e == "BoO"]) == 2:
                
                return rateConstFull
            else:
                return rateConstEmpty

        if process_number == 2:
            # Now for particle motions between the boundaries and the bulk.
            if len([e for e in elements_before if e == "O"]) + len([e for e in elements_before if e == "ToO"]) + len([e for e in elements_before if e == "BoO"]) == 2:
                return rateConstFull
            else:
                return rateConstEmpty

        if process_number == 4:
            # Ditto
            if len([e for e in elements_before if e == "O"]) + len([e for e in elements_before if e == "ToO"]) + len([e for e in elements_before if e == "BoO"]) == 2:
                return rateConstFull
            else:
                return rateConstEmpty

        if process_number == 3:
            # Ditto
            if len([e for e in elements_before if e == "O"]) + len([e for e in elements_before if e == "ToO"]) + len([e for e in elements_before if e == "BoO"]) == 2:
                return rateConstFull
            else:
                return rateConstEmpty

        if process_number == 5:
            # Ditto
            if len([e for e in elements_before if e == "O"]) + len([e for e in elements_before if e == "ToO"]) + len([e for e in elements_before if e == "BoO"]) == 2:
                return rateConstFull
            else:
                return rateConstEmpty

        # The following adjustments just cause the correct rates for the spawning/despawning processes at the boundaries.
        if process_number == 6:
            return botSpawn

        if process_number == 7:
            return botDespawn

        if process_number == 8:
            return topSpawn

        if process_number == 9:
            return topDespawn


    def cutoff(self):
        # Overloaded base class API function. This determines the radius around the interaction site which KMCLib considers in its "elements_before" and "elements_empty" lists;
        # thus, by setting it to 1.0 we consider the nearest neighbours as part of that locality, but no further.
        return 1.0

interactions.setRateCalculator(rate_calculator=SPMRates)
"""End of processes"""
###
##
#

# Create the model. This is the configuration + the interactions.
model = KMCLatticeModel(configuration, interactions)

# This is what we need to track the composition of the system. It only refreshes every timeInterval, so we need to consider that when we want density measurements.
compositionTracker = Composition(time_interval=timeInterval)

# Define the parameter sets which control the different types of calculation run we perform as part of the whole process.
# This is the equilibration run. Although we have stated an analysis interval, we don't actually take any measurements. Also we have set it up so that it only records
# one information dump (as we're not actually going to be checking that output, and we want to conserve hard memory).
control_parameters_equilib = KMCControlParameters(number_of_steps=numStepsEquilib, analysis_interval=numStepsEquilib/100,
                                          dump_interval=numStepsEquilib+1)

# Same idea, but now for the reequilibration runs.
control_parameters_req = KMCControlParameters(number_of_steps=numStepsReq, analysis_interval=numStepsReq/100,
                                          dump_interval=numStepsReq+1)

# Very similar idea, but for the analysis runs. Now we specify that we want analysis to be done every step; otherwise, we can't actually count the true flow of particles,
# which is essentially the entire point of this exercise.
control_parameters_anal = KMCControlParameters(number_of_steps=numStepsAnal, analysis_interval=1,
                                          dump_interval=numStepsAnal+1)

# Run the simulation using equilibration parameters - save trajectory /dev/null, as we don't actually have any desire to store it.
model.run(control_parameters_equilib, trajectory_filename=("/dev/null"))

# Create fresh files to store the data about the rates at which particles enter and leave the boundaries.
with open(resultsPlace+"inBot.dat", 'w') as f:
    pass
with open(resultsPlace+"outBot.dat", 'w') as f:
    pass
with open(resultsPlace+"inTop.dat", 'w') as f:
    pass
with open(resultsPlace+"outTop.dat", 'w') as f:
    pass

# Same idea, with a place to put the histogram of the number of particles.
if not os.path.exists(resultsPlace+"numHists"):
    os.makedirs(resultsPlace+"numHists")

# Same idea, with the block size distribution.
if not os.path.exists(resultsPlace+"blockStats"):
    os.makedirs(resultsPlace+"blockStats")

# Creating a couple of empty lists, which we can fill with data.
ovNumHist = []
for index in range(0, sysSize):
    ovNumHist.append(0.0)

ovBlockHist = []
for index in range(0, sysSize):
    ovBlockHist.append(0.0)

# Now that we've hopefully equilibrated the system and everything is ready, we can start our cycle of data collection and relaxation.
for passNum in range(0, numPasses):
    # Here we specify a bunch of analysis objects to be used in the analysis run.
    processStatsOxInBot = RateCalc(processes=[5])
    processStatsOxOutBot = RateCalc(processes=[4])
    processStatsOxInTop = RateCalc(processes=[3])
    processStatsOxOutTop = RateCalc(processes=[2])
    numHist = DensHist(spec=["O"], inProc=[5, 3], outProc=[4, 2])
    blockStat = BlockStats(blockComp = ["O"])
    # Now run the relaxation run.
    model.run(control_parameters_req, trajectory_filename=("/dev/null"))
    # Now run the analysis run.
    model.run(control_parameters_anal, trajectory_filename=("/dev/null"), analysis=[processStatsOxInBot, processStatsOxOutBot, processStatsOxInTop, processStatsOxOutTop, numHist, blockStat])
    # Now our analysis objects should be filled with useful data. We add it to our records.
    # First we save the numbers of particles created and destroyed at each boundary. This will form the main body of the calculation of the total current.
    with open(resultsPlace+"inBot.dat", 'a') as f:
        processStatsOxInBot.printResults(f)
    with open(resultsPlace+"outBot.dat", 'a') as f:
        processStatsOxOutBot.printResults(f)
    with open(resultsPlace+"inTop.dat", 'a') as f:
        processStatsOxInTop.printResults(f)
    with open(resultsPlace+"outTop.dat", 'a') as f:
        processStatsOxOutTop.printResults(f)
    # Here we use temporary files to store and process histogram data into something more compact, adding to ovNumHist and ovBlockHist; again, this is due to hard memory constraints.
    with open(resultsPlace+"numHists/numHist"+str(passNum)+".dat", 'w') as f:
        pass
    with open(resultsPlace+"numHists/numHist"+str(passNum)+".dat", 'a') as f:
        numHist.printResults(f)
    with open(resultsPlace+"numHists/numHist"+str(passNum)+".dat", 'r') as f:
        lines = f.readlines()
        for index in range(0, sysSize):
            words = lines[index].split()
            ovNumHist[index] += float(words[1])
    os.remove(resultsPlace+"numHists/numHist"+str(passNum)+".dat")
    with open(resultsPlace+"blockStats/blockStat"+str(passNum)+".dat", 'w') as f:
        pass
    with open(resultsPlace+"blockStats/blockStat"+str(passNum)+".dat", 'a') as f:
        blockStat.printResults(f)
    with open(resultsPlace+"blockStats/blockStat"+str(passNum)+".dat", 'r') as f:
        lines = f.readlines()
        for index in range(0, sysSize):
            words = lines[index].split()
            ovBlockHist[index] += float(words[1])
    os.remove(resultsPlace+"blockStats/blockStat"+str(passNum)+".dat")

# Now we put the overall histogram data for the entire run into files.
with open(resultsPlace+"ovNumHist.dat", 'w') as f:
    for index in range(0, sysSize):
        f.write(str(index)+" "+str(ovNumHist[index])+"\n")

with open(resultsPlace+"ovBlockHist.dat", 'w') as f:
    for index in range(0, sysSize):
        f.write(str(index)+" "+str(ovBlockHist[index])+"\n")

# Now delete the folder we used to perform our histogram calculations.
shutil.rmtree(resultsPlace+"blockStats", ignore_errors=True)
shutil.rmtree(resultsPlace+"numHists", ignore_errors=True)


print("Process would appear to have succesfully terminated! How very suspicious...")

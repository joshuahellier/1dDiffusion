""" Module for the process statistics analysis plugin """

"""Note that I've had to change this at top level; for some reason things wouldn't hook up properly, I'll work out why later. =S"""

# Copyright (c)  2014  Mikael Leetmaa
#
# This file is part of the KMCLib project distributed under the terms of the
# GNU General Public License version 3, see <http://www.gnu.org/licenses/>.
#


import sys
import numpy
import math

from KMCLib.PluginInterfaces.KMCAnalysisPlugin import KMCAnalysisPlugin
from KMCLib.Utilities.CheckUtilities import checkSequenceOfPositiveIntegers
from KMCLib.Utilities.CheckUtilities import checkPositiveFloat
from KMCLib.Utilities.CheckUtilities import checkPositiveInteger
from KMCLib.Exceptions.Error import Error
from KMCLib.Backend.Backend import MPICommons


class GdfStats(KMCAnalysisPlugin):
    """ Class for collecting block size statistics during a run."""


    def __init__(self,
                 blockComp=None):
        """
        Initialisation for GdfStats
        """
        # Check and set the input.
        if blockComp==None:
            sys.exit("Need to specify which types are to be counted as part of the block!")
        self.__blockComp = blockComp
    
    def setup(self, step, time, configuration):
        """
        Recieves the setup call.
        """
        # Set the initial time.
        self.__lastTime = time
        self.__initialTime = time
        # Allocate space
        typeList = configuration.types()
        self.__counter = 0
        self.__maxExp = int(math.floor(math.log(len(typeList)-4, 2)))
        self.__sums = []
        self.__squaredSums = []
        self.__centrePosition = int(len(typeList)/2)
        for i in range(0, self.__maxExp):
            self.__sums.append([])
            self.__squaredSums.append([])

    def registerStep(self, step, time, configuration):
        typeList = configuration.types()
        for i in range(0, self.__maxExp):
            numOcc = 0
            halfWidth = 2**i
            for j in range(self.__centrePosition-halfWidth, self.__centrePosition+halfWidth):
                if typeList[j] in self.__blockComp:
                    numOcc += 1
            self.__sums[i].append(numOcc)
        self.__counter += 1

    def finalize(self):
        self.__means = []
        self.__vars = []
        for i in range(0, self.__maxExp):
            mean = sum(self.__sums[i])/float(self.__counter)
            sqList = []
            for j in self.__sums[i]:
                sqList.append((float(j)-mean)*(float(j)-mean))
            var = math.fsum(sqList)/float(self.__counter-1)
            self.__means.append(mean)
            self.__vars.append(var)

    def printResults(self, stream=sys.stdout):
        """
        Print the results to the stream.

        :param stream: The stream to print to.
        """
        # Only master writes.
        if MPICommons.isMaster():
            for i in range(0, self.__maxExp):
                if self.__vars[i] < 0.0:
                    stdDev = 0.0
                else:
                    stdDev = math.sqrt(self.__vars[i])
                stream.write(str(2**(i+1))+" "+str(self.__means[i])+" "+str(stdDev)+"\n")

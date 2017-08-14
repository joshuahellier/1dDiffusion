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
from foldyFloatList import *


class BlockStats(KMCAnalysisPlugin):
    """ Class for collecting block size statistics during a run."""


    def __init__(self,
                 blockComp=None):
        """
        Initialisation for BlockStats
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
        # Allocate space for the spatially resolved information.
        typeList = configuration.types()
        self.__histogram = []
        for typeIndex in range(0, len(typeList)):
            self.__histogram.append([typeIndex, foldyFloatList()])

    def registerStep(self, step, time, configuration):
        typeList = configuration.types()
        timeInterval = time - self.__lastTime
        scanIndex = 0
        blockLength = 0
        inBlock = False
        while(scanIndex<len(typeList)):
            if inBlock==True:
                """ Continuing an existing block """
                if typeList[scanIndex] in self.__blockComp:
                    blockLength += 1
                else:
                    """ Finishing a block """
                    self.__histogram[blockLength][1].addValue(timeInterval)
                    inBlock = False
            else:
                if typeList[scanIndex] in self.__blockComp:
                    """ Start a new block """
                    inBlock = True
                    blockLength = 1
                """ Otherwise, just keep looking for block bits """
            scanIndex += 1
        self.__lastTime = time

    def finalize(self):
        totalTime = self.__lastTime - self.__initialTime
        self.__finalHistogram = []
        if totalTime<=0.0:
            sys.exit("Something has gone wrong with the elapsed time!")
        for item in self.__histogram:
            self.__finalHistogram.append([item[0], item[1].extractSum()/totalTime])

    def printResults(self, stream=sys.stdout):
        """
        Print the results to the stream.

        :param stream: The stream to print to.
        """
        # Only master writes.
        if MPICommons.isMaster():
            for item in self.__finalHistogram:
                stream.write(str(item[0])+" "+str(item[1])+"\n")


import sys
import numpy
import math

from KMCLib.PluginInterfaces.KMCAnalysisPlugin import KMCAnalysisPlugin
from KMCLib.Utilities.CheckUtilities import checkSequenceOfPositiveIntegers
from KMCLib.Utilities.CheckUtilities import checkPositiveFloat
from KMCLib.Utilities.CheckUtilities import checkPositiveInteger
from KMCLib.Exceptions.Error import Error
from KMCLib.Backend.Backend import MPICommons

class RateCalc(KMCAnalysisPlugin):
    
    def __init__(self, processes=None):
        msg = "The 'processes' parameter must be given as a list of process numbers."
        self.__processes = checkSequenceOfPositiveIntegers(processes, msg)
        self.__initTime = 0.0
        self.__lastTime = 0.0
        self.__currentTime = 0.0
        self.__current_count = 0

    def setup(self, step, time, configuration):
        self.__initTime = time

    def registerStep(self, step, time, configuration):
        if configuration.latestEventProcess() in self.__processes:
            self.__current_count += 1
        self.__currentTime = time

    def finalize(self):
        self.__lastTime = self.__currentTime

    def printResults(self, stream=sys.stdout):
        rateEst = float(self.__current_count)/(self.__lastTime - self.__initTime)
        if MPICommons.isMaster():
            stream.write("{:.6E}".format(rateEst)+"\n")

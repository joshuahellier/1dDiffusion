import sys
import numpy
import math
from foldyFloatList import foldyFloatList

class OOBError(Exception):
    def __init__(self, value):
        self.value = value
    def __str__(self):
        return repr(self.value)

from KMCLib.PluginInterfaces.KMCAnalysisPlugin import KMCAnalysisPlugin
from KMCLib.Utilities.CheckUtilities import checkSequenceOfPositiveIntegers
from KMCLib.Utilities.CheckUtilities import checkPositiveFloat
from KMCLib.Utilities.CheckUtilities import checkPositiveInteger
from KMCLib.Exceptions.Error import Error
from KMCLib.Backend.Backend import MPICommons

class LongDensHist(KMCAnalysisPlugin):
    
    def __init__(self, spec=None, inProc=None, outProc=None):
        self.__spec = spec
        msg = "The 'inProc' parameter must be given as a list of relevant input processes."
        self.__inProc = checkSequenceOfPositiveIntegers(inProc, msg)
        msg = "The 'outProc' parameter must be given as a list of relevant output processes."
        self.__outProc = checkSequenceOfPositiveIntegers(outProc, msg)
        self.__initTime = 0.0
        self.__lastTime = 0.0
        self.__currentTime = 0.0

    def setup(self, step, time, configuration):
        self.__initTime = time
        typeList = configuration.types()
        self.__histSize = len(typeList)
        self.__histogram = []
        for i in range(0, self.__histSize):
            self.__histogram.append(foldyFloatList())
        total = 0
        for i in typeList:
            if i in self.__spec:
                total += 1
        self.__currTot = total

    def registerStep(self, step, time, configuration):
        self.__currentTime = time
        if configuration.latestEventProcess() in self.__inProc:
            self.__currTot += 1
        if configuration.latestEventProcess() in self.__outProc:
            self.__currTot -= 1
        if self.__currTot < 0 or self.__currTot > self.__histSize:
            raise OOBError(0)
        self.__histogram[self.__currTot].addValue(self.__currentTime - self.__lastTime)
        self.__lastTime = time

    def finalize(self):
        self.__lastTime = self.__currentTime
        self.__finalHist = []
        totalWeight = foldyFloatList()
        for data in self.__histogram:
            temp = data.extractSum()
            totalWeight.addValue(temp)
            self.__finalHist.append(temp)
        ovTot = totalWeight.extractSum()
        for index in range(0, self.__histSize):
            self.__finalHist[index] = self.__finalHist[index]/ovTot

    def printResults(self, stream=sys.stdout):
        if MPICommons.isMaster():
            for index in range(0, self.__histSize):
                stream.write(str(index)+" "+"{:.6E}".format(self.__finalHist[index])+"\n")

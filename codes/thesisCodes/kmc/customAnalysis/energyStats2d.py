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

class energyStats2d(KMCAnalysisPlugin):
    
    def __init__(self, spec=None):
        self.__spec = spec
        self.__initTime = 0.0
        self.__lastTime = 0.0
        self.__currentTime = 0.0

    def setup(self, step, time, configuration):
        self.__initTime = time
        typeList = configuration.types()
        self.__histSize = 2*len(typeList)
        self.__histogram = []
        for i in range(0, self.__histSize):
            self.__histogram.append(foldyFloatList())
        ourLattice = configuration.lattice()
        ourReps = ourLattice.repetitions()
        self.__width = ourReps[0]
        self.__height = ourReps[1]
        total = 0
        for i in range(0, self.__width):
            for j in range(0, self.__height):
                if typeList[self.__height*i+j] in self.__spec:
                    leftI = (i-1+self.__width)%self.__width
                    rightI = (i+1+self.__width)%self.__width
                    upJ = (j+1+self.__height)%self.__height
                    downJ = (j-1+self.__height)%self.__height
                    if typeList[self.__height*leftI+j] in self.__spec:
                        total += 1
                    if typeList[self.__height*rightI+j] in self.__spec:
                        total += 1
                    if typeList[self.__height*i+upJ] in self.__spec:
                        total += 1
                    if typeList[self.__height*i+downJ] in self.__spec:
                        total += 1
        self.__currTot = total
        self.__lastTime = time
        self.__currentTime = time


    def registerStep(self, step, time, configuration):
        self.__currentTime = time
        typeList = configuration.types()
        total = 0
        for i in range(0, self.__width):
            for j in range(0, self.__height):
                if typeList[self.__height*i+j] in self.__spec:
                    leftI = (i-1+self.__width)%self.__width
                    rightI = (i+1+self.__width)%self.__width
                    upJ = (j+1+self.__height)%self.__height
                    downJ = (j-1+self.__height)%self.__height
                    if typeList[self.__height*leftI+j] in self.__spec:
                        total += 1
                    if typeList[self.__height*rightI+j] in self.__spec:
                        total += 1
                    if typeList[self.__height*i+upJ] in self.__spec:
                        total += 1
                    if typeList[self.__height*i+downJ] in self.__spec:
                        total += 1
        self.__currTot = total
#        if configuration.latestEventProcess() in self.__inProc:
#            self.__currTot += 1
#        if configuration.latestEventProcess() in self.__outProc:
#            self.__currTot -= 1
#        if self.__currTot < 0 or self.__currTot > self.__histSize:
#            raise OOBError(0)
#        print(str(self.__currentTime - self.__lastTime)+"\n")
        self.__histogram[self.__currTot/2].addValue(self.__currentTime - self.__lastTime)
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
            self.__finalHist[index] = self.__finalHist[index]/float(ovTot)

    def printResults(self, stream=sys.stdout):
        if MPICommons.isMaster():
            for index in range(0, self.__histSize):
                stream.write(str(index)+" "+"{:.6E}".format(self.__finalHist[index])+"\n")

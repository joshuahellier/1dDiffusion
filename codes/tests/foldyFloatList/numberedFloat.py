class numberedFloat:

    def __init__(self, x=0.0):
        self.__height = 0
        self.__value = x

    def getHeight(self):
        return self.__height

    def setHeight(self, x):
        self.__height = x

    def getValue(self):
        return self.__value

    def setValue(self, x):
        self.__value = x

    def toString(self):
        return "("+str(self.__height)+", "+str(self.__value)+")"

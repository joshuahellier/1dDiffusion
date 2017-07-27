import numberedFloat
import pyllist
nf = numberedFloat.numberedFloat
dllist = pyllist.dllist
class foldyFloatList:

    def __init__(self):
        self.__values = dllist()


    def addValue(self, x):
        self.__values.append(nf(x))
        self.attemptFold()

    def toString(self):
        outString = "["
        for x in self.__values:
            outString += x.toString()+" "
        outString += "\b]"
        return outString

    def extractSum(self):
        total = 0.0
        curVals = reversed(self.__values)
        for x in curVals:
            total += x.getValue()
        return total

    def attemptFold(self):
        it = self.__values.last
        if it==None:
            return
        front = self.__values.first
        previous = it
        while it != front:
            it = it.prev
            if it.value.getHeight()>previous.value.getHeight():
                break
            else:
                sum = it.value.getValue() + previous.value.getValue()
                self.__values.remove(previous)
                it.value.setValue(sum)
                it.value.setHeight(it.value.getHeight()+1)
                previous = it

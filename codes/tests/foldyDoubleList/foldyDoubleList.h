#ifndef FOLDYDOUBLELIST_H
#define FOLDYDOUBLELIST_H
#include <list>
#include "numberedDouble.h"

// foldyDoubleList is a list which slowly folds as it is added to, so that only values of the same rank (ie numbers of foldings) are added together.
// Thus, this class should be good at storing streams of data which need to be added in such a way that accuracy is not being lost due to huge size discrepancies,
// in a reasonably memory-efficient way.

using namespace std;

class foldyDoubleList
{
    public:
        // Constructor, which automatically puts zero as the first value. The list can then be built up by adding to it.
        foldyDoubleList();
        // Default destructor, which should get rid of everything safely when called.
        ~foldyDoubleList();
        // Access heights
        list<numberedDouble*>* getValues() { return values; }
        // Access values
        void addValue(double newValue);
        // Find the sum, at the end of a calculation.
        double extractSum();
        void printList();
    protected:
    private:
        list<numberedDouble*>* values;
        // Tries to fold the list some more, if it can. It does this by starting at the end of the list, comparing the heights of adjacent elements,
        // then working back along the list, combining elements of the same height until it can no longer do so.
        void attemptFold();
};

#endif // FOLDYDOUBLELIST_H

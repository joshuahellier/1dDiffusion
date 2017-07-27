#ifndef NUMBEREDDOUBLE_H
#define NUMBEREDDOUBLE_H

// A double and an unsigned int working together as a pair
class numberedDouble
{
    public:
        // Constructor automatically sets the height to zero.
        numberedDouble(double newValue);
        // Destructor
        ~numberedDouble();
        // Get height
        unsigned int getHeight() { return height; }
        // Set height
        void setHeight(unsigned int val) { height = val; }
        // Get value
        double getValue() { return value; }
        // Set value
        void setValue(double val) { value = val; }
    protected:
    private:
        unsigned int height; // 2^height is the number of doubles which have been summed to produce this one; thus, only doubles of the same height should really be added
        // until data have finished being collected, and then doubles of simillar heights should be added earliest
        double value; // The value of the double in question
};

#endif // NUMBEREDDOUBLE_H

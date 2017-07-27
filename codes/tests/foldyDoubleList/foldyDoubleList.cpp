#include "foldyDoubleList.h"
#include <iostream>

foldyDoubleList::foldyDoubleList()
{
    values = new list<numberedDouble*>;
    values->push_back(new numberedDouble(0.0));
}

foldyDoubleList::~foldyDoubleList()
{
    for(list<numberedDouble*>::iterator it = values->begin(); it!=values->end(); it++)
    {
        delete (*it);
    }
    delete values;
}

void foldyDoubleList::addValue(double newValue)
{
    values->push_back(new numberedDouble(newValue));
    attemptFold();
}

void foldyDoubleList::attemptFold()
{
    if(values->empty()) return;
    list<numberedDouble*>::iterator it = values->end();
    it--;
    numberedDouble* previous = (*it);
    numberedDouble* current;
    double sum;
    while(it!=values->begin())
    {
        it--;
        current = (*it);
        if(current->getHeight()>previous->getHeight()) break;
        else
        {
            sum = current->getValue() + previous->getValue();
            it++;
            delete (*it);
            it = values->erase(it);
            it--;
            current->setValue(sum);
            current->setHeight(current->getHeight()+1);
            previous = current;
        }
    }

}

void foldyDoubleList::printList()
{
    for(list<numberedDouble*>::iterator it = values->begin(); it!=values->end(); it++)
    {
        cout<< (*it)->getHeight() <<" "<< (*it)->getValue() <<"\n";
    }
}

double foldyDoubleList::extractSum()
{
    double total = 0.0;
    for(list<numberedDouble*>::reverse_iterator it = values->rbegin(); it!=values->rend(); it++)
    {
        total += (*it)->getValue();
    }
    return total;
}

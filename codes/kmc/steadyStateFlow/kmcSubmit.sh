#!/bin/bash
#
# Made with a little help from Pat
#
#$ -cwd -V
#$ -l h_rt=00:20:00
RESPLACE="/steadyStateFlow/blinkMethod/test3/"
mkdir -p $RESULTS$RESPLACE"1/errors"
#$ -e $RESULTS$RESPLACE"1/errors"
/usr/bin/python steadyStateFlow.py 0.9 0.1 0.5 60 1 1000000 100000 1000000 1000000 8 1.0 $RESPLACE"1"

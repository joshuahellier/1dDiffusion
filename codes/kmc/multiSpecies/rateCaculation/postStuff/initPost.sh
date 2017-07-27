#!/bin/sh
source ~/.bashrc
input=`cat $1`
module load anaconda
source activate joshPython
python $input

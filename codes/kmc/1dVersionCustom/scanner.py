import subprocess
import sys
import os

for i in range(-4, 4):
    jobInput = "python KMCLibRunManager.py "+str(2.0**i)
    print("\nrateConstFull = "+str(2.0**i)+"\n")
    p = subprocess.Popen(jobInput, shell=True)
    exitCodes = p.wait()

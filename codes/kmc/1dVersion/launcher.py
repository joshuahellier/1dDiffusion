import subprocess

# Rates.
rateConstEmpty        	= 1.0
rateConstFull           = 10.0
avConc			= 0.5
concDiff		= 0.1
topConc 		= avConc + 0.5*concDiff
bottConc		= avConc - 0.5*concDiff

status = subprocess.call("python diff1D.py", shell=True)

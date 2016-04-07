from KMCLib import *
import numpy

# We're in 1d, so everything's a bit trivial
cell_vectors = [[1.0,0.0,0.0],
                [0.0,1.0,0.0],
                [0.0,0.0,1.0]]

# Only bothering with one set
basis_points = [[0.0, 0.0, 0.0]]

unit_cell = KMCUnitCell(cell_vectors=cell_vectors,
                        basis_points=basis_points)

# Define the lattice.
xRep = 1
yRep = 1
zRep = 20
numPoints = xRep*(zRep+4)*yRep
lattice = KMCLattice(unit_cell=unit_cell,
                     repetitions=(xRep,yRep,zRep+4),
                     periodic=(False, False, True))

# Generate the initial types. There's double-layered
types = ["V"]*numPoints
types[0] = "Bo"
types[1] = "Bo"
types[-2] = "To"
types[-1] = "To"
for i in range(zRep/2):
    # find a site which is not yet occupied by a "D" type.
    pos = int(numpy.random.rand()*zRep+2.0)
    while (types[pos] != "V"):
        pos = int(numpy.random.rand()*zRep+2.0)
    # Set the type.
    types[pos] = "O"

# Setup the configuration.
configuration = KMCConfiguration(lattice=lattice,
                                 types=types,
                                 possible_types=["O","V","To","Bo"])

# Use the _script() function to get a script that can generate the configuration.
print "from KMCLib import *"
print configuration._script()

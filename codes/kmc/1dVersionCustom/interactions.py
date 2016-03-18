from KMCLib import *
import launcher.py

# Only on the first set of basis_points for O/V
basis_sites     = [0]




# Fill the list of processes.
processes = []

# Bulk processes
# Up, empty.
elements_before = ["V", "O", "V"]
elements_after  = ["V", "V", "O"]
coordinates = [[0.0, 0.0, -1.0], [0.0, 0.0,  0.0], [0.0, 0.0, 1.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=rateConstEmpty))

# Down, empty.
elements_before = ["V", "O", "V"]
elements_after  = ["O", "V", "V"]
coordinates = [[0.0, 0.0, -1.0], [0.0, 0.0, 0.0], [0.0, 0.0, 1.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=rateConstEmpty))

# Up, full.
elements_before = ["O", "O", "V"]
elements_after  = ["O", "V", "O"]
coordinates = [[0.0, 0.0, -1.0], [0.0, 0.0, 0.0], [0.0, 0.0, 1.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=rateConstFull))

# Down, full.
elements_before = ["V", "O", "O"]
elements_after  = ["O", "V", "O"]
coordinates = [[0.0, 0.0, -1.0], [0.0, 0.0, 0.0], [0.0, 0.0, 1.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=rateConstFull))

# Special annoying corner cases for boundaries

# Up, bottom.
elements_before = ["Bo", "O", "V"]
elements_after  = ["Bo", "V", "O"]
coordinates = [[0.0, 0.0, -1.0], [0.0, 0.0, 0.0], [0.0, 0.0, 1.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=(bottConc*rateConstFull+(1.0-bottConc)*rateConstEmpty)))

# Down, top.
elements_before = ["V", "O", "To"]
elements_after  = ["O", "V", "To"]
coordinates = [[0.0, 0.0, -1.0], [0.0, 0.0, 0.0], [0.0, 0.0, 1.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=(topConc*rateConstFull + (1.0-topConc)*rateConstEmpty)))

# Now for empty Oxygen annihilation at the top boundary
elements_before = ["V", "O", "To"]
elements_after  = ["V", "V", "To"]
coordinates = [[0.0, 0.0, -1.0], [0.0, 0.0, 0.0], [0.0, 0.0, 1.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=(1.0-topConc)*rateConstEmpty))

# Full Oxygen annihilation at the top boundary
elements_before = ["O", "O", "To"]
elements_after  = ["O", "V", "To"]
coordinates = [[0.0, 0.0, -1.0], [0.0, 0.0, 0.0], [0.0, 0.0, 1.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=(1.0-topConc)*rateConstFull))

# Oxygen creation at the top boundary
elements_before = ["O", "To"]
elements_after  = ["V", "To"]
coordinates = [[0.0, 0.0, 0.0], [0.0, 0.0, 1.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=topConc*(topConc*rateConstFull+(1.0-topConc)*rateConstEmpty)))

# Now for empty Oxygen annihilation at the bottom boundary
# Bottom
elements_before = ["Bo", "O", "V"]
elements_after  = ["Bo", "V", "V"]
coordinates = [[0.0, 0.0, -1.0], [0.0, 0.0, 0.0], [0.0, 0.0, 1.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=(1.0-bottConc)*rateConstEmpty))

# Now for full Oxygen annihilation at the bottom boundary
# Bottom
elements_before = ["Bo", "O", "O"]
elements_after  = ["Bo", "V", "O"]
coordinates = [[0.0, 0.0, -1.0], [0.0, 0.0, 0.0], [0.0, 0.0, 1.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=(1.0-bottConc)*rateConstFull))

# Oxygen creation at the bottom boundary
# Bottom
elements_before = ["Bo", "V"]
elements_after  = ["Bo", "O"]
coordinates = [[0.0, 0.0, 0.0], [0.0, 0.0, 1.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=(rateConstFull*bottConc+(1.0-bottConc)*rateConstEmpty)))

# Create the interactions object.
interactions = KMCInteractions(processes,
                               implicit_wildcards=True)

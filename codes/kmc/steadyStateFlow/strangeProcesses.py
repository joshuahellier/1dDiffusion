I have all the processes explicitly spelled out here; however, for some weird reason this does not work
properly with KMCLib (as in, the processes involving the Bo atoms never seem to fire); hence I have switched
back to using custom rates.

# Bulk processes

# Up, empty.
#0
elements_before = ["O", "V", "V"]
elements_after  = ["V", "O", "V"]
coordinates = [[0.0, 0.0,  0.0], [0.0, 0.0, 1.0], [0.0, 0.0, -1.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=rateConstEmpty))
# Up, full.
#1
elements_before = ["O", "V", "O"]
elements_after  = ["V", "O", "O"]
coordinates = [[0.0, 0.0,  0.0], [0.0, 0.0, 1.0], [0.0, 0.0, -1.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=rateConstFull))

# Down, empty.
#2
elements_before = ["O", "V", "V"]
elements_after  = ["V", "O", "V"]
coordinates = [[0.0, 0.0, 0.0], [0.0, 0.0, -1.0], [0.0, 0.0, 1.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=rateConstEmpty))

# Down, full.
#3
elements_before = ["O", "V", "O"]
elements_after  = ["V", "O", "O"]
coordinates = [[0.0, 0.0, 0.0], [0.0, 0.0, -1.0], [0.0, 0.0, 1.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=rateConstFull))


# Now for Oxygen annihilation at the top boundary (when empty)
#4
elements_before = ["O", "To", "V"]
elements_after  = ["V", "To", "V"]
coordinates = [[0.0, 0.0, 0.0], [0.0, 0.0, 1.0], [0.0, 0.0, -1.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=rateConstEmpty*(1.0-topConc)))

# Now for Oxygen annihilation at the top boundary (when full)
#5
elements_before = ["O", "To", "O"]
elements_after  = ["V", "To", "O"]
coordinates = [[0.0, 0.0, 0.0], [0.0, 0.0, 1.0], [0.0, 0.0, -1.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=rateConstFull*(1.0-topConc)))


# Oxygen creation at the top boundary
#6
elements_before = ["V", "To"]
elements_after  = ["O", "To"]
coordinates = [[0.0, 0.0, 0.0], [0.0, 0.0, 1.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=topConc*(topConc*rateConstFull+(1.0-topConc)*rateConstEmpty)))

# Now for Oxygen annihilation at the bottom boundary, empty.
# Bottom
#7
elements_before = ["Bo", "O", "V"]
elements_after  = ["Bo", "V", "V"]
coordinates = [[0.0, 0.0, 0.0], [0.0, 0.0, 1.0], [0.0, 0.0, 2.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=rateConstEmpty*(1.0-botConc)))

# Now for Oxygen annihilation at the bottom boundary, full.
# Bottom
#8
elements_before = ["Bo", "O", "O"]
elements_after  = ["Bo", "V", "O"]
coordinates = [[0.0, 0.0, 0.0], [0.0, 0.0, 1.0], [0.0, 0.0, 2.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=rateConstFull*(1.0-botConc)))


# Oxygen creation at the bottom boundary
# Bottom
#9
elements_before = ["Bo", "V"]
elements_after  = ["Bo", "O"]
coordinates = [[0.0, 0.0, 0.0], [0.0, 0.0, 1.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=botConc*(rateConstFull*botConc+(1.0-botConc)*rateConstEmpty)))

# Special annoying corner cases for boundaries

# Up, bottom.
#10
elements_before = ["Bo", "O", "V"]
elements_after  = ["Bo", "V", "O"]
coordinates = [[0.0, 0.0, -1.0], [0.0, 0.0, 0.0], [0.0, 0.0, 1.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=(botConc*rateConstFull+(1.0-botConc)*rateConstEmpty)))

# Down, top.
#11
elements_before = ["V", "O", "To"]
elements_after  = ["O", "V", "To"]
coordinates = [[0.0, 0.0, -1.0], [0.0, 0.0, 0.0], [0.0, 0.0, 1.0]]
processes.append( KMCProcess(coordinates=coordinates,
                             elements_before=elements_before,
                             elements_after=elements_after,
                             basis_sites=basis_sites,
                             rate_constant=(topConc*rateConstFull + (1.0-topConc)*rateConstEmpty)))


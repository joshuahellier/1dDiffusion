# -----------------------------------------------------------------------------
# KMCLib version 2.0.a0-devel
# **WARNING** This is a potentially broken development version of KMCLib.
# Distributed under the GPLv3 license
# Copyright (C)  2012-2015  Mikael Leetmaa
# Developed by Mikael Leetmaa <leetmaa@kth.se>
#
# This program is distributed in the hope that it will be useful
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# LICENSE and README files, and the source code, for details.
#
# You should have received a copy of the GNU General Public License version 3
# (GPLv3) along with this program. If not, see <http://www.gnu.org/licenses/>.
# -----------------------------------------------------------------------------

from KMCLib import *

# -----------------------------------------------------------------------------
# Unit cell

cell_vectors = [[   1.000000e+00,   0.000000e+00,   0.000000e+00],
                [   0.000000e+00,   1.000000e+00,   0.000000e+00],
                [   0.000000e+00,   0.000000e+00,   1.000000e+00]]

basis_points = [[   0.000000e+00,   0.000000e+00,   0.000000e+00]]

unit_cell = KMCUnitCell(
    cell_vectors=cell_vectors,
    basis_points=basis_points)

# -----------------------------------------------------------------------------
# Lattice

lattice = KMCLattice(
    unit_cell=unit_cell,
    repetitions=(1,1,24),
    periodic=(False, False, True))

# -----------------------------------------------------------------------------
# Configuration

types = ['Bo','Bo','V','V','V','V','V','V','V','V','V','V',
         'V','V','V','V','V','V','V','V','V','V','To','To']

possible_types = ['To','Bo','O','V']

configuration = KMCConfiguration(
    lattice=lattice,
    types=types,
    possible_types=possible_types)


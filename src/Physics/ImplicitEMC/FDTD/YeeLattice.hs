module Physics.ImplicitEMC.FDTD.YeeLattice (
        YeeLattice(..))
where

import qualified Physics.ImplicitEMC.Utils.Trivia       as Utils
import qualified Physics.ImplicitEMC.DiscreteSequence   as EMC
import qualified Physics.ImplicitEMC.RectangularLattice as EMC

-- Everybody likes operators!
import Physics.ImplicitEMC.Utils.Trivia (($$))
import Physics.ImplicitEMC.Utils.Trivia ((-->))

data YeeLattice = YeeLattice {
        latticeTE :: EMC.RectangularLattice,
        latticeTM :: EMC.RectangularLattice }

seq0 = EMC.iterateSequence
seq1 = tail . EMC.iterateSequence

yeeExPoints :: YeeLattice -> [(Float, Float, Float)]
yeeExPoints yee = Utils.sequence3 $$ EMC.sequenceX (latticeTM yee) --> seq0
                                  $$ EMC.sequenceY (latticeTE yee) --> seq0
                                  $$ EMC.sequenceZ (latticeTE yee) --> seq0

yeeEyPoints :: YeeLattice -> [(Float, Float, Float)]
yeeEyPoints yee = Utils.sequence3 $$ EMC.sequenceX (latticeTE yee) --> seq1
                                  $$ EMC.sequenceY (latticeTM yee) --> seq0
                                  $$ EMC.sequenceZ (latticeTE yee) --> seq0

yeeEzPoints :: YeeLattice -> [(Float, Float, Float)]
yeeEzPoints yee = Utils.sequence3 $$ EMC.sequenceX (latticeTE yee) --> seq0
                                  $$ EMC.sequenceY (latticeTE yee) --> seq0
                                  $$ EMC.sequenceZ (latticeTM yee) --> seq0

yeeHxPoints :: YeeLattice -> [(Float, Float, Float)]
yeeHxPoints yee = Utils.sequence3 $$ EMC.sequenceX (latticeTE yee) --> seq1
                                  $$ EMC.sequenceY (latticeTM yee) --> seq0
                                  $$ EMC.sequenceZ (latticeTM yee) --> seq0

yeeHyPoints :: YeeLattice -> [(Float, Float, Float)]
yeeHyPoints yee = Utils.sequence3 $$ EMC.sequenceX (latticeTM yee) --> seq0
                                  $$ EMC.sequenceY (latticeTE yee) --> seq0
                                  $$ EMC.sequenceZ (latticeTM yee) --> seq0

yeeHzPoints :: YeeLattice -> [(Float, Float, Float)]
yeeHzPoints yee = Utils.sequence3 $$ EMC.sequenceX (latticeTM yee) --> seq0
                                  $$ EMC.sequenceY (latticeTM yee) --> seq0
                                  $$ EMC.sequenceZ (latticeTE yee) --> seq1

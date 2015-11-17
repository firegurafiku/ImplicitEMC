module Physics.ImplicitEMC.RectangularLattice (
        RectangularLattice(..),
        iterateLattice
) where

import qualified Physics.ImplicitEMC.Utils.Trivia     as Utils 
import qualified Physics.ImplicitEMC.DiscreteSequence as DQ

data RectangularLattice = RectangularLattice {
        sequenceX :: DQ.DiscreteSequence,
        sequenceY :: DQ.DiscreteSequence,
        sequenceZ :: DQ.DiscreteSequence }

iterateLattice :: RectangularLattice -> [(Float, Float, Float)]
iterateLattice lattice = Utils.sequence3
        (DQ.iterateSequence $ sequenceX lattice)
        (DQ.iterateSequence $ sequenceY lattice)
        (DQ.iterateSequence $ sequenceZ lattice)

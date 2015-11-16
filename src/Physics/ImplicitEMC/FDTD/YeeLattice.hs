module Physics.ImplicitEMC.FDTD.YeeLattice (YeeLattice) where

import qualified Physics.ImplicitEMC.DiscreteSequence as DQ

data YeeLattice = YeeLattice {
    gridEx :: DQ.DiscreteSequence,
    gridEy :: DQ.DiscreteSequence,
    gridEz :: DQ.DiscreteSequence, 
    gridHx :: DQ.DiscreteSequence,
    gridHy :: DQ.DiscreteSequence,
    gridHz :: DQ.DiscreteSequence }

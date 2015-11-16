module Physics.ImplicitEMC.FDTD.Parameters where

import qualified Physics.ImplicitEMC.DiscreteSequence as DQ
import qualified Physics.ImplicitEMC.FDTD.YeeLattice  as YL

data Parameters = Parameters {
    lattice            :: YL.YeeLattice,
    moments            :: DQ.DiscreteSequence,
    excitationSignals  :: [Int],
    boundaryConditions :: [Int],
    tfsfRegion         :: Maybe Int,
    ffTransformRegion  :: Maybe Int,
    localProbes        :: [Int],
    farFieldProbes     :: [Int]
}

checkCourantCondition :: YL.YeeLattice -> DQ.DiscreteSequence -> Bool
checkCourantCondition lattice moments = False

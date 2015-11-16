module Physics.ImplicitEMC.FDTD.Parameters where

import qualified Physics.ImplicitEMC.DiscreteSequence as DQ
import qualified Physics.ImplicitEMC.DiscreteSignal   as DS
import qualified Physics.ImplicitEMC.FDTD.YeeLattice  as YL
import qualified Graphics.Implicit.Definitions        as ID

data Parameters = Parameters {
        lattice            :: YL.YeeLattice,
        moments            :: DQ.DiscreteSequence,
        excitationSignals  :: [DS.DiscreteSignal],
        boundaryConditions :: [BoundaryCondition],
        tfsfRegion         :: Maybe ID.Box3,
        fftRegion          :: Maybe ID.Box3,
        localProbes        :: [LocalProbe],
        farFieldProbes     :: [FarFieldProbe]
}

data BoundaryCondition = BoundaryCondition

data LocalProbe = LocalProbe

data FarFieldProbe = FarFieldProbe

checkCourantCondition :: YL.YeeLattice -> DQ.DiscreteSequence -> Bool
checkCourantCondition lattice moments = error "Not implemented"

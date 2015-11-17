import Physics.ImplicitEMC.Utils.Trivia    (($$))

import qualified Physics.ImplicitEMC.DiscreteSequence as DQ
import qualified Physics.ImplicitEMC.MaterialScene    as MS
import qualified Physics.ImplicitEMC.MathUtils       as MA
import qualified Physics.ImplicitEMC.NetCDF          as NF
import qualified Physics.ImplicitEMC.RectangularLattice as EMC
import qualified Physics.ImplicitEMC.FDTD.YeeLattice as FDTD
import qualified Physics.ImplicitEMC.FDTD.Parameters as FDTD
import qualified Physics.ImplicitEMC.FDTD.Render     as FDTD
import qualified Physics.ImplicitEMC.FDTD.ExportNetCDF as FDTD

yeeLattice = FDTD.YeeLattice {
        FDTD.latticeTE = EMC.RectangularLattice {
                EMC.sequenceX = DQ.regularSequence (0, 1) 100,
                EMC.sequenceY = DQ.regularSequence (0, 1) 100,
                EMC.sequenceZ = DQ.regularSequence (0, 1) 100 },
        FDTD.latticeTM = EMC.RectangularLattice {
                EMC.sequenceX = DQ.regularSequence (0, 1) 100,
                EMC.sequenceY = DQ.regularSequence (0, 1) 100,
                EMC.sequenceZ = DQ.regularSequence (0, 1) 100 }
}

parameters = FDTD.Parameters {
        FDTD.lattice            = yeeLattice,
        FDTD.moments            = DQ.regularSequence (0, 1) 20,
        FDTD.excitationSignals  = [],
        FDTD.boundaryConditions = [],
        FDTD.tfsfRegion         = Nothing,
        FDTD.fftRegion          = Nothing,
        FDTD.localProbes        = [],
        FDTD.farFieldProbes     = []
}

materialScene = MS.MaterialScene {
        MS.objects2D = [],
        MS.objects3D = [],
        MS.backgroundMaterial = const MS.vacuum
}

main = FDTD.writeNetCDF "test2.ncdf" parameters renderedData
       where renderedData = FDTD.renderScene parameters materialScene

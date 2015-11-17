module Physics.ImplicitEMC.FDTD.Render where

import qualified Physics.ImplicitEMC.FDTD.Parameters as FP
import qualified Physics.ImplicitEMC.MaterialScene   as MS
import qualified Numeric.LinearAlgebra               as LA

type SlicedMatrix3D = [Float]

data RenderedData = RenderedData {
        gridExEpsilon :: Maybe SlicedMatrix3D,
        gridEyEpsilon :: Maybe SlicedMatrix3D,
        gridEzEpsilon :: Maybe SlicedMatrix3D,
        gridHxMu      :: Maybe SlicedMatrix3D,
        gridHyMu      :: Maybe SlicedMatrix3D,
        gridHzMu      :: Maybe SlicedMatrix3D,
        gridExSigmaE  :: Maybe SlicedMatrix3D,
        gridEySigmaE  :: Maybe SlicedMatrix3D,
        gridEzSigmaE  :: Maybe SlicedMatrix3D,
        gridHxSigmaH  :: Maybe SlicedMatrix3D,
        gridHySigmaH  :: Maybe SlicedMatrix3D,
        gridHzSigmaH  :: Maybe SlicedMatrix3D
}

renderScene :: FP.Parameters -> MS.MaterialScene -> RenderedData
renderScene parameters scene = error "Not implemented"

{--
        gridExEpsilon = epsEx,
        gridEyEpsilon = epsEy,
        gridEzEpsilon = epsEz,
        gridHxMu      = muHx,
        gridHyMu      = muHy,
        gridHzMu      = muHz,
        gridExSigmaE  = sigmaEx,
        gridEySigmaE  = sigmaEy,
        gridEzSigmaE  = sigmaEz,
        gridHxSigmaH  = sigmaHx,
        gridHySigmaH  = sigmaHy,
        gridHzSigmaH  = sigmaHz }
        where (epsEx, epsEy, epsEz, sigmaEx, sigmaEy, sigmaEz) = renderYeeE latticeE scene
              (epsEx, sigmaEx) = renderYeeH latticeH scene

              latticeE = FDTD.latticeE $ FDTD.lattice parameters
              latticeH = FDTD.latticeH $ FDTD.lattice parameters
--}

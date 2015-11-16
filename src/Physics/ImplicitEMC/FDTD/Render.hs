module Physics.ImplicitEMC.FDTD.Render where

import qualified Physics.ImplicitEMC.FDTD.Parameters as FP
import qualified Physics.ImplicitEMC.MaterialScene   as MS
import qualified Numeric.LinearAlgebra               as LA

type SlicedMatrix3D = [LA.Matrix Float]

data RenderedData = RenderedData {
        gridExEpsilon :: Maybe SlicedMatrix3D,
        gridEyEpsilon :: Maybe SlicedMatrix3D,
        gridEzEpsilon :: Maybe SlicedMatrix3D,
        gridHxEpsilon :: Maybe SlicedMatrix3D,
        gridHyEpsilon :: Maybe SlicedMatrix3D,
        gridHzEpsilon :: Maybe SlicedMatrix3D,
        gridExMu      :: Maybe SlicedMatrix3D,
        gridEyMu      :: Maybe SlicedMatrix3D,
        gridEzMu      :: Maybe SlicedMatrix3D,
        gridHxMu      :: Maybe SlicedMatrix3D,
        gridHyMu      :: Maybe SlicedMatrix3D,
        gridHzMu      :: Maybe SlicedMatrix3D,
        gridExSigmaE  :: Maybe SlicedMatrix3D,
        gridEySigmaE  :: Maybe SlicedMatrix3D,
        gridEzSigmaE  :: Maybe SlicedMatrix3D,
        gridHxSigmaE  :: Maybe SlicedMatrix3D,
        gridHySigmaE  :: Maybe SlicedMatrix3D,
        gridHzSigmaE  :: Maybe SlicedMatrix3D,
        gridExSigmaH  :: Maybe SlicedMatrix3D,
        gridEySigmaH  :: Maybe SlicedMatrix3D,
        gridEzSigmaH  :: Maybe SlicedMatrix3D,
        gridHxSigmaH  :: Maybe SlicedMatrix3D,
        gridHySigmaH  :: Maybe SlicedMatrix3D,
        gridHzSigmaH  :: Maybe SlicedMatrix3D
}

renderNetCDF :: FP.Parameters -> MS.MaterialScene -> RenderedData
renderNetCDF parameters scene = error "Not implemented"


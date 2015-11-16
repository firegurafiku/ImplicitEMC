module Physics.ImplicitEMC.MaterialScene (
        Material(..),
        MaterialScene(..),
        vacuum
) where

import qualified Graphics.Implicit.Definitions as ID

type MaterialFunc = (Float, Float, Float) -> Material

data Material = Material {
        epsilon :: Float,
        mu      :: Float,
        sigmaE  :: Float,
        sigmaH  :: Float }

vacuum :: Material
vacuum = Material {
        epsilon = 1.0,
        mu      = 1.0,
        sigmaE  = 0.0,
        sigmaH  = 0.0 }

data MaterialScene = MaterialScene {
        objects2D          :: [(ID.SymbolicObj2, MaterialFunc)],
        objects3D          :: [(ID.SymbolicObj3, MaterialFunc)],
        backgroundMaterial :: MaterialFunc }

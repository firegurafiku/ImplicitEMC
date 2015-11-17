module Physics.ImplicitEMC.FDTD.ExportNetCDF where

import qualified Physics.ImplicitEMC.NetCDF          as NF
import qualified Physics.ImplicitEMC.FDTD.Parameters as FDTD
import qualified Physics.ImplicitEMC.FDTD.Render     as FDTD
import Data.Either
import Data.Maybe
import Data.Monoid
import Control.Monad

gridVariables :: [(FDTD.RenderedData -> Maybe [Float], String, Int)]
gridVariables = [
            (FDTD.gridExEpsilon,  "gridExEpsilon", 1),
            (FDTD.gridEyEpsilon,  "gridEyEpsilon", 2),
            (FDTD.gridEzEpsilon,  "gridEzEpsilon", 3),
            (FDTD.gridHxMu,       "gridHxMu",     10),
            (FDTD.gridHyMu,       "gridHyMu",     11),
            (FDTD.gridHzMu,       "gridHzMu",     12),
            (FDTD.gridExSigmaE,   "gridExSigmaE", 13),
            (FDTD.gridEySigmaE,   "gridEySigmaE", 14),
            (FDTD.gridEzSigmaE,   "gridEzSigmaE", 15),
            (FDTD.gridHxSigmaH,   "gridHxSigmaH", 22),
            (FDTD.gridHySigmaH,   "gridHySigmaH", 23),
            (FDTD.gridHzSigmaH,   "gridHzSigmaH", 24)]

writeNetCDF :: FilePath -> FDTD.Parameters -> FDTD.RenderedData -> IO ()
writeNetCDF filename params render = do
        let dimX = NF.BoundedDimention "nx" 1000
            dimY = NF.BoundedDimention "ny" 1000
            dimZ = NF.BoundedDimention "nz" 100
            dims = [dimX, dimY, dimZ]
            vars = [NF.Variable n i NF.Float dims | (f, n, i) <- gridVariables, isJust(f render)]
            var2 = NF.Variable "test2" 3 NF.Float [dimX, dimY, dimZ]
        let info = NF.Info
                       (NF.FileInfo filename 1)
                       (NF.Dimentions dims)
                       (NF.Variables  vars)

        status <- NF.withCreateFile info $ \fileHandle -> do
            putStrLn "HERE"

            let mkVar name id = NF.Variable name id NF.Float dims
            let list = map (\(vals, name, id) -> (mkVar name id, vals))
                     $ mapMaybe (\(f, name, id) -> (\j -> (j, name, id)) `fmap` (f render))
                     $ gridVariables

            status <- forM_ list $ \(var, vals) -> do
                          NF.putFloats fileHandle var vals 

            return $ Right () -- FIXME!

        case status of
            Left _   -> putStrLn "FAIL"
            Right () -> putStrLn "OKAY"

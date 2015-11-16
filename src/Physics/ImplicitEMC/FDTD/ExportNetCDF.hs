module Physics.ImplicitEMC.FDTD.ExportNetCDF where

import qualified Data.Map as M
import qualified Data.NetCDF as NC
import qualified Physics.ImplicitEMC.NetCDF          as NF
import qualified Physics.ImplicitEMC.FDTD.Parameters as FDTD
import qualified Physics.ImplicitEMC.FDTD.Render     as FDTD

writeNetCDF :: FilePath -> FDTD.Parameters -> FDTD.RenderedData -> IO ()
writeNetCDF filename parameters renderedData = do
        let ncInfo = getInfo(filename)

        Right nc <- NC.createFile ncInfo
        putStrLn "HERE"

getInfo :: FilePath -> NC.NcInfo a
getInfo filename = NF.makeNcInfo $
        NF.Info
            (NF.FileInfo filename 1)
            (NF.Dimentions [dimX, dimY, dimZ])
            (NF.Variables  [])
        where dimX = NF.BoundedDimention "nx" 100
              dimY = NF.BoundedDimention "nx" 100 
              dimZ = NF.BoundedDimention "nx" 100


{--
getDims :: FDTD.YeeLattice -> NC.NcDims

getVars :: NC.NcVar
getVars parameters renderedData =
        let dims = getDims $ FDTD.lattice parameters
            empty = M.fromList [] :: (M.Map NC.Name NC.NcVar)
            variable name varId = (name, NC.NcVar name NC.NcFloat dims empty)
            
        in M.fromList $ map (\(f, n, i) -> getVar n i) $ filter (\(f, n, i) -> isJust (f parameters))
            (gridExEpsilon,  "gridExEpsilon", 1),
            (gridEyEpsilon,  "gridEyEpsilon", 2),
            (gridEzEpsilon,  "gridEzEpsilon", 3),
            (gridHxEpsilon,  "gridHxEpsilon", 4),
            (gridHyEpsilon,  "gridHyEpsilon", 5),
            (gridHzEpsilon,  "gridHzEpsilon", 6),
            (gridExMu,       "gridExMu",      7),
            (gridEyMu,       "gridEyMu",      8),
            (gridEzMu,       "gridEzMu",      9),
            (gridHxMu,       "gridHxMu",     10),
            (gridHyMu,       "gridHyMu",     11),
            (gridHzMu,       "gridHzMu",     12),
            (gridExSigmaE,   "gridExSigmaE", 13),
            (gridEySigmaE,   "gridEySigmaE", 14),
            (gridEzSigmaE,   "gridEzSigmaE", 15),
            (gridHxSigmaE,   "gridHxSigmaE", 16),
            (gridHySigmaE,   "gridHySigmaE", 17),
            (gridHzSigmaE,   "gridHzSigmaE", 18),
            (gridExSigmaH,   "gridExSigmaH", 19),
            (gridEySigmaH,   "gridEySigmaH", 20),
            (gridEzSigmaH,   "gridEzSigmaH", 21),
            (gridHxSigmaH,   "gridHxSigmaH", 22),
            (gridHySigmaH,   "gridHySigmaH", 23),
            (gridHzSigmaH,   "gridHzSigmaH", 24)]
--}

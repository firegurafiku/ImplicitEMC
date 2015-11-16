import Data.NetCDF as NC
import qualified Data.NetCDF.HMatrix as NC
import qualified Physics.ImplicitEMC.MathUtils as MA
import qualified Physics.ImplicitEMC.NetCDF as NF
import qualified Numeric.LinearAlgebra      as LA

($$) :: (a -> b) -> a -> b
($$) = ($)

infixl 0 $$ -- left associative

writeNetCDF :: FilePath -> IO ()
writeNetCDF filename = do
        let dimX = NF.BoundedDimention "nx" 100
            dimY = NF.BoundedDimention "ny" 100
            dimZ = NF.BoundedDimention "nz" 100
            var1 = NF.Variable "test1" 2 NF.Float [dimX, dimY, dimZ]
            var2 = NF.Variable "test2" 3 NF.Float [dimX, dimY, dimZ]
        let info = NF.Info
                       $$ NF.FileInfo filename 1
                       $$ NF.Dimentions [dimX, dimY, dimZ]
                       $$ NF.Variables  [var1, var2]

        status <- NF.withCreateFile info $ \fileHandle -> do
            putStrLn "HERE"
            NF.putFloats fileHandle var1 (map MA.itof [1..1000000])
            NF.putFloats fileHandle var2 (map (MA.itof . (*2)) [1..1000000])

        case status of
            Left _   -> putStrLn "FAIL"
            Right () -> putStrLn "OKAY"

main = writeNetCDF "test1.ncdf"

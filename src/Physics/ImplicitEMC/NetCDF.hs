module Physics.ImplicitEMC.NetCDF where

import qualified Data.Map    as M
import qualified Data.NetCDF as NC
import qualified Data.NetCDF.HMatrix as NC
import qualified Data.NetCDF.Utils as NC
import qualified Numeric.LinearAlgebra      as LA
import Foreign.C
import qualified Data.Vector.Storable as SV

import Data.NetCDF.Storable
import Control.Exception (bracket)

data Info = Info FileInfo Dimentions Variables

data FileInfo = FileInfo String Int

data Dimentions = Dimentions [Dimention]

data Variables = Variables [Variable]

data Dimention = BoundedDimention String Int | UnboundedDimention String

data Variable = Variable String Int DataType [Dimention]

type Handle = NC.NcInfo NC.NcWrite

data DataType = Float | Double | Int

getOldType typ = case typ of
        Float  -> NC.NcFloat
        Double -> NC.NcDouble
        Int    -> NC.NcInt

type Try a = Either a ()

type Error = NC.NcError

withCreateFile :: Info -> (Handle -> IO (Try Error)) -> IO (Try Error)
withCreateFile info action = bracket
                             (NC.createFile $ makeNcInfo info)
                             (either (return . Left) close)
                             (either (return . Left) action)
        where close :: Handle -> IO (Try Error)
              close handle = do
                  NC.closeFile(handle)
                  return $ Right ()

putFloats :: Handle -> Variable -> [Float] -> IO (Try Error)
putFloats handle var xs = NC.put handle var' (NC.HVector vector)
        where vector = LA.fromList $ map convert xs
              convert :: Float -> CFloat
              convert x = realToFrac x
              var' = snd $ mkVariablePair var

makeNcInfo :: Info -> NC.NcInfo a
makeNcInfo info =
        NC.NcInfo {
            NC.ncName   = filename,
            NC.ncDims   = dimsMap,
            NC.ncVars   = varsMap,
            NC.ncAttrs  = M.fromList [],
            NC.ncId     = fileId,
            NC.ncVarIds = varIdsMap }
        where Info (FileInfo filename fileId) (Dimentions dims) (Variables vars) = info
              dimsMap   = M.fromList $ map mkDimentionPair  dims
              varsMap   = M.fromList $ map mkVariablePair   vars
              varIdsMap = M.fromList $ map mkVariableIdPair vars

mkDimentionPair :: Dimention -> (String, NC.NcDim)
mkDimentionPair dim = case dim of
        BoundedDimention name size -> (name, NC.NcDim name size False)
        UnboundedDimention name    -> (name, NC.NcDim name    0 True)

mkVariablePair :: Variable -> (String, NC.NcVar)
mkVariablePair var = (name, NC.NcVar name (getOldType varType) dimsMap (M.fromList []))
        where Variable name _ varType dims = var
              dimsMap = map (snd . mkDimentionPair) dims

mkVariableIdPair var = (name, id)
        where Variable name id _ _ = var

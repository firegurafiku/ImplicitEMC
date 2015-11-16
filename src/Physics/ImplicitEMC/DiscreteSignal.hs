module Physics.ImplicitEMC.DiscreteSignal (
        DiscreteSignal(..),
        argument,
        function,
) where

import qualified Physics.ImplicitEMC.DiscreteSequence as DQ

data DiscreteSignal = DiscreteSignal {
        argument :: DQ.DiscreteSequence,
        function :: DQ.DiscreteSequence }

fromZip :: [(Float, Float)] -> DiscreteSignal
fromZip pairs = DiscreteSignal { argument = DQ.fromList xs,
                                 function = DQ.fromList ys }
        where (xs, ys) = unzip pairs

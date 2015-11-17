module Physics.ImplicitEMC.DiscreteSequence (
    DiscreteSequence(..),
    regularSequence,
    regularSequence',
    irregularSequence,
    fromList,
    lowerBound,
    upperBound,
    iterateSequence)
where

import Data.List (sort)
import Physics.ImplicitEMC.MathUtils (itof)

-- TODO: Add support for patter synonims.
data DiscreteSequence =
        RegularSequence (Float, Float) Int |
        IrregularSequence [Float]

regularSequence :: (Float, Float) -> Int -> DiscreteSequence
regularSequence (a, b) num | num > 1 = RegularSequence (a, b) num

regularSequence' :: (Float, Float) -> Float -> DiscreteSequence
regularSequence' (a, b) delta | delta > 0 =
        RegularSequence (min a b, max a b) num'
        where num' =  ceiling ((b - a) / delta)

irregularSequence :: [Float] -> DiscreteSequence
irregularSequence xs = IrregularSequence (sort xs)

lowerBound :: DiscreteSequence -> Float
lowerBound seq = case seq of
        RegularSequence (a, _) _ -> a
        IrregularSequence xs  -> head xs

upperBound :: DiscreteSequence -> Float
upperBound seq = case seq of
        RegularSequence (_, b) _ -> b
        IrregularSequence xs     -> last xs

ticksNumber seq = case seq of
        RegularSequence (_, _) n -> n
        IrregularSequence xs     -> length xs

ticksDelta :: DiscreteSequence -> Float 
ticksDelta seq = case seq of
        RegularSequence (a, b) n -> (b - a) / ((itof n) - 1)
        IrregularSequence xs     -> error "No support for irregular sequences"

fromList = irregularSequence

-- |
-- 
-- > ghci> let seq = regularSequence (0, 10), 11
-- > ghci> iterateSequence seq
-- > [0.0, 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0]
--
iterateSequence seq = case seq of
        RegularSequence (a, b) n -> [a + (b-a)*(itof i)/(itof n-1) | i <- [0..n-1]]
        IrregularSequence xs     -> xs

module Physics.ImplicitEMC.DiscreteSequence (
    DiscreteSequence(..),
    regularSequence,
    regularSequence',
    irregularSequence,
    fromList,
    lowerBound,
    upperBound)
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

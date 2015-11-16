module Physics.ImplicitEMC.MathUtils (
    itof
) where

-- Having to put this 'fromIntegral x :: Float' each time is very tedious
-- and results in a poor code appearance.
itof :: Int -> Float
itof x = fromIntegral x :: Float

module Physics.ImplicitEMC.Utils.Trivia where

($$) :: (a -> b) -> a -> b
($$) = ($)

infixl 0 $$ -- left associative

x --> f = f x
infixl 1 --> -- left associative

sequence3 :: [a] -> [b] -> [c] -> [(a, b, c)]
sequence3 xs ys zs = [(x, y, z) | x <- xs, y <- ys, z <- zs]

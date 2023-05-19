module Main

import Data.Vect

zip : (a -> b -> c) -> Vect n a -> Vect n b -> Vect n c
zip f [] [] = []
zip f (x :: xs) (y :: ys) = f x y :: zip f xs ys

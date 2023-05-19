import Data.Vect

add : (Num a) => Vect n a -> Vect n a -> Vect n a
add [] [] = []
add (x :: xs) (y :: ys) = x + y :: add xs ys

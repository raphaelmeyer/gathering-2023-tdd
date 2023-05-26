module Main

import Data.Vect

insert : (Ord a) => a -> Vect len a -> Vect (S len) a
insert x [] = [x]
insert x (y :: xs) = case x < y of
                          False => y :: insert x xs
                          True => x :: (y :: xs)

insertionSort : (Ord a) => Vect n a -> Vect n a
insertionSort [] = []
insertionSort (x :: xs) = insert x (insertionSort xs)

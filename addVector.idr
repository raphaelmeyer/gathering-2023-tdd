module Main

import Data.List

addVector : (Num a) => List a -> List a -> List a
addVector [] [] = []
addVector [] (x :: xs) = ?addVector_rhs_3
addVector (x :: xs) [] = ?addVector_rhs_4
addVector (x :: xs) (y :: ys) = ?addVector_rhs_5


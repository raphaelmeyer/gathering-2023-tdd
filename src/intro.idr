module Main

accumulate : (Num a) => List a -> a
accumulate [] = 0
accumulate (x :: xs) = x + accumulate xs

# Type Driven Development with Idris2

## Sandbox

file

    1 module Main
    3 import Data.List
    5 addVector : (Num a) => List a -> List a -> List a

REPL

    > :ac 5 addVector
    addVector xs ys = ?addVector_rhs

file

    6 addVector xs ys = ?addVector_rhs

REPL

    > :cs 6 11 xs
    addVector (x :: xs) ys = ?addVector_rhs_1

file

    6 addVector [] [] = ?addVector_rhs_2
    7 addVector [] (x :: xs) = ?addVector_rhs_3

REPL

    > :ps 6 addVector_rhs_2
    []

    > :ps 7 addVector_rhs_3
    xs
    > :psnext
    []

    > :ml 7 addVector_rhs_3
    addVector_rhs_3 : Num a -> a -> List a -> List a
    addVector_rhs_3 conArg x xs

file

    3 append : List a -> List a -> List a

    > :gd 3 append
    append [] ys = ys
    append (x :: xs) ys = x :: append xs ys

    > :gdnext

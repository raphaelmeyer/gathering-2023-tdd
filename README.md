# Type Driven Development with Idris2

## Cheatsheet

### REPL

    rlwrap idris2

    :l "file.idr"   -- :load
    :r              -- :reload

    :ac <line> <func>           -- :addclause
    :cs <line> <col> <term>     -- :casesplit
    :ps <line> <hole>           -- :proofsearch
    :psnext
    :ml <line> <hole>           -- :makelemma


### VIM

    \a  " :addclause
    \c  " :casesplit
    \s  " :proofsearch
    \l  " :makelemma

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



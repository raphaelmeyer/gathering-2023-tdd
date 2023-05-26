# Idris2 Demo

## Intro

Open terminal

    cd src/demo
    rlwrap idris2

### Some basics

    > 11
    > :t 11

    > [1,2,3]
    > :t [1,2,3]

    > length [4,5,6]
    > :t List.length

    > 1 + 2
    > :t (+)

    > :doc List
    > Nil
    > 1 :: [2,3]
    > 1 :: Nil

### Pattern matching

    > :l "intro.idr"


    accumulate : (Num a) => List a -> a

    accumulate : (Num a) => List a -> a
    accumulate [] = 0

    accumulate : (Num a) => List a -> a
    accumulate [] = 0
    accumulate (x :: xs) = x + accumulate xs

## Proof search

    > :l "append.idr"


    append : List a -> List a -> List a

### Add clause

    > :ac 3 append

_Add clause_

    append : List a -> List a -> List a
    append xs ys = ?append_rhs

### Case split

    > :cs 4 8 xs

_Case split xs_

    append : List a -> List a -> List a
    append [] ys = ?append_rhs_0
    append (x :: xs) ys = ?append_rhs_1

### Proof search

    > :ps 4 append_rhs_0
    > :psnext
    > :psnext

_Expression search ... ys_ (`?append_rhs_0`)

    append : List a -> List a -> List a
    append [] ys = ys
    append (x :: xs) ys = ?append_rhs_1

_Expression search ... x :: append xs ys_ (`?append_rhs_1`)

    append : List a -> List a -> List a
    append [] ys = ys
    append (x :: xs) ys = x :: append xs ys


    > append [1,2] [3]
    > append [1,2] []
    > append [] [3]

### Try to generate a definition using proof-search

Delete implementation of `append`

    append : List a -> List a -> List a


    > :gd 3 append

## Dependent types

Add two (mathematical) vectors `add [1,2,3] [4,5,6] = [5,7,9]`.

### Using List

    > :l "add.idr"


    add : (Num a) => List a -> List a -> List a

_Add clause_
_Case split xs_
_Case split ys_ (`add [] ys`)
_Case split ys_ (`add (x :: xs) ys`)

    add : (Num a) => List a -> List a -> List a
    add [] [] = ?add_rhs_2
    add [] (x :: xs) = ?add_rhs_3
    add (x :: xs) [] = ?add_rhs_4
    add (x :: xs) (y :: ys) = ?add_rhs_5

_Expr search ... []_ (`add_rhs_2`)

    add : (Num a) => List a -> List a -> List a
    add [] [] = []
    add [] (x :: xs) = ?add_rhs_3
    add (x :: xs) [] = ?add_rhs_4
    add (x :: xs) (y :: ys) = ?add_rhs_5

Implement `add_rhs_5`

    add : (Num a) => List a -> List a -> List a
    add [] [] = []
    add [] (x :: xs) = ?add_rhs_3
    add (x :: xs) [] = ?add_rhs_4
    add (x :: xs) (y :: ys) = x + y :: add xs ys


    > add [] []
    > add [1] [2]
    > add [1,2] [3,4]
    > add [1,2] [3]

### Using Vect

Delete implementation of `add` and replace signature

    import Data.Vect

    add : (Num a) => Vect n a -> Vect n a -> Vect n a

_Add clause_
_Case split xs_
_Case split ys_ (`add [] ys`)
_Case split ys_ (`add (x :: xs) ys`)

    add : (Num a) => Vect n a -> Vect n a -> Vect n a
    add [] [] = ?add_rhs_2
    add (x :: xs) (y :: ys) = ?add_rhs_2

_Expr search ... []_ (`add_rhs_2`)

Implement `add_rhs_2`

    add : (Num a) => Vect n a -> Vect n a -> Vect n a
    add [] [] = []
    add (x :: xs) (y :: ys) = x + y :: add xs ys


    > add [] []
    > add [1,2] [3,4]
    > add [1,2] [3,4,5]

### zip

    > :l "zip.idr"

    > :import Data.Vect
    > :let a : Vect 2 Integer
    > :let a = [1,2]
    > :let b : Vect 2 Integer
    > :let b = [3,4]

    > :t zipWith
    > zipWith (+) a b

    zip : (a -> b -> c) -> Vect n a -> Vect n b -> Vect n c

_Add clause_
_Case split xs_
...
_Expr search ... []_
_Expr search ... []_

    zip : (a -> b -> c) -> Vect n a -> Vect n b -> Vect n c
    zip f [] [] = []
    zip f (x :: xs) (y :: ys) = f x y :: zip f xs ys

Delete implementation

    zip : (a -> b -> c) -> Vect n a -> Vect n b -> Vect n c

_Generate definition ..._

    zip : (a -> b -> c) -> Vect n a -> Vect n b -> Vect n c
    zip f [] [] = []
    zip f (x :: xs) (y :: ys) = f x y :: zip f xs ys


    > Main.zip (+) [1,2] [3,4]

## Insertion sort

    > :l "sort.idr"


    insertionSort : (Ord a) => Vect n a -> Vect n a

_Add clause_
_Case split xs_

    insertionSort : (Ord a) => Vect n a -> Vect n a
    insertionSort [] = ?insertionSort_rhs_0
    insertionSort (x :: xs) = ?insertionSort_rhs_1

_Expr search ... []_ (`insertionSort_rhs_0`)

    insertionSort : (Ord a) => Vect n a -> Vect n a
    insertionSort [] = []
    insertionSort (x :: xs) = ?insertionSort_rhs_1

Rename hole `insertionSort_rhs_1` to `insert`

    insertionSort : (Ord a) => Vect n a -> Vect n a
    insertionSort [] = []
    insertionSort (x :: xs) = ?insert

_Make lemma ?insert_

    insert : Ord a -> a -> Vect len a -> Vect (S len) a

Remove `conArg` and adapt signature

    insert : (Ord a) => a -> Vect len a -> Vect (S len) a

_Peano arithmetic_

    > :doc Nat
    > Z
    > :t Z
    > S Z
    > S (S Z)
    > S (S (S Z))
    > S 41

Explain `Vect (S len) a`

Implement sort

    insertionSort : (Ord a) => Vect n a -> Vect n a
    insertionSort [] = []
    insertionSort (x :: xs) = insert x (insertionSort xs)

_Add clause_
_Case split xs_

    insert : (Ord a) => a -> Vect len a -> Vect (S len) a
    insert x [] = ?insert_rhs_0
    insert x (y :: xs) = ?insert_rhs_1

_Expr search ... []_ (`insert_rhs_0`)

    insert : (Ord a) => a -> Vect len a -> Vect (S len) a
    insert x [] = [x]
    insert x (y :: xs) = ?insert_rhs_1

_Make case ... ?insert_rhs_1_

    insert : (Ord a) => a -> Vect len a -> Vect (S len) a
    insert x [] = [x]
    insert x (y :: xs) = case _ of
                            case_val => ?insert_rhs_1

Implement `_` in case of

    insert : (Ord a) => a -> Vect len a -> Vect (S len) a
    insert x [] = [x]
    insert x (y :: xs) = case x < y of
                            case_val => ?insert_rhs_1

_Case split case_val_

    insert : (Ord a) => a -> Vect len a -> Vect (S len) a
    insert x [] = [x]
    insert x (y :: xs) = case x < y of
                            False => ?insert_rhs_2
                            True => ?insert_rhs_3

_Expression search ... x :: (y :: xs)_

    insert : (Ord a) => a -> Vect len a -> Vect (S len) a
    insert x [] = [x]
    insert x (y :: xs) = case x < y of
                            False => ?insert_rhs_2
                            True => x :: (y :: xs)

Implement insertion

    insert : (Ord a) => a -> Vect len a -> Vect (S len) a
    insert x [] = [x]
    insert x (y :: xs) = case x < y of
                            False => y :: insert x xs
                            True => x :: (y :: xs)


    > insertionSort [3,6,2,4,1]

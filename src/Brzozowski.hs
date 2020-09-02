-- | Implementation of Brzozowski algebraic method

module Brzozowski where

import DFA
import RegExp

initialize :: (Eq state) => DFA state symbol -> ([[RegExp symbol]], [RegExp symbol])
initialize dfa = (a,b) where
  b = map (\x -> if x `elem` f dfa then Epsilon else Empty) (q dfa)
  isTransition i j s = δ dfa i s == j
  links i j = [sym | sym <- sigma dfa, isTransition i j sym]
  sumExp i j
    | length (links i j) > 1 = foldr1 Plus (map Atom (links i j))
    | length (links i j) == 1 = Atom $ head $ links i j
    | otherwise = Empty
  a = [[sumExp i j | j <- q dfa] | i <- q dfa]

convert :: (Eq state) => DFA state symbol -> RegExp symbol
convert dfa = head finalB where
  (_, finalB) = iterateMajor (length (q dfa) - 1, initialize dfa)
  bMajor' b a n = [if i == n then Dot (Star (a !! n !! n)) (b !! n)
                    else b !! i | i <- [0..length b]]
  aMajor' a n = [[if i == n then Dot (Star (a !! n !! n)) (a !! n !! j)
                  else a !! i !! j | j <- [0..length (a !! 1)]] | i <- [0..length (a !! 1)]]
  iterateMajor (n, (a, b))
    | n == -1 = (a, b)
    | otherwise = iterateMajor (n - 1, iterateMinor (0, n, (aMajor' a n, bMajor' b a n)))
  bMinor' b a i n = [if i == ni then Plus (b !! ni) (Dot (a !! i !! n) (b !! n)) else b !! ni |  ni <- [0..length b]]
  aMinor' a i n = [[if i == ni then Plus (a !! ni !! nj) (Dot (a !! i !! n) (a !! n !! nj)) else
                     a !! ni !! nj | nj <- [0..length (a !! 1)]] | ni <- [0..length (a !! 1)]]
  iterateMinor (i, n, (a, b))
    | i > n = (a, b)
    | otherwise = iterateMinor (i + 1, n, (aMinor' a i n, bMinor' b a i n))


simplify :: (Eq sym) => RegExp sym -> RegExp sym
simplify (Star Empty) = Epsilon
simplify (Dot Epsilon a) = a
simplify (Dot a Epsilon) = a
simplify (Dot Empty a) = Empty
simplify (Dot a Empty) = Empty
simplify (Plus Empty a) = a
simplify (Plus a Empty) = a
simplify (Star a) = Star (simplify a)
simplify (Dot a b) = Dot (simplify a) (simplify b)
simplify (Plus (Dot a b) (Dot c d))
  | b == d = Dot (simplify b) (Plus (simplify a) (simplify c))
  | a == c = Dot (simplify a) (Plus (simplify b) (simplify d))
  | a == d = Dot (simplify a) (Plus (simplify b) (simplify c))
  | b == c = Dot (simplify b) (Plus (simplify a) (simplify d))
  | otherwise = Plus (Dot (simplify a) (simplify b)) (Dot (simplify c) (simplify d))
simplify (Plus Epsilon (Star a)) = Star a
simplify (Plus (Star a) Epsilon) = Star a
simplify (Plus a b)
  | a == b = simplify a
  | otherwise = Plus (simplify a) (simplify b)

simplify a = a


exampleD :: Int -> Char -> Int
exampleD 1 'a' = 2
exampleD 1 'b' = 3
exampleD 2 'a' = 3
exampleD 2 'b' = 1
exampleD 3 'a' = 1
exampleD 3 'b' = 2

exampleFA :: DFA Int Char
exampleFA = DFA { q = [1,2,3], sigma = ['a','b'], δ = exampleD, q0 = 1, f = [1] }

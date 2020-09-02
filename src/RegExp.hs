-- | Implementation of regular expressions

module RegExp where

data RegExp symbol = Empty
              | Epsilon
              | Atom symbol
              | Star (RegExp symbol)
              | Plus (RegExp symbol) (RegExp symbol)
              | Dot  (RegExp symbol) (RegExp symbol) deriving Eq

instance (Show symbol) => Show (RegExp symbol) where
  show (Empty) = "∅"
  show (Epsilon) = "ε"
  show (Atom a) = show a
  show (Star a) = "(" ++ show a ++ ")*"
  show (Plus a b) = "(" ++ show a ++ "+" ++ show b ++ ")"
  show (Dot a b) = "(" ++ show a ++ "." ++ show b ++ ")"

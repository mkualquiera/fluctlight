-- | Implementation of DFAs

module DFA where

data DFA state symbol = DFA { q :: [state]
                            , sigma :: [symbol]
                            , δ :: state -> symbol -> state
                            , q0 :: state
                            , f :: [state]
                            }


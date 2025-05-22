module Data.Symbol.TypeApp (reflectSymbol) where

import Data.Symbol (class IsSymbol)
import Data.Symbol as Data.Symbol
import TypeApp (vta)

reflectSymbol :: forall (@sym ∷ Symbol). IsSymbol sym => String
reflectSymbol = vta @sym Data.Symbol.reflectSymbol

module Option.TypeApp where

import Data.Symbol (class IsSymbol)
import Data.Maybe (Maybe)
import Prim.Row (class Cons)
import Option (Option)
import Option as Option
import TypeApp (vta)

get :: forall r r' (@l :: Symbol) a. IsSymbol l => Cons l a r' r => Option r -> Maybe a
get = vta @l Option.get


module Record.TypeApp
  ( get
  , modify
  , set
  ) where

import Record as Record
import Data.Symbol (class IsSymbol)
import TypeApp (vta)
import Prim.Row (class Cons)

get :: forall r r' (@l :: Symbol) a. IsSymbol l => Cons l a r' r => Record r -> a
get = vta @l Record.get

modify :: forall r1 r2 r (@l ∷ Symbol) a b. IsSymbol l ⇒ Cons l a r r1 ⇒ Cons l b r r2 ⇒ (a → b) → Record r1 → Record r2
modify = vta @l Record.modify

set :: forall r1 r2 r (@l ∷ Symbol) a b. IsSymbol l ⇒ Cons l a r r1 ⇒ Cons l b r r2 ⇒ b → Record r1 → Record r2
set = vta @l Record.set

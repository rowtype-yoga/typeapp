module Record.Builder.TypeApp
  ( insert
  ) where

import Record.Builder (Builder)
import Record.Builder as Builder
import Data.Symbol (class IsSymbol)
import TypeApp (vta)
import Prim.Row (class Cons, class Lacks)

insert :: forall (@l :: Symbol) a r1 r2. Cons l a r1 r2 => Lacks l r1 => IsSymbol l => a -> Builder (Record r1) (Record r2)
insert = vta @l Builder.insert

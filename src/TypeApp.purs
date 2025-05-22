module TypeApp (p, vta) where

import Type.Proxy (Proxy(Proxy))

p :: forall k (@l :: k). Proxy l
p = Proxy

vta :: forall @l a. (Proxy l -> a) -> a
vta f = f p

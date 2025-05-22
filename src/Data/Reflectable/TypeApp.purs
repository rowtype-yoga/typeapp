module Data.Reflectable.TypeApp where

import Data.Reflectable (class Reflectable)
import Data.Reflectable as Reflectable
import TypeApp (vta)

reflectType :: forall @v t. Reflectable v t => t
reflectType = vta @v Reflectable.reflectType

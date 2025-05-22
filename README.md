# TypeApp

*A minimal helper library for ergonomic type applications in PureScript.*

## Overview

The `TypeApp` library is a small utility that allows you to use **type application syntax** with existing functions that take `Proxy` arguments, improving readability and ergonomics without breaking existing APIs.

PureScript's type application feature lets you write clearer and more concise code, but many core libraries still require passing `Proxy` values explicitly. This library provides a lightweight bridge by allowing you to wrap such functions using the `@TypeApplications` syntax.

```purescript
-- Instead of:
reflectSymbol (Proxy :: Proxy "someSymbol")

-- You can now write:
reflectSymbol @"someSymbol"
```

## Installation

TODO

## Modules

### `TypeApp`

```purescript
module TypeApp (p, vta) where

import Type.Proxy (Proxy(..))

-- Convenient alias to construct a Proxy at the type level
p :: forall k (@a :: k). Proxy a
p = Proxy

-- Apply a function that expects a Proxy argument using type application
vta :: forall @a r. (Proxy a -> r) -> r
vta f = f p
```

## Example usage

### With `Data.Symbol.reflectSymbol`

```purescript
import Data.Symbol.TypeApp (reflectSymbol)

-- Instead of reflectSymbol (Proxy :: Proxy "label")
reflectSymbol @"label"
```

## Why this library?

While type applications are supported in the compiler, much of the ecosystem still relies on explicit `Proxy` usage. Large-scale migrations are costly and disruptive. This library offers:

* **Opt-in type application usage**
* **No breaking changes to dependencies**
* **Better readability** in application code

## Naming

We chose `vta` ("via type application") over `wrap` to avoid clashing with common function names from libraries like `Newtype`.

## Contributing

Have a commonly used function you’d like to see in type application style? Open a PR or issue! We're open to extending the library with opt-in wrappers for major libraries (e.g., `Record`, `Data.Symbol`, `Type.Data`, etc.).

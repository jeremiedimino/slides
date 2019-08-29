<!-- $theme: gaia -->

# Selective Functors in Build Systems

#### Jeremie Dimino, Jane Street
###### ![8%](./images/github.svg) @diml
###### ![8%](./images/twitter.svg) @dimenix

---

&nbsp;
&nbsp;

![800% center](./images/jane-street.svg)

---

![17% center](./images/jane-street-open-source.png)

![30% center](./images/projects.png)

---

# What are selective functors?

---

![83% center](./graphs/computation-models.svg)

---

# Selective Functors

&nbsp;
&nbsp;

```haskell
class Applicative f => Selective f where
  select :: f (Either a b) -> f (a -> b) -> f b
```

&nbsp;
Operator: `<*?`

---

# Selective combinators

```haskell
whenS :: Selective f => f Bool -> f () -> f ()
branch :: Selective f => f (Either a b)
  -> f (a -> c) -> f (b -> c) -> f c
ifS :: Selective f => f Bool -> f a -> f a -> f a
(<||>) :: Selective f => f Bool -> f Bool -> f Bool
(<&&>) :: Selective f => f Bool -> f Bool -> f Bool
anyS :: Selective f => (a -> f Bool) -> [a] -> f Bool
allS :: Selective f => (a -> f Bool) -> [a] -> f Bool
fromMaybeS :: Selective f => f a -> f (Maybe a) -> f a
whileS :: Selective f => f Bool -> f ()
```

---

# Limited form of dependance

&nbsp;
&nbsp;

```haskell
bindBool :: Selective f => f Bool -> (Bool -> f a) -> f a
bindBool x f = ifS x (f False) (f True)
```

&nbsp;
Works with any enumerable type.

---

# Is it really worth it?

---

# github.com/janestreet

- ![6%](./images/projects/base.png) base
- ![6%](./images/projects/core.png) core
- ![6%](./images/projects/async.png) async
- ![6%](./images/projects/incr_dom.png) incr_dom
- ![6%](./images/projects/incremental.png) incrental
- ...

Over 100 packages

---

![83% center](./graphs/monorepo.svg)

---
&nbsp;
src/dune:
```scheme
(library
 (public_name mylib)
 (libraries re lwt))
 
(rule (with-stdout-to m.ml (run gen/gen.exe)))
```

src/gen/dune:
```scheme
(executable
 (name gen)
 (libraries ppxlib))
```

---

# Dune's internals

1. Generate rules
2. Run the build

&nbsp;
![30% center](./images/construction.png)

---

# The ==Build== selective

```haskell
-- Action DSL
data Action = Run Path [String] | Chdir Path Action | ...

-- The Build selective
data Build a = Build a [Path]

-- A Build system rule
data Rule = Rule (Build Action) [Path]

-- Read the contents of a file
read :: Path -> Build String

-- Declare a file that the action will read
dep :: Path -> Build ()
dep fn = Build () [fn]
```

---

# OCaml compilation

- modules must be compiled in order
- the `ocamldep` tool computes dependencies 


![50% center](./graphs/modules4.svg)

---

# Exercise

Compute the list of rules to build a library

```haskell
-- Command that compiles a module
ocamlc :: ModuleName -> Action

-- Get the dependency of a module
ocamldep :: ModuleName -> Build [Path]

-- Declare dependencies and compile a module
compileModule :: ModuleName -> [ModuleName] -> Build Action
compileModule m l = ??

```

---

# Solution

&nbsp;


```haskell
compileModule :: ModuleName -> [ModuleName] -> Build Action
compileModule m l =
  foldr waitDep (ocamlc m) (filter (<> m) l)
  where
    isDep x = (mem x) <$> (ocamldep m)
    waitDep x acc =
      (ifS (isDep x) (dep x) (return ())) *> acc
```

---

# Compiling a library

![center](./graphs/modules.svg)

---

# Compiling a library

![center](./graphs/modules2.svg)

---

# Unconditional dependencies

![60% center](./graphs/modules3.svg)

---

# The end

#### ![8%](./images/ocaml.png) discuss.ocaml.org
#### ![14%](./images/jane-street-logo.png) opensource.janestreet.com

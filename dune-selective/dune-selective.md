<!-- $theme: gaia -->

# Get your money's worth with Selective Functors

#### Jeremie Dimino, Jane Street
###### ![8%](./images/github.svg) @diml
###### ![8%](./images/twitter.svg) @dimenix

---

![800% center](./images/jane-street.svg)

---

![17% center](./images/jane-street-open-source.png)

![30% center](./images/projects.png)

---

![83% center](./graphs/computation-models.svg)

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


![30% center](./images/construction.png)

---

# The =='a Build.t== selective

```ocaml
type rule = Action.t t
```


```ocaml
val dyn_deps : ('a   * Dep.Set.t) t -> 'a t
val     deps :  'a t * Dep.Set.t    -> 'a t
```

---

# Selective parsers

jobjo.github.io/2019/05/19/applicative-parsing.html


---

# The end

#### ![8%](./images/ocaml.png) discuss.ocaml.org
#### ![14%](./images/jane-street-logo.png) opensource.janestreet.com

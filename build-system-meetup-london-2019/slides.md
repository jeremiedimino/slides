<!-- $theme: gaia -->

# Dune
### The OCaml build system

# ![10%](./images/dune-no-text.png)

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

# The history of Dune

---

At the beginning, there was omake, ocamlbuild, ...

&nbsp;

... then Jane Street did Jenga and the Jenga rules...

&nbsp;

... then a domain specific tool called jbuilder...

&nbsp;

... and finally Dune.

---

# What is Dune?

---

![50% center](./graphs/dune-overview-embed.svg)


&nbsp;

```scheme
(library
 (public_name mylib)
 (libraries base re lwt))
 
; Custom build rule
(rule (with-stdout-to m.ml (run gen/gen.exe)))
```


---

&nbsp;
![60% center](./graphs/dune-inside.svg)


---

# Interesting Dune features

- Composability
- Multiple build contexts

---

# How does it work?

---

&nbsp;
&nbsp;
![60% center](./graphs/rule-prod-exe.svg)

---

&nbsp;

```ocaml
let read_dune_file fname =
  let contents = read_file fname in
  parse_dune_file fname

let get_lib dir =
  let stanzas =
    read_dune_file (Path.relative dir "dune")
  in
  List.find_map stanzas ~f:(function
    | Library lib -> Some lib.name
    | _ -> None)
```

---

# Memoisation framework

![60% center](./graphs/memo.svg)


---

# The end

#### ![3%](./images/dune-no-text.png) [dune.build](dune.build)
#### ![8%](./images/ocaml.png) discuss.ocaml.org
#### ![14%](./images/jane-street-logo.png) opensource.janestreet.com

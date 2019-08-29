-- Command that compiles a module
ocamlc :: ModuleName -> Action

-- Get the dependency of a module
ocamldep :: ModuleName -> Build [Path]

-- 
compileModule :: ModuleName -> [ModuleName] -> Build Action
compileModule m l = ??


compileModule :: ModuleName -> [ModuleName] -> Build Action
compileModule m l =
  foldr waitDep (ocamlc m) (filter (<> m) l)
  where
    isDep x = (mem x) <$> (ocamldep m)
    waitDep x acc =
      (ifS (isDep x) (dep x) (return ())) *> acc

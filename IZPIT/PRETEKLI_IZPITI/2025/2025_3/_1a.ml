type formula = 
  | Atom of string
  | False
  | True
  | Or of formula * formula
  | And of formula * formula
  | Not of formula

let izraz = Or((And(True, Atom "p")), (And(Not(Atom "q"), False)))

let x = fun f -> f (fun g -> g 42);;
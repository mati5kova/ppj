type drevo = List of int | Vozlisce of int * drevo * drevo

let rec neizogiben x drevo = 
  match drevo with
  | List(v) -> x=v
  | Vozlisce(v, l, r) -> v=x || ((neizogiben x l) && (neizogiben x r))
(* .mli datoteka *)

(* Pomožni tip, funkcija in signatura za lepše primerjanje. *)
type order = Less | Equal | Greater

let ocaml_cmp x y =
  let c = Stdlib.compare x y in
  if c < 0 then Less
  else if c > 0 then Greater
  else Equal

module type ORDERED =
  sig
    type t
    val cmp : t -> t -> order
  end

(* Specifikacija podatkovnega tipa množica. *)
module type SET =
  sig
    type element
    val cmp : element -> element -> order
    type set
    val empty : set
    val member : element -> set -> bool
    val add : element -> set -> set
    val remove : element -> set -> set
    val to_list : set -> element list
  end


(* .ml datoteka *)
module IntListSet : SET with type element = int =
struct
  type element = int
  
  let cmp = ocaml_cmp
  
  type set = element list
  
  let empty = []

  let rec member e s = 
    match s with
    | [] -> false
    | h::t -> 
      match cmp e h with
      | Equal -> true
      | _ -> member e t

  let add e s =
    if member e s then s else e::s

  let rec remove e s =
    match s with
    | [] -> []
    | h::t -> 
      match cmp h e with
      | Equal -> t
      | _ -> h::(remove e t)
  
  let to_list s = s
end

module S = IntListSet;;

(*
# S.to_list(S.add 1 S.empty);;
- : int list = [1]
*)
module type TRILEAN =
sig
  type tri = True | False | Probably of float
  type hidden
  val conjunction : tri * tri -> tri
  val negation : tri -> tri
  val congregation : (tri * tri -> tri) -> (tri * tri -> tri) -> (tri * tri -> tri * tri)
  val hide : tri -> hidden
  val reveal : hidden -> tri
end

module Trilean:TRILEAN = 
struct
  type tri = True | False | Probably of float
  type hidden = Hidden
  let conjunction = fun ((t1, t2):(tri*tri)) -> t1
  let negation = fun (t:tri) -> t
  let congregation = fun (a : (tri * tri -> tri)) (b : (tri * tri -> tri)) -> (fun (c:(tri*tri)) -> c)
  let hide = fun (t:tri) -> Hidden
  let reveal = fun (h:hidden) -> True
end

let rec f g = function
| (h1::t1, h2::t2) -> g h1 h2 ^ f g (t1, t2)
| _ -> ""
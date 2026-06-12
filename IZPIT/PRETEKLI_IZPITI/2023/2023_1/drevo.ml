type 'a rose = Thorn of 'a | Rose of 'a rose list
type 'a tree = Empty | Leaf of 'a | Node of 'a tree * 'a tree


let rec rose2tree rose = 
  match rose with
  | Thorn(t) -> Leaf(t)
  | Rose([]) -> Empty
  | Rose(r::rest) -> 
    let rec rec_list rest_of_list = 
      match rest_of_list with
      | [] -> Empty
      | (h::t) ->(Node(rose2tree h, rec_list t))
    in
    Node(rose2tree r, rec_list rest)

let rec tree2rose tree = 
  match tree with
  | Leaf(l) -> Thorn(l)
  | Empty -> Rose[]
  | Node(levo, desno) -> 
    let rec make_list_of_thorns d =
      match d with
      | Empty -> []
      | Node(l, r) -> (tree2rose l) :: make_list_of_thorns r
      | Leaf(_) -> failwith "not a rose"
    in
    Rose(tree2rose levo :: make_list_of_thorns desno)



(* # rose2tree (Rose [Thorn "a"; Thorn "b"; Thorn "c"]);;
- : string tree = Node (Leaf "a", Node (Leaf "b", Node (Leaf "c", Empty)))
# rose2tree (Rose [Thorn 42; Rose [Thorn 23; Thorn 666; Rose []]; Rose []]);;
- : int tree =
Node (Leaf 42,
Node (Node (Leaf 23, Node (Leaf 666, Node (Empty, Empty))),
Node (Empty, Empty)))
# tree2rose (Node (Leaf "a", Node (Leaf "b", Node (Leaf "c", Empty))));;
- : string rose = Rose [Thorn "a"; Thorn "b"; Thorn "c"]
# tree2rose (Node (Node (Leaf 42, Empty), Empty));;
- : int rose = Rose [Rose [Thorn 42]]
# tree2rose (Node (Empty, Leaf 42));;
Exception: Failure "not a rose tree". *)
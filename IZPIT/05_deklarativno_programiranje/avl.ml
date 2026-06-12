type order =
  | Less
  | Equal  
  | Greater
let cmp a b =
  if a=b then Equal else if a > b then Greater else Less

type avltree = 
  | Node of int * int * avltree * avltree  (*vsebina, visina, levo, desno*)
  | Empty

let height t = 
  match t with
  | Node (_, h, _, _) -> h
  | Empty -> -1

let leaf value = Node(value, 0, Empty, Empty)

let node value left right = Node(value, 1 + max (height left) (height right), left, right)

let myTree = 
  (
    node 
    5 
    (node 3 (leaf 1) (leaf 4)) 
    (leaf 8)
  )

let rec toList t = 
  match t with
  | Node (v, h, l, r) -> (toList l) @ v :: (toList r)
  | Empty -> []

let rec search target t =
  match t with
  | Empty -> false
  | Node (v, _, l, r) ->
    match (cmp target v) with
    | Equal -> true
    | Greater -> search target r
    | Less -> search target l


let imbalance t = 
  match t with
  | Node (_, _, l, r) -> height l - height r
  | Empty -> 0

let rotateLeft t =
  match t with
  | Node (x, _, xl, Node(y, _, yl, yd)) -> (node y (node x xl yl) yd)
  | _ -> t

let rotateRight t = 
  match t with
  | Node (y, _, Node(x, _, xl, xd), yd) -> (node x xl (node y xd yd))
  | _ -> t

let balance t =
  match t with
  | Empty -> t
  | Node(v, _, l, r) ->
      match imbalance t, imbalance l, imbalance r with (* delamo matching nad trojico treh stevil*)
      | (2, (0 | 1), _) -> rotateRight t
      | (2, -1, _) -> rotateRight (node v (rotateLeft l) r) (*ne mores narest samo rotateRight (rotateLeft l) ker to se iznici in nikjer ne rotiras nad t*) 
      | (-2, _, (0 | -1)) -> rotateLeft t
      | (-2, _, 1) -> rotateLeft (node v l (rotateRight r))
      | (( 0 | 1 | -1), _, _) -> t (*ce ne rabimo naredit nobenih rotacij*)
      | _ -> failwith "ne da se popraviti"

let rec add x t =
  match t with
  | Empty -> leaf x
  | Node (y, _, l, r) -> 
    match (cmp x y) with
    | Equal -> t
    | Less -> balance (node y (add x l) r)
    | Greater -> balance (node y l (add x r))

let rec removeSuccessor t =
  match t with
  | Empty -> failwith "PRAZNO DREVO"
  | Node (x, _, Empty, r) -> (r, x)
  | Node (x, _, l, r) ->
      let (l', successor) = removeSuccessor l in
      (balance (node x l' r), successor)

let rec remove x t =
  match t with
  | Empty -> Empty
  | Node (y, _, l, r) ->
      match cmp x y with
      | Less ->
          balance (node y (remove x l) r)

      | Greater ->
          balance (node y l (remove x r))

      | Equal ->
          match l, r with
          | Empty, Empty -> Empty
          | Empty, _ -> r
          | _, Empty -> l
          | _, _ ->
              let (r', successor) = removeSuccessor r in
              balance (node successor l r')

let show t =
  let make_space = String.map (fun _ -> ' ') in 
  let rec string_of_lvl lvl = function 
    | Empty -> if lvl = 0 then "E" else " " 
    | Node (n, h, l, r) ->
        let sn = string_of_int n in
        let sl = string_of_lvl lvl l in
        let sr = string_of_lvl lvl r in
        if h = lvl
        then make_space sl ^ sn ^ make_space sr
        else sl ^ make_space sn ^ sr
  in
  let rec print_levels lvl =
    if lvl >= 0
    then (print_string (string_of_int lvl ^ ": " ^ string_of_lvl lvl t ^ "\n");
          print_levels (lvl-1))
    else ()
  in
  print_levels (height t) ; flush stdout
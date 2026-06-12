(* Tu je program ki sešteje prvih 42 lihih števil: *)
let vsota_lihih1 n = 
  let i = ref 0 in
  let sum = ref 0 in
  while !i < n do
    sum := !sum + (2 * !i + 1) ;
    i := !i + 1
  done;
  !sum

(* Sestavite funkcijo vsota1 : int -> int, ki sprejme n in vrne vsoto 1 + 2 + ⋯ + n. Uporabite reference in zanko while. *)
let vsota1 n = 
  let i = ref 1 in
  let sum = ref 0 in
  while !i <= n do
    sum := !sum + !i ;
    i := !i + 1;
  done;
  !sum

(* Sestavite funkcijo fibonacci1 : int -> int, ki sprejme n in vrne n-to Fibonaccijevo število F(n). 
   Nauk: Fibonaccijevo zaporedje je definirano s predpisom: 
   F(0) = 0
   F(1) = 1
   F(n) = F(n-1) + F(n-2)
   Uporabite reference in zanko while.
*)
let fibonacci1 n = 
  match n with
  | 0 -> 0
  | 1 -> 1
  | _ -> 
    let i = ref 0 in
    let fn0 = ref 0 in
    let fn1 = ref 1 in
    while !i < n do
      let temp = !fn1 in
      fn1 := !fn0 + !fn1 ;
      fn0 := temp; 
      i := !i + 1 ;
    done;
    !fn0

(* Sestavite funkcijo vsota2 : int -> int, ki sprejme n in vrne vsoto 1 + 2 + ⋯ + n. 
   Funkcija naj bo rekurzivna in naj ne uporablja zank in referenc.
*)
let rec vsota2 n =
  match n with
  | 0 -> 0
  | n -> n + vsota2 (n-1)

(* Sestavite funkcijo fibonacci2 : int -> int, ki sprejme n in vrne n-to Fibonaccijevo število F(n). 
   Funkcija naj bo rekurzivna in naj ne uporablja zank in referenc.
*)
let rec fibonacci2 n = 
  match n with
  | 0 -> 0
  | 1 -> 1
  | n -> fibonacci2 (n-1) + fibonacci2 (n - 2)


(* vsota_lihih1 AMPAK z uporabo repne rekurzije *)
let vsota_lihih2 n = 
  let rec vsota_lihih_internal sum i =
    if i < n then
      vsota_lihih_internal (sum + 2*i + 1) (i+1)
    else
      sum
  in
  vsota_lihih_internal 0 0

(* Po zgornjem receptu predelajte funkcijo vsota1 v funkcijo vsota3, ki uporablja akumulatorje in repno rekurzijo. 
   Nato primerajte delovanje funkcij vsota1, vsota2 in vsota3. Ali lahko vse tri izračunajo npr. vsoto prvih 1000000 števil?
*)
(* vsota1 in vsota3 zmoreta vecja stevila *)
(* vsota2 (naivna rekurzija) se ustavi pri 100mio (mogoce se prej) *)
let vsota3 n =
  let rec vsota_internal sum i =
    if i <= n then
      vsota_internal (sum + i) (i + 1)
    else
      sum
  in
  vsota_internal 0 0;;

(* Po zgornjem receptu predelajte funkcijo fibonacci1 v funkcijo fibonacci3, ki uporablja akumulatorje in repno rekurzijo. *)
(* fibonacci1 in fibonacci2 gresta do n=90 *)
let fibonacci3 n = 
  if n = 0 then 0 else
  let rec fib_internal i f0 f1 = 
    if i <= n then
      fib_internal (i + 1) (f1) (f0 + f1)
    else
      f0
  in
  fib_internal 2 1 1;;


(* Splošna pretvorba zanke while v rekurzivno funkcijo *)
(* 
s := s₀
while p(s) do
  s := f(s)
done ;
return r(s)
*)
let zanka s0 p f r =
  let rec loop s =
    if p s then loop (f s) else r s
  in
  loop s0

let vsota4 n = 
  zanka 
    (1, 0) (* (i, sum) *)
    (fun (i, _) -> i <= n) 
    (fun (i, sum) -> (i+1, sum+i))
    (fun (_, sum) -> sum)

let fibonacci1 n = 
  match n with
  | 0 -> 0
  | 1 -> 1
  | _ -> 
    let i = ref 0 in
    let fn0 = ref 0 in
    let fn1 = ref 1 in
    while !i < n do
      let temp = !fn1 in
      fn1 := !fn0 + !fn1 ;
      fn0 := temp; 
      i := !i + 1 ;
    done;
    !fn0

let fibonacci4 n =
  zanka
    (0, 0, 1) (* (i, fn0, fn1) *)
    (fun (i, _, _) -> i < n)
    (fun (i, fn0, fn1) -> (i+1, fn1, fn0 + fn1))
    (fun (_, fn0, _) -> fn0)

(* 
Funkcija forzanka naj prejme začetno stanje s₀, spodnjo in zgornjo mejo a oziroma b ter funkciji f in r. Njen tip bo torej
α → int → int → (int → α → α) → (α → β) → β

s := s₀
for i = a to b do
  s := f(i, s)
done ;
return r(s) 
*)
let forzanka s0 a b f r =
    let rec loop i s =
        if i <= b then loop (i + 1) (f i s) else (r s)
    in
    loop a s0

let fibonacci1 n = 
  match n with
  | 0 -> 0
  | 1 -> 1
  | _ -> 
    let i = ref 0 in
    let fn0 = ref 0 in
    let fn1 = ref 1 in
    while !i < n do
      let temp = !fn1 in
      fn1 := !fn0 + !fn1 ;
      fn0 := temp; 
      i := !i + 1 ;
    done;
    !fn0

let fibonacci5 n = 
  forzanka
    (0, 1) (* (fn0, fn1) *)
    0
    n
    (fun i (fn0, fn1) -> (fn1, fn0 + fn1))
    (fun (fn0, _) -> fn0)


(*  *)
(* DODATNE NALOGE *)
(*  *)

type 'a tree = Leaf of int | Node of 'a tree * 'a tree
let rec count f t = 
  match t with
  | Leaf x -> if (f x) then 1 else 0
  | Node (t1, t2) -> count f t1 + count f t2


let pascal n =
  let rec next_row row =
    match row with
    | [] -> []
    | [_] -> []
    | x :: y :: rest -> (x + y) :: next_row (y :: rest)
  in
  let make_next row =
    1 :: next_row row @ [1]
  in
  let rec aux k row =
    if k = 0 then []
    else row :: aux (k - 1) (make_next row)
  in
  aux n [1]
;;
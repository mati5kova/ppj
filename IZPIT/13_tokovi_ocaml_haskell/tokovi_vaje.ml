type 'a stream = Cons of 'a * (unit -> 'a stream)

(* TOK IS SEZNAMA *)
(* Vrne neskončni tok, ki ima prvih i elemtov iz danega seznama, nato pa ponavlja element `r` *)
let rec from_list l r = 
  match l with
  | el::rest -> Cons(el, fun _ -> from_list rest r)
  | [] -> Cons(r, fun _ -> from_list [] r)

(* SEZNAM IZ TOKA *)
let rec to_list n s = 
  if n < 0 then invalid_arg "to_list: negative n" else
  match n with
  | 0 -> []
  | _ -> 
    match s with
    | Cons(el, tail) ->
      el :: to_list (n-1) (tail ())


(* N-TI ELEMENT TOKA *)
let rec element_at n s = 
  if n < 0 then invalid_arg "to_list: negative n" else
  match n with
  | 0 -> 
    let Cons(el, _) = s in
    el
  | _ -> 
    let Cons(_, tail) = s in
    element_at (n-1) (tail())

(* GLAVA TOKA *)
let head s =
  let Cons(h, _) = s in 
  h

(* REP TOKA *)
let tail s =
  let Cons(_, tail) = s in 
  (tail())

(* PRESLIKAVA *)
let rec map f s = 
  let Cons(hd, tl) = s in
  Cons(f hd, fun () -> map f (tl()))
  
(* TOK NARAVNIH STEVIL *)
let nat = 
  let rec nat_internal n = 
      Cons(n, fun () -> nat_internal (n+1)) in
  nat_internal 0

(* FIBONACCIJEVA STEVILA *)
let fib =
  let rec fib_internal f0 f1 =
    Cons(f0, fun () -> fib_internal f1 (f0 + f1)) in
  fib_internal 0 1

(* PRESLIKAVA PAROV *)
let rec zip f s1 s2 = 
  let Cons(h1, t1) = s1 in
  let Cons(h2, t2) = s2 in
    Cons(f h1 h2, fun () -> zip f (t1()) (t2()))

(* VECKRATNIKI STEVILA *)
let veckratniki_stevila k = 
  let rec veckratniki_stevila_internal n =
    Cons(n*k, fun () -> veckratniki_stevila_internal (n+1)) in
  veckratniki_stevila_internal 0

(* VECKRATNIKI *)
(* stream katerega elementi so tokovi veckratnikov *)
let veckratniki =
  let rec veckratniki_internal k =
    Cons(veckratniki_stevila k, fun () -> veckratniki_internal (k+1)) in
  veckratniki_internal 0
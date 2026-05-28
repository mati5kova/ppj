type 'a seznam = Kons of 'a * 'a seznam | Konec;;

let primer1 = Kons (1, Kons (2, Konec));;

let glava =
  match primer1 with
  | Kons (h, t) -> h
  | Konec -> failwith "nimamo glave"


type 'a stream = Cons of 'a * (unit -> 'a stream)

let rec from_list l r =
  match l with
  | [] -> Cons (r, fun () -> from_list l r)  (*vemo da je l prazen lahko bi pisali tudi `from_list [] r`*)
  | x::xs -> Cons(x, fun () -> from_list xs r)

let four = from_list [1;2;3] 4;; (* tukaj se rekurzija nikoli ne poklice ker ce bi se, se ne bi nikoli ustavila*)

(*n - koliko elementov toka damo v seznam*)
let rec to_list n s =
  match s with
  | Cons (x, r) ->
    if n = 0 then []
    else x :: to_list (n-1) (r ())

let head a_stream = 
  match a_stream with
  | Cons (h, r) -> h

let rec tail a_stream =
  match a_stream with
  | Cons (h, r) -> r()

let rec map f a_stream = 
  match a_stream with
  | Cons (h, r) -> Cons(f h, fun () -> map f (r()));;

to_list 5 (map (fun x -> x*x) four) ;;

let nat =
  let rec gen n =
    Cons (n, fun () -> gen (n+1))
  in gen 0

let fib =
  let rec gen f0 f1 =
    Cons (f0, fun () -> gen (f1) (f0+f1))
  in gen 0 1

let rec zip f a_stream b_stream =
  match (a_stream, b_stream) with
  | (Cons (x1, r1), Cons (x2, r2)) -> Cons (f x1 x2, fun () -> zip f (r1 ()) (r2 ()))

let veckratniki_stevila k = map (fun i -> i * k) nat

let veckratniki = map veckratniki_stevila nat

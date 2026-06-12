type lexeme = PLUS | MINUS | TIMES | CONST of int
type expr =
| Num of int
| Add of expr * expr
| Sub of expr * expr
| Mul of expr * expr
let elb_lexer ( string_expression : string) : lexeme list =
let f = function
| "-" -> MINUS
| "+" -> PLUS
| "*" -> TIMES
| n -> CONST ( int_of_string n)
in
List.map f
(List.filter ((<>) "") (String. split_on_char ' ' string_expression ))
let elb_parser (lexemes : lexeme list) : expr =
let rec loop stack lexemes =
match stack , lexemes with
| s, CONST n :: rest -> loop (Num n :: s) rest
| e1 :: e2 :: s, PLUS :: rest -> loop (Add (e2 , e1) :: s) rest
| e1 :: e2 :: s, MINUS :: rest -> loop (Sub (e2 , e1) :: s) rest
| e1 :: e2 :: s, TIMES :: rest -> loop (Mul (e2 , e1) :: s) rest
| [e], [] -> e
| _ -> failwith "cannot parse"
in
loop [] lexemes


let func f x y = f y x

module type COMBINATORS =
sig
val succ : int -> int
val const : 'a -> 'b -> 'a
val flip : ('a -> 'b -> 'c) -> 'b -> 'a -> 'c
val negate : ('a -> bool) -> 'a -> bool
end

module Comb:COMBINATORS = 
struct
  let succ = fun x -> x
  let const = fun x y -> x
  let flip = fun f -> fun b a -> f a b
  let negate = fun f -> fun x -> f x
end


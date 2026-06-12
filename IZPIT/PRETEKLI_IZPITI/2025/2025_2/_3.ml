type izraz =
  | True
  | False
  | Var of string
  | Not of izraz
  | And of izraz * izraz
  | Or of izraz * izraz

let rec eval env expr = 
  match expr with
  | True -> true
  | False -> false
  | Or(expr1, expr2) -> (eval env expr1) || (eval env expr2)
  | And(expr1, expr2) -> (eval env expr1) && (eval env expr2)
  | Not(expr1) -> not (eval env expr1)
  | Var(name) ->
    match List.find (fun (x, value) -> x=name) env with
    | (x, value) -> value

let bool_of_optionAND op1 op2 = 
  match (op1, op2) with
  | (Some true, Some true) -> Some true
  | (None, _) | (_, None) -> None
  | _ -> Some false

let bool_of_optionOR op1 op2 = 
  match (op1, op2) with
  | (Some false, Some false) -> Some false
  | (None, _) | (_, None) -> None
  | _ -> Some true

let bool_of_optionNOT op = 
  match op with
  | Some true -> Some false
  | Some false -> Some true
  | None -> None

let rec eval' expr = 
  match expr with
  | True -> Some true
  | False -> Some false
  | Or(expr1, expr2) -> bool_of_optionOR (eval' expr1) (eval' expr2)
  | And(expr1, expr2) -> bool_of_optionAND (eval' expr1) (eval' expr2)
  | Not(expr1) -> bool_of_optionNOT (eval' expr1)
  | Var(name) -> None


let rec optimize expr =
  match expr with
  | True -> True
  | False -> False
  | Var(x) -> Var(x)
  | Not(p) ->
    let p' = optimize p in
    Not p'
  | And(p, q) ->
    let p' = optimize p in
    let q' = optimize q in
    begin match p', q' with
    | x, True | True, x -> x
    | x, False | False, x -> False
    | _,_ -> And(p', q')
  end
  | Or(p, q) ->
    let p' = optimize p in
    let q' = optimize q in
    begin match p', q' with
    | x, True | True, x -> True
    | x, False | False, x -> x
    | _, _ -> Or(p', q')
  end

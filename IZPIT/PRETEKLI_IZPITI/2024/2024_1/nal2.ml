type instruction =
  | NOOP (* no operation, IP := IP + 1 *)
  | PUSH of int (* push integer constant onto stack, IP := IP + 1 *)
  | ADD (* push sum of top two elements of stack, IP := IP + 1 *)
  | SUB (* push difference of top two elements of stack, IP := IP + 1 *)
  | EQ (* push 1 if top two elements of stack are equal otherwise push 0, IP := IP + 1 *)
  | LT (* push 1 if top top element of stack is less than the second element otherwise push 0, IP := IP + 1 *)
  | JMP of int (* relative jump IP := IP + rel *)
  | JMPZ of int (* jump if zero on the stack IP := IP + rel, otherwise IP := IP + 1 *)
  | EXIT (* stop execution, returning the top element of the stack *)
  | READ (* push read integer, IP := IP + 1 *)
  | DUP (* duplicate top element on the stack, IP := IP + 1 *)

type machine_state = {
  input : int list;
  rom : int -> instruction;
  stack : int list;
  instruction_pointer : int;
}

let pop state =
  match state.stack with
  | x :: stack -> (x, { state with stack })
  | [] -> failwith "empty stack"

let read state =
  match state.input with
  | x :: input -> (x, { state with input })
  | [] -> failwith "empty input"

let double_pop state =
  let x1, state = pop state in
  let x2, state = pop state in
  (x1, x2, state)

let push x state = { state with stack = x :: state.stack }

let increment_instruction_pointer i state =
  { state with instruction_pointer = state.instruction_pointer + i }

let string_of_instruction = function
  | NOOP -> "NOOP" 
  | ADD -> "ADD" 
  | SUB -> "SUB" 
  | EQ -> "EQ"
  | LT -> "LT" 
  | EXIT -> "EXIT" 
  | READ -> "READ" 
  | DUP -> "DUP"
  | PUSH i -> "PUSH " ^ string_of_int i
  | JMP i -> "JMP " ^ string_of_int i
  | JMPZ i -> "JMPZ " ^ string_of_int i

let print_debug_info { input; rom; stack; instruction_pointer } =
  Printf.printf "INFO: IP = %i (%s), stack = [%s], input = [%s]\n"
  instruction_pointer
  (string_of_instruction @@ rom instruction_pointer)
  (String.concat ", " @@ List.map string_of_int stack)
  (String.concat ", " @@ List.map string_of_int input)

let rec run (state : machine_state) = 
  print_debug_info state;
  let incr = increment_instruction_pointer 1 in
  match state.rom state.instruction_pointer with
  | NOOP -> run (incr state)
  | PUSH(num) -> run (incr (push num state))
  | READ -> 
    let (read_value, next_state) = read state in
    run (incr (push read_value next_state))
  | ADD -> 
    let (op1, op2, next_state) = double_pop state in
    run(incr (push (op1+op2) next_state))
  | SUB ->
    let (op1, op2, next_state) = double_pop state in
    run(incr (push (op1-op2) next_state))
  | EQ -> 
    let (val1, val2, next_state) = double_pop state in
    run(incr (push (if val1=val2 then 1 else 0) next_state))
  | LT -> 
    let (val1, val2, next_state) = double_pop state in
    run(incr (push (if val1<val2 then 1 else 0) next_state))
  | JMP(where) -> run (increment_instruction_pointer where state)
  | JMPZ(where) ->
    let (top_of_stack, next_state) = pop state in
    if top_of_stack=0 then
      run(increment_instruction_pointer where next_state)
    else
      run(incr next_state)
  | DUP -> 
    let (top_of_stack, next_state) = pop state in
    run(incr (push top_of_stack (push top_of_stack next_state)))
  | EXIT -> 
    let (x, _) = pop state in
    x

let romA i = [| PUSH 0; READ; DUP; JMPZ 3; ADD; JMP (-4); JMPZ 1; EXIT |].(i)

let computerA input = run { rom = romA; stack = []; input; instruction_pointer = 0 }

let ena = run { rom = (fun i -> [| PUSH 42; EXIT |].(i)); stack = []; input = [1; 2]; instruction_pointer = 0 } ;;
let dva =  run { rom = (fun i -> [| READ; EXIT |].(i)); stack = []; input = [1; 2]; instruction_pointer = 0 } ;;
let tri = run { rom = (fun i -> [| ADD; EXIT |].(i)); stack = [-1; 1; 2]; input = []; instruction_pointer = 0 } ;; 
let stiri = run { rom = (fun i -> [| SUB; EXIT |].(i)); stack = [-1; 1; 2]; input = []; instruction_pointer = 0 } ;;
let pet = run { rom = (fun i -> [| EQ; EXIT |].(i)); stack = [-1; 1; 2]; input = []; instruction_pointer = 0};;


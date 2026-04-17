let vsota1 n =
    let i = ref 1 in
    let sum = ref 0 in
    while !i <= n do
        sum := !sum + !i;
        i := !i + 1
    done;
    !sum

let fibonacci1 n =
    match n with
    | 0 -> print_int 0
    | 1 -> print_int 1
    | _ ->
        let f0 = ref 0 in
        let f1 = ref 1 in
        let f2 = ref 1 in
        let i = ref 1 in
        while !i < n do
            i := !i + 1;
            f2 := !f0 + !f1;
            f0 := !f1;
            f1 := !f2;
            print_int !f2;
            print_newline ()
        done

let rec vsota2 n = 
    match n with 
    | 0 -> 0 
    | _ -> n + vsota2 (n - 1)

let rec fibonacci2 n =
    match n with 
    | 0 -> 0 
    | 1 -> 1 
    | _ -> fibonacci2 (n - 1) + fibonacci2 (n - 2)


let vsota3 n = 
    let rec vsota i sum = 
        if i <= n then
            vsota (i + 1) (sum + i)
        else
            sum
    in

    vsota 0 0

(*0 1 1 2 3 5 8 13 21 34 55*)
let fibonacci3 n =
    let rec fibonacci i curr next =
        if i = 0 then
            curr
        else
            fibonacci (i - 1) next (curr + next)
    in

    fibonacci n 0 1

(*
    GENERIČNA FORMULA ZA PRIDELAT ZANKO -> VSE KAR RABIŠ NAJTI SO: s0(začetno stanje), p(ogoj), f(unkcija), r(eturn)
*)
let zanka s0 p f r =
  let rec loop s =
    if p s then loop (f s) else r s
  in
  loop s0

let vsota4 n = 
    zanka 
    (0, 0) (* (i, curr_sum) *)
    (fun (i, _) -> i <= n) 
    (fun (i, sum) -> (i + 1, sum + i)) 
    (fun (_, sum) -> sum)

let fibonacci4 n =
    zanka
    (0, 0, 1) (* (i, f0, f1) *)
    (fun (i, f0, f1) -> i < n)
    (fun (i, f0, f1) -> (i+1, f1, f0+f1))
    (fun (_, f0, f1) -> f0)


(* FOR-ZANKA *)
(*
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

let vsota5 n =
    forzanka
    (0) (* sum *)
    (0)
    (n)
    (fun i sum -> sum + i)
    (fun sum -> sum)

let fibonacci5 n =
    forzanka
    (0, 1)
    (0)
    (n-1)
    (fun i (f0, f1) -> (f1,f0+f1))
    (fun (f0, f1) -> f0)
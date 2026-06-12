let vipavsko n = 
  match n with
  | 0 -> 0
  | 1 -> 1
  | _ ->
    let rec vip_rec i xnMinus2 xnMinus1 = 
      if i < n then 
        vip_rec (i+1) xnMinus1 (xnMinus2-2*xnMinus1)
      else
        xnMinus1
    in
    vip_rec 1 0 1 

let zaporedje (a:int) (b:int) (f:int->int->int) (n:int):int = 
  match n with
  | 0 -> a
  | 1 -> b
  | _ ->
    let rec zap_rec i xnMinus2 xnMinus1 =
      if i < n then
        zap_rec (i+1) xnMinus1 (f xnMinus2 xnMinus1)
      else
        xnMinus1
      in
      zap_rec 1 a b
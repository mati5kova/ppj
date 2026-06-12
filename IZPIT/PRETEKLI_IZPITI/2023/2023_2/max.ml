let func = fun k -> k*(20-k)

let najvecji (f:int->int) (n:int):int = 
  if n < 1 then failwith "not (n ≥ 1)"
  else
    let rec najvecji_rec curr_m i = 
      if i > n then curr_m
      else
        if curr_m < (f i) then najvecji_rec (f i) (i+1)
        else
          najvecji_rec curr_m (i + 1)
    in
    najvecji_rec (f 1) 2
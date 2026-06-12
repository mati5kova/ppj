let temp = 
  let rec f s a b =
    if a > 0 then 
      f ((a <= b) :: s) (a - 1) b
    else 
      s
    in f []
```
[ y > 0 ]
x := 0 ;
[ x=0 ]
c := 0 ;
[ x=0 in c=0 in c=x*x*x]
while y > c do
    [ y > c in c=x*x*x ]
    [ y > c in c=(x+1-1)*(x+1-1)*(x+1-1) ]
    x := x + 1 ;
    [ y > c in c=(x-1)*(x-1)*(x-1) ]
    c := x * x * x
    [ c=x * x * x ]
end
[ y ≤ c in c=x*x*x ]
if y < c then
    [ y < c in c=x*x*x ]
    x := 0;
    [ y < c in x=0 ]
    y := 0
    [ y=0 in x=0 ]
else
    [ not(y<c) in y ≤ c in c=x*x*x ]
    [ y = c in c = x*x*x ]
    [ y = x*x*x ]
    skip
    [ y = x*x*x ]
end
[ x=0 in y=0 ALI y=x*x*x ]
[ x = cube_root(y) ]
```

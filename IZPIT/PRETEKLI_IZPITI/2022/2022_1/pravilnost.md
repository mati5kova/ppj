```
{ true }
{ p=p }
x := p ;
{ x=p in q=q }
y := q ;
{ x=p in y=q in I } { q ≤ y in x ≤ p in x+y=p+q }
while not (x = y) do
    { x!=y in q ≤ y in x ≤ p in x+y=p+q }
    { x-1!=y-1 in q ≤ y in x-1 ≤ p-1 in x-1+y=p+q-1 }
    x := x - 1 ;
    { x!=y-1 in q ≤ y in x ≤ p-1 in x+y=p+q-1 }
    { x+1!=y+1-1 in q+1 ≤ y+1 in x ≤ p-1 in x+y+1=p+q-1+1 }
    y := y + 1
    { x+1!=y-1 in q+1 ≤ y in x ≤ p-1 in x+y=p+q }
done
{ x=y in x+y=p+q }
{ 2x=p+q }
{ x = (p+q)/2 }
```

```
{ x = m ∧ y = n }
{ x = m in y = n in x + y = m + n }
x := x + y;
{ x = m + n in x - y = (m + n) - n }
y := x - y;
{ x = m + n in y = m } =>
{ x - y = (m+n)-m }
x := x - y;
{ x = n in y = m }
{ x = n ∧ y = m }
```

```
{ }
if y < x then
    { y < x in x = x }
    z := x;
    { y < z in y = y in z = x}
    x := y;
    { x < z in z = x }
    y := z
    { x < y }
    { x ≤ y }
else
    { ¬(y < x) }
    <=>
    { x ≤ y }
    skip
    { x ≤ y }
end
{ x ≤ y }
```

```
{ n ≥ 0 }
{ n ≥ 0 in 0=0 }
s := 0 ;
{ n ≥ 0 in s=0 in 1=1 }
i := 1 ;
{ n ≥ 0 in s=0 in i=1 in s = 1 + 2 + ... + (i-1) in i ≤ n + 1 }
while i <= n do
    { i ≤ n in s = 1 + 2 + ... + (i-1) in i ≤ n + 1}
    { s + i = 1 + 2 + ... + (i - 1) + i }
    s := s + i ;
    { s = 1 + 2 + ... + (i - 1) + i }
    { s = 1 + 2 + ... + (i+1) - 1 in i + 1 ≤ n + 1 }
    i := i + 1
    { s = 1 + 2 + ... + (i - 1) in i ≤ n + 1 }
done
{ ¬(i ≤ n) in s = 1 + 2 + ... + (i - 1) in i ≤ n + 1}
<=>
{ s = 1 + 2 + ... + (i - 1) in n < i ≤ n + 1 }
<=>
{ s = 1 + 2 + ... + (i - 1) in i - 1 = n }
{ s = 1 + 2 + ... + n }
```

```
{ x ≥ 0 }
{ x ≥ 0 in 0=0 }
y := 0;
{ x ≥ 0 in y = 0  in x=x }
z := x;
{ x ≥ 0 in y = 0 in z = x in z ≥ 0 in y² ≤ x ≤ z² }
while 1 < z - y do
  { i < z - y in y² ≤ x ≤ z² }
  s := (y + z)/2;
  { s = (y+z)/2 in i < z - y in y² ≤ x ≤ z² }
  if s * s < x then
    { s^2 < x in s=s in s = (y+z)/2 in i < z - y in s² ≤ x ≤ z² }
    y := s
    { y = s in y^2 < x }
  else
    { ¬(s^2 < x) }
    { s^2 ≥ x in s=s }
    z := s
    { z = s in x ≤ z^2  }
  end
  { y² ≤ x ≤ z² }
done
{ y² ≤ x ≤ z² in ¬(1 < z-y) }
{ y² ≤ x ≤ z² in 1 ≥ z - y }
{ y² ≤ x ≤ z² in y+1 ≥ z }
{ y² ≤ x ≤ z² in (y+1)^2 ≥ z^2 }
{ y² ≤ x ≤ (y+1)² }
```

naredi se to:

```
[ y > 0 ]
x := 0 ;
c := 0 ;
while y > c do
  x := x + 1 ;
  c := x _ x _ x
end
if y < c then
  x := 0 ;
  y := 0
else
  skip
end
[ x = ∛y ]
```

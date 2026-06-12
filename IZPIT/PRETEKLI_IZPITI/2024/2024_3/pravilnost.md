```
{ }
i = 0 ;
{ i = 0 }
m = 1 ;
{ i = 0 in m = 1 in m = 2^i }
while i < 32 do
    { i < 32 in m = 2^i }
    { i + 1 < 32 + 1 in m*2 = 2^(i+1) } =>
    i := i + 1 ;
    { i < 33 in m*2 = 2^i }
    m := m * 2
    { i < 33 in m = 2^i }
done
{ i = 32 in m = 2^i }
{ i = 32 in m = 2^i in m = 2^32 in 0 ≤ i < m in m = 2^32 }
while i != 100 do
    { i != 100 in 0 ≤ i < m in m = 2^32 }
    { i + 3 != 100 + 3 in 0 +3 ≤ i +3 < m+3 in m = 2^32 }
    i := i + 3 ;
    { i != 103 in 3 ≤ i < m+3 in m = 2^32 }
    if i >= m then
        { i >= m in 3 ≤ i ≤ m + 3 in m = 2^32 }
        { i - m >= m-m in 0 ≤ i - m ≤ m + 3 - m in m = 2^32 }
        i := i - m
        { 0 ≤ i - m < 3 in m = 2^32 }
        { 0 ≤ i < m in m = 2^32 }
    else
        { 3 ≤ i < m+3 in m = 2^32 }
        pass
        { 3 ≤ i < m+3 in m = 2^32 }
    end

done
{ i = 100, m = 2^32 }
```

POPOLNA PRAVILNOST PROGRAMA VELJA

- v drugi zanki se po veljavnem pogoju `i ≥ m` i nahaja na intervalu [0, 3)
- ko bo enkrat i=1 (kar bo), bo po 33ih iteracijah i=100 in zanka se bo koncala

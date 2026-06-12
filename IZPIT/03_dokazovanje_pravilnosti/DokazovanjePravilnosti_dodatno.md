1. [SKRIPTA](../ppj-skripta/03-dokazovanje-pravilnosti/03-dokazovanje-pravilnosti.md)

### Naloga: pravilnost I

Pojasni, kaj o programu `P` pove izjava

    [ true ]
    P
    [ false ]

#### Rešitev

Program `P` se ustavi, po koncu izvajanja pa velja `false`. Tak program ne obstaja.

### Naloga: pravilnost II

Dokaži delno pravilnost programa:

    { x > 2 }
    y := x + 1
    if x > y then
        z := x*x - y*y
    else
        z := y*y - x*x
    end
    { 1 ≤ z }

#### Rešitev

    { x > 2 }
    y := x + 1
    { x > 2 ∧ y = x + 1 }
    if x > y then
        { x > 2 ∧ y = x + 1 ∧ x > y }
        z := x*x - y*y
        { z = x² - y² ∧ x > 2 ∧ y = x + 1 ∧ x > y }  # A
    else
        { x > 2 ∧ y = x + 1 ∧ x ≤ y }
        z := y*y - x*x
        { z = y² - x² ∧ x > 2 ∧ y = x + 1 ∧ x ≤ y }
        { z = (x+1)² - x² ∧ x > 2 }
        { z = x² + 2x + 1 - x² ∧ x > 2 }
        { z = 2x + 1 ∧ x > 2 }
        { z > 5 ∧ x > 2 }  # B
    end
    # velja: (A ⇒ 1 ≤ z) ∧ (B ⇒ 1 ≤ z), ker A ⇔ false
    { 1 ≤ z }

### Naloga: pravilnost III

Dokaži delno pravilnost programa:

    { 0 ≤ x ∧ 0 ≤ y ∧ 0 ≤ z }
    if x < y then
      if x < z then
        m := x
      else
        m := z
      end
    else
      if y <= z then
         m := y
      else
         m := z
      end
    end
    { 0 ≤ m ≤ x }

#### Rešitev

    { 0 ≤ x ∧ 0 ≤ y ∧ 0 ≤ z }
    if x < y then
      { 0 ≤ x ∧ 0 ≤ y ∧ 0 ≤ z ∧ x < y }
      if x < z then
        { 0 ≤ x ∧ 0 ≤ y ∧ 0 ≤ z ∧ x < y ∧ x < z }
        m := x
        { 0 ≤ x ∧ 0 ≤ y ∧ 0 ≤ z ∧ x < y ∧ x < z ∧ m = x }
        { 0 ≤ m ≤ x }
      else
        { 0 ≤ x ∧ 0 ≤ y ∧ 0 ≤ z ∧ x < y ∧ x ≥ z }
        m := z
        { 0 ≤ x ∧ 0 ≤ y ∧ 0 ≤ m ∧ x < y ∧ x ≥ m }
        { 0 ≤ m ≤ x }
      end
      { 0 ≤ m ≤ x }
    else
      { 0 ≤ x ∧ 0 ≤ y ∧ 0 ≤ z ∧ x ≥ y }
      if y <= z then
        { 0 ≤ x ∧ 0 ≤ y ∧ 0 ≤ z ∧ x ≥ y ∧ y ≤ z }
        m := y
        { 0 ≤ x ∧ 0 ≤ m ∧ 0 ≤ z ∧ x ≥ m ∧ m ≤ z }
        { 0 ≤ m ≤ x }
      else
        { 0 ≤ x ∧ 0 ≤ y ∧ 0 ≤ z ∧ x ≥ y ∧ y > z }
        m := z
        { 0 ≤ x ∧ 0 ≤ y ∧ 0 ≤ z ∧ x ≥ y ∧ y > z ∧ m = z }
        { 0 ≤ m ≤ x }
      end
      { 0 ≤ m ≤ x }
    end
    { 0 ≤ m ≤ x }

### Naloga: pravilnost IV

Dokažite delno pravilnost programa:

    { 0 < a ∧ 0 < b }
    k := 0
    while not (a * k = b) do
      k := k + 1
    done
    { b = a * k }

Ali velja tudi popolna pravilnost? (Se pravi, da `{ ⋯ }` nadomestimo z `[ ⋯ ]`.) Odgovor utemeljite.

#### Rešitev

Negacija zančnega pogoja je enaka končnemu pogoju: če se zanka izteče, mora veljati končni pogoj.

    { 0 < a ∧ 0 < b }
    k := 0
    while not (a * k = b) do
      k := k + 1
    done
    { a * k = b }

Popolna pravilnost ne velja; program se zacikla, če `a` ne deli `b`.

### Naloga: pravilnost V

Dokažite popolno pravilnost programa:

    [ 0 < a ∧ 0 < b ]
    k := 0
    while a * k < b do
      k := k + 1
    done
    [ a * (k - 1) < b ≤ a * k ]

#### Rešitev

Najprej pokažemo delno pravilnost:

    { 0 < a ∧ 0 < b }
    k := 0
    { 0 < a ∧ 0 < b ∧ k = 0 }
    { a * (k - 1) < b }  # zančna invarianta
    while a * k < b do
      { a * (k - 1) < b ∧ a * k < b }
      { a * (k + 1 - 2) < b ∧ a * (k + 1 - 1) < b }
      k := k + 1
      { a * (k - 2) < b ∧ a * (k - 1) < b }
      { a * (k - 1) < b }  # po tem, ko se izvede telo zanke, invarianta še zmeraj velja
    done
    { a * (k - 1) < b ∧ ¬(a * k < b) }
    { a * (k - 1) < b ≤ a * k }

Za popolno pravilnost pokažemo, da se količina `d = b - k*a` zmanjšuje (in je navzdol omejena z zančnim pogojem):

    while a * k < b do
      { 0 < a ∧ d = b - k*a }
      { 0 < a ∧ d - a = b - (k+1)*a }
      k := k + 1
      { 0 < a ∧ d - a = b - k*a }  # d - a < d
    done

### Naloga: pravilnost VI

```
{ 0 < n }
k := 1;
while k*k < n do
    k := k + 1
done
{ (k-1)^2 < n < k^2 }
```

### Rešitev

```
{ 0 < n }
{ 0 < n in 1 = 1 }
k := 1;
{ 0 < n in k = 1 in (k-1)^2 < n}
while k*k < n do
    { (k-1)^2 < n in k^2 < n } =>
    { ((k+1) - 2)^2 < n in ((k+1)-1)^2 < n }
    k := k + 1
    { (k-2)^2 < n in (k-1)^2 < n }
    { (k-1)^2 < n }
done
{ ¬(k^2 < n) in (k-1)^2 < n } =>
{ n ≤ k^2 in (k-1)^2 < n} =>
{ (k-1)^2 < n < k^2 }
```

1. [SKRIPTA](../SKRIPTA/02-ukazni-programski-jezik/02-ukazni-programski-jezik.md)
2. [Ekvivalenca programov](#ekvivalenca-programov)
3. [Pretvorba zanke `for` v zanko `while`](#pretvorba-zanke-for-v-zanko-while)
4. [Odstranjevanje mrtve kode](#odstranjevanje-mrtve-kode)
5. [Odstranjevanje ukaza `break`](#odstranjevanje-ukaza-break)
6. [Splošni postopek za odstranjevanje `break`-a](#splošni-postopek)

V teh vajah obravnavamo kodo, ki sestoji _samo_ iz majhnega delčka jave:

- osnovnih aritmetičnih in boolovih izrazov
- ukaza `print(e)`, ki je okrajšava za `System.out.print`
- prireditvenega stavka `x = e`
- zaporedja ukazov `A ; B`
- pogojnega stavka `if (P) { A } else { B }`
- in zanke `while (P) { A }` ter ukaza `break`

### Ekvivalenca programov

Ali so naslednji pogrami ekvivalentni?

1.  `a = a ^ b; b = a ^ b; a = a ^ b;`
2.  `temp = a; a = b; b = temp;`
3.  `temp = b; b = a; a = temp;`
4.  `a = a + b; b = a - b; a = a - b;`
5.  `x[i] = x[i] ^ x[j]; x[j] = x[i] ^ x[j]; x[i] = x[i] ^ x[j];`
6.  `temp = x[i]; x[i] = x[j]; x[j] = temp;`
7.  `temp = x[j]; x[j] = x[i]; x[i] = temp;`
8.  `x[i] = x[i] + x[j]; x[j] = x[i] - x[j]; x[i] = x[i] - x[j];`
9.  `if (i != j) { x[i] = x[i] ^ x[j]; x[j] = x[j] ^ x[i]; x[i] = x[i] ^ x[j]; }`

#### Rešitev

Opazimo:

- `[a ↦ 1, b ↦ 2, temp ↦ 3] a = a ^ b; b = a ^ b; a = a ^ b; [a ↦ 2, b ↦ 1, temp ↦ 3]`
- `[a ↦ 1, b ↦ 2, temp ↦ 3] temp = a; a = b; b = temp; [a ↦ 2, b ↦ 1, temp ↦ 1]`
- `[a ↦ 1, b ↦ 2, temp ↦ 3] temp = b; b = a; a = temp; [a ↦ 2, b ↦ 1, temp ↦ 2]`
- `[a ↦ 1, b ↦ 2, temp ↦ 3] a = a + b; b = a - b; a = a - b; [a ↦ 2, b ↦ 1, temp ↦ 3]`

Posledično, sta izmed prvih štiri programov mogoče ekvivalentna le 1. in 4. program. Ker 1. in 4. program spreminjata le spremenljivki `a` in `b`, je za njuno ekvivalentnost potrebno pokazati le, da programa okolje `[a ↦ α, b ↦ β]` (`α` in `β` sta poljubni celi števili) spremenita na enak način:

- `[a ↦ α, b ↦ β] a = a ^ b; [a ↦ α ⊕ β, b ↦ β] b = a ^ b; [a ↦ α ⊕ β, b ↦ (α ⊕ β) ⊕ β = α] a = a ^ b; [a ↦ (α ⊕ β) ⊕ α = β, b ↦ α]` (tu smo upoštevali, da za XOR po bitih (bitwise XOR), velja `α ⊕ α = 0`, `α ⊕ 0 = α`, `α ⊕ β = β ⊕ α`, in `(α ⊕ β) ⊕ γ = α ⊕ (β ⊕ γ)`).
- `[a ↦ α, b ↦ β] a = a + b; [a ↦ α + β, b ↦ β] b = a - b; [a ↦ α + β, b ↦ (α + β) - β = α] a = a - b; [a ↦ (α + β) - α = β, b ↦ α]`.

Programi 5.-9. niso ekvivalentni programom 1.-4. Na podoben način, kot za programe 1.-4. lahko pokažemo, da med programi 5.-9. sta ekvivalentna le 5. in 8. program, kjer upoštevamo:

- `[i ↦ σ, j ↦ σ, x[i] ↦ α, x[j] ↦ β] 5. [i ↦ σ, j ↦ σ, x[i] ↦ 0, x[j] ↦ 0]`
- `[i ↦ σ, j ↦ σ, x[i] ↦ α, x[j] ↦ β] 8. [i ↦ σ, j ↦ σ, x[i] ↦ 0, x[j] ↦ 0]`
- `[i ↦ σ, j ↦ σ, x[i] ↦ α, x[j] ↦ β] 9. [i ↦ σ, j ↦ σ, x[i] ↦ β, x[j] ↦ α]`
- `[i ↦ σ, j ↦ δ ≠ σ, x[i] ↦ α, x[j] ↦ β] 5. [i ↦ σ, j ↦ σ, x[i] ↦ β, x[j] ↦ α]`
- `[i ↦ σ, j ↦ δ ≠ σ, x[i] ↦ α, x[j] ↦ β] 8. [i ↦ σ, j ↦ σ, x[i] ↦ β, x[j] ↦ α]`
- `[i ↦ σ, j ↦ δ ≠ σ, x[i] ↦ α, x[j] ↦ β] 9. [i ↦ σ, j ↦ σ, x[i] ↦ β, x[j] ↦ α]`

#### Drugi del

Za vsako celo 32-bitno število `X`, kjer je to mogoče, poišči okolje v katerem sta naslednja programa "ekvivalentna"?

1.                                       while (i > 1) {
            if (i*i + 26 == 15*i) {
                break;
            }
            i = i + 1;
        }
2.                                       i = X;

##### Rešitev

Ker ima enačba `i² -15i + 15 mod 2^(32) = 0` samo dve rešitvi `i = 2` in `i = 13`, lahko prvi program lahko nadomestimo s programom:

    if (i > 2) i = 13;
    if (i > 13) i = (-1 << 31); // -2^31

Za vrednosti `X ∈ {0, 1, 2, 13, -2^31}` je eno izmed okolij v katerem sta programa 1. in 2. "ekvivalentna" `[i ↦ X]`. Za druge vrednosti `X`, tako okolje ne obstaja.

### Pretvorba zanke `for` v zanko `while`

Lahko bi dodali zanko `for`, a je pravzaprav ne potrebujemo. Kako bi zanko

    for (A; P; C) {
        B;
    }

predelali v ekvivalentno kodo, ki uporablja samo `while`?

#### Rešitev

    {
        A;
        while (P) {
            B;
            C;
        }
    }

### Pretvorba zanke `do` v zanko `while`

V `while` predelajte še zanko `do`:

    do {
      A;
    } while (P);

#### Rešitev

    {
        A;
        while (P) {
            A;
        }
    }

## Odstranjevanje mrtve kode

Mrtva koda (angl. _dead code_) je del kode, za katerega zagotovo vemo, da se ne bo izvedel. Tako kodo lahko brez škode odstranimo. Nekaj primerov odstranjevanja mrtve kode:

- Če vemo, da pogoj `P` v `if (P) { A } else { B }` zagotovo velja, potem se `B` ne izvede, zato lahko pogojni stavek poenostavimo v `P ; A`. Če nadalje vemo še, da `P` ne bo sprožil izjeme (zaradi deljenja z `0`), potem lahko poenostavimo kar v `A`.
- Če se v `A ; B` ukaz `A` nikoli ne konča (ali pa je `break`), se `B` ne bo izvedel in ga lahko odstranimo.
- Če ob vstopu v `while (P) { A }` pogoj `P` _ne_ velja, se zanka sploh ne izvede in jo lahko odstranimo.

### Primer 1

Odstranite mrtvo kodo v programu

    print("Kdor to bere je ");
    a = 3;
    if (a * a < 10) {
        print("mula");
    } else {
        print("osel");
    }

#### Rešitev

    print("Kdor to bere je ");
    a = 3;
    print("mula");

### Primer 2

Odstranite mrtvo kodo v programu, kjer ima `n` neznano celoštevilsko vrednost:

    k = n + (n - 1);
    if (k % 2 == 0) {
        print("foo");
    } else {
        print("bar");
    }
    m = k * (-k);
    while (m > 0) {
        m = m - 1;
        print(m);
    }

#### Rešitev 1

    k = n + (n - 1); // se zagotovo izvede
    // opazimo, da je n + (n - 1) vedno liho število, torej se bo izvedel else
    print("bar");
    m = k * (-k); // se zagotovo izvede
    // ker je k liho število, je n * (-n) negativno število,
    // zanka while se ne izvede in jo lahko odstranimo

#### Rešitev 2

Če je n predznačeno celo 32-bitno število:

    k = n + (n - 1); // se zagotovo izvede
    // opazimo, da je n + (n - 1) vedno liho število, kjub morebitnim prelivom (± 2^32), torej se bo izvedel else
    print("bar");
    m = k * (-k); // se zagotovo izvede
    // m' = -k^2 mod 2^32 = -(2*n-1)^2 mod 2^32 = -4*n^2+4*n-1 mod 2^32
    // m = m' - 2^32, če je m' ≥ 2^31 oz. m = m', če m' < 2^31.
    // Potemtakem je m lahko pozitiven. En tak primer je n = 2^29, saj je m' v tem primeru enak (-4*(2^29)^2 + 4*2^29 - 1) mod 2^32 = 2^32 - 1 < 2^31, in je posledično m = 2^32 - 1.
    // Zanka se v nekaterih primerih lahko izvede.
    while (m > 0) {
        m = m - 1;
        print(m);
    }

### Primer 3

Odstranite mrtvo kodo v programu:

    i = 0;
    while (i < 100) {
        if (i % 2 == 0) {
            p = i * (i - 1) * (i - 2);
        } else {
            p = i * (i + 1) * (i + 2);
        }

        if (p % 3 == 0) {
            break;
        } else { }
        i = i + 1;
    }

    if (i >= 100) {
        print("ni zanimivih števil");
    } else {
        print("našel sem zanimivo število " + i);
    }

#### Rešitev

    i = 0;
    while (i < 100) {
        if (i % 2 == 0) {
            p = i * (i - 1) * (i - 2);
        } else {
            p = i * (i + 1) * (i + 2);
        }
        // p je zmnožek treh zaporednih števil, zato je deljiv s 3
        // zagotovo se izvede break
        break;
    }
    // i je enak 0
    print("našel sem zanimivo šetvilo " + i);

Ta program bi lahko še _optimizirali_, ker se zanka `while` izvede samo enkrat. A to ne bi bilo več le odstranjevanje mrtve kode:

    i = 0;
    p = i * (i - 1) * (i - 2);
    print("našel sem zanimivo število " + i);

### Primer 4

Odstranite mrtvo kodo v programu:

    s = 0;
    i = 0;
    while (i < 100) {
        s = s + i;
    }
    print(s);

#### Rešitev

    s = 0;
    i = 0;
    while (i < 100) {
        s = s + i;
    }
    // zanka se nikoli ne konča, print se ne zgodi

### Program, ki odstranja mrtvo kodo

V tej nalogi dodamo še uporabo tabel in funkcij. Dobri prevajalniki se trudijo odstraniti čim več mrtve kode.

> _Ali lahko implementiramo program, ki vedno odstrani **vso** mrtvo kodo?_

Uporabi znanje iz teorije izračunljivosti in naslednjo opazko: če se v programu

    A ;
    B

ukaz `A` nikoli ne konča (se zacikla), potem je `B` mrtva koda.

#### Rešitev

Če bi imeli program `DEAD`, ki vedno odstrani vso mrtvo kodo, bi lahko implementirali program, ki ugotovi, ali se Turingov stroj ustavi. Za dani Turingov stroj `T` bi sestavili program:

    simuliraj(T);
    print("Ali se ustavi?")

nato pa bi s programom `DEAD` ugotovili, ali je stavek `print` mrtva koda. Če je, se stroj `T` ne ustavi, sicer se ustavi. Na ta način bi lahko algoritmično rešili problem zaustavitve (angl. _halting problem_), ki pa ni algoritmično rešljiv.

## Odstranjevanje ukaza `break`

V tej nalogi bomo ugotovili, da se lahko ukaza `break` znebimo. Najprej naredimo nekaj primerov.

### Primer 1

Naslednjo kodo predelajte v enakovredno kodo, ki ne uporablja ukaza `break`, pri čemer ima `n` neznano celoštevilsko vrednost:

    while (n > 0) {
        digit = n % 10;
        if (digit == 7) {
            print(n + " vsebuje števko 7");
            break;
        } else { }
        n = n / 10;
    }

#### Rešitev

    stop = false;
    while (!stop && n > 0) {
        digit = n % 10;
        if (digit == 7) {
            print(n + " vsebuje števko 7");
            stop = true;
        } else { }
        if (!stop) {
            n = n / 10;
        } else { }
    }

### Primer 2

Naslednjo kodo predelajte v enakovredno kodo, ki ne uporablja ukaza `break`.

    // najdi najmanjše popolno število
    n = 1;
    while (true) {
        d = 1;
        vsota = 0; // vsota deliteljev števila n
        while (d < n) {
            if (n % d == 0) {
                vsota = vsota + d;
            } else { }
            if (vsota > n) {
                break;
            } else { }
            d = d + 1;
        }
        if (vsota == n) {
            break;
        } else { }
        print(n + " ni popolno število");
        n = n + 1;
    }
    print("našel popolno število: " + n);

#### Rešitev

    // najdi najmanjše popolno število
    n = 1;
    stop = false;
    while (!stop) {
        d = 1;
        vsota = 0;
        stop = false;
        while (!stop && d < n) {
            if (i % d == 0) {
                vsota = vsota + d;
            } else { }
            if (vsota > n) {
                stop = true;
            } else { }
            if (!stop) {
                d = d + 1;
            } else { }
        }
        stop = false;
        if (vsota == n) {
            stop = true;
        } else { }
        if (!stop) {
            print(n + " ni popolno število");
            n = n + 1;
        } else { }
    }
    print("našel popolno število: " + n);

### Splošni postopek

Opišite splošni postopek za odstranjevanje ukaza `break`. Na papirju definirajte funkcijo `UNBREAK`, ki sprejme program in vrne enakovredni program brez ukaza `break`. Funkcija je rekurzivna.

#### Rešitev

Uvedemo novo boolovo spremenljivko `stop` z začetno vrednostjo `false`. Če se `stop` že pojavlja v kodi, izberemo drugo ime, ki se še ne pojavi.

    UNBREAK(x = e) :=
       x = e

    UNBREAK(print(e)) :=
       print(e)

    UNBREAK(break) :=
       stop = true

    UNBREAK(A ; B) :=
       UNBREAK(A); if (!stop) { UNBREAK(B) } else { }

    UNBREAK(if (P) { A } else { B }) :=
       if (P) { UNBREAK(A) } else { UNBREAK(B) }

    UNBREAK(while (P) { A }) :=
       stop = false;
       while (!stop && P) {
         UNBREAK(A)
       }
       stop = false;

### Izboljšava splošnega postopka

Izboljšajte `UNBREAK` tako, da ne bo po nepotrebnem spreminjal kode.

#### Rešitev

Podobno kot prejšnja rešitev, le da kode ne spremenimo, če ne vsebuje `break`:

    UNBREAK(c) := c    če se break ne pojavi v c (ta primer zaobjema print in x = e)

sicer:

    UNBREAK(break) :=
       stop = true

    UNBREAK(A ; B) :=
       UNBREAK(A); if (!stop) { UNBREAK(B) } else { }

    UNBREAK(if (P) { A } else { B }) :=
       if (P) { UNBREAK(A); } else { UNBREAK(B); }

    UNBREAK(while (P) { A }) :=
       stop = false;
       while (!stop && P) {
         UNBREAK(A);
       }
       stop = false;

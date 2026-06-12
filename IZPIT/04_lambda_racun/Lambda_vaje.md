1. [SKRIPTA](../ppj-skripta/04-lambda-racun/04-lambda-racun.md)
2. [Naloga: seštevanje](#naloga-seštevanje)
3. [Naloga: množenje](#naloga-množenje)
4. [Naloga: odštevanje](#naloga-odštevanje)
5. [Primerjava z 0](#primerjava-z-0)
6. [Relacije <, >, =, ... (ostalo je na dodatnem listu)](#relacija-)
7. [Naloga: deljenje](#naloga-deljenje)

### Primitivna rekurzija

Denimo, da bi radi implementirali rekurzivno funkcijo `g`, ki pri argumentu `0` vrne vrednost `x`,

     g 0 = x

pri argumentu `n+1` pa naredi en rekurzivni na predhodniku `n`:

     g (n+1) = f n (g n)

Pomožna funkcija `f` izračuna končni odgovor s pomočjo `n` in rezultata rekurzivnega klica `g n`. Taki rekurziji pravimo _primitivna_ ali _strukturna rekurzija_ (poznamo tudi _splošno rekurzijo_, v kateri lahko `g` naredi povsem poljubne rekurzivne klice).

Mnoge funkcije lahko izračunamo s pomočjo primitivne rekurzije. Na primer, faktorielo

    n! = 1 · 2 · ⋯ · n

definiramo takole:

    fact 0 = 1
    fact (n+1) = (n+1) · fact n

Kaj je tu `f`? Se pravi, kaj moramo vstaviti za `f`, da bo veljalo

    fact (n+1) = f n (fact n)

Če primerjamo z zgornjo vrstico za `fact (n+1)`, vidimo, da je

    f := λ k r . (k+1) · r

Kako bi to predelali v λ-račun? Z uporabo baze in funkcije `f` nam Church-Scottova števila dajo točno to, kar potrebujemo:

    fact := λ n . n f 1

Če vstavimo `f`, dobimo:

    fact := λ n . n (λ k r . (k+1) · r) 1

Preverimo na primeru, kako to deluje:

    fact 2 = 2 (λ k r . (k+1) · r) 1
           = (λ k r . (k+1) · r) 1 (1 (λ k r . (k+1) · r) 1)
           = (1+1) · (1 (λ k r . (k+1) · r) 1)
           = 2 · ((λ k r . (k+1) · r) 0 (0 (λ k r . (k+1) · r) 1))
           = 2 · ((0+1) · (0 (λ k r . (k+1) · r) 1))
           = 2 · (1 · 1)
           = 2

Scott-Churchova števila v splošnem omogočajo računanje funkcij, ki so definirane s primitivno rekurzijo. Če je `g` definirana kot

    g 0 = x
    g (n+1) = f n (g n)

jo s Scott-Churchovimi števili definiramo kot

    g := λ n . n f x

kjer `f` sprejme dva argumenta, indeks `n` in rezultat rekurzivnega klica `r`, in mora izračunati rezultat za `n+1`:

Primitivno rekurzivne funkcije bomo torej v splošnem implementirali kot

    λ n . n (λ m r . …) x

kjer je `x` baza rekurzije, funkcija `λ m r . …` pa pomožna funkcija, ki pove, kako iz rezultata rekurzivnega klica `r` pri argumentu `m` izračunamo rezultat pri `m+1`.

### Predhodnik

Posebej preprost primer primitivne rekurzije je funkcija predhodnik `pred`. Dogovorimo se, da za predhodnik števila `0` vzamemo kar `0` (v λ-računu ne moremo javiti napake). Primitivno rekurzivna definicija se glasi:

    pred 0 = 0
    pred (n+1) = n

Morda bi kdo rekel, da ta definicija sploh ni rekurzivna. A lahko si mislimo, da je rekurzivna, le da rezultat rekurzivnega klica zavržemo:

    pred 0 = 0
    pred (n+1) = (λ m r . m) n (pred n)

Torej lahko `pred` zapišemo kot

    pred = λ n . n (λ m r . m) 0

Preizkusimo, kako to deluje v `lambda`. Najprej definiramo nekaj Scott-Churchovih števil (kodo sproti preizkušajte v brskalniku):

    0 := ^ f x . x ;
    1 := ^ f x . f 0 x ;
    2 := ^ f x . f 1 (f 0 x) ;
    3 := ^ f x . f 2 (f 1 (f 0 x)) ;
    4 := ^ f x . f 3 (f 2 (f 1 (f 0 x))) ;
    5 := ^ f x . f 4 (f 3 (f 2 (f 1 (f 0 x)))) ;

Nato definiramo `pred`,

    pred := λ n . n (λ m r . m) 0

in preizkusimo:

    lambda> pred 4
    λ f x . f 2 (f 1 (f 0 x))

To ni preveč čitljivo, čeprav se vidi, da smo dobili `3`. Definirajmo si pomožno funkcijo `show`, ki število `n` predela v `n`\-kratno uporabo konstante `S` na konstanti `Z`

    :constant S
    :constant Z
    show := ^ n . n (^ m r . S r) Z ;

in poskusimo še enkrat:

    lambda> show (pred 4)
    S ((λ _ r . S r) ((λ _ r . S r) 0 Z) 1)

To je še slabše, a če vklopimo neučakano računanje, da bo `lambda` vse izračunal do konca, dobimo želeni učinek:

    lambda> :eager
    I will evaluate eagerly.
    lambda> show (pred 4)
    S (S (S Z))

Ko boste preizkušali vaše rešitve, uporabljajte `show`.

### Naloga: naslednik

Kaj pa funkcija naslednik `succ`? Poizkusimo:

    succ 0 = 1
    succ (n+1) = (n+2)

Težava je v tem, da nimamo definicije seštevanja. Funkcijo naslednik moramo implementiramo neposredno, izhajajoč iz definicije Scott-Churchovih števil:

    succ n  =  λ f x . f n (f (n-1) (⋯ f 1 (f 0 x) ⋯)

Torej je

    succ n  =  λ f x . f n (n f x)

**Naloga:** Definirajte `succ` v jeziku `lambda` in ga preizkusite.

#### Rešitev:

    succ := ^ n . ^ f x . f n (n f x) ;

### Naloga: seštevanje

Peanovi aksiomi za seštevanje se glasijo:

    0 + k = k
    succ n + k = succ (n + k)

To je primitivna rekurzija v prvem argumentu, kar je razvidno, če namesto `a + b` pišemo `plus a b`:

    plus 0 k = k
    plus (n+1) k = succ (plus n k)

Predelajmo jo tako, da je razvidna pomožna funkcija `f`:

    plus 0 k = k
    plus (n+1) k = (λ m r . succ r) n (plus n k)

Jezik `lambda` nam omogoča, da namesto `plus a b` pišemo `+ a b`, kar bomo tudi naredili:

    + 0 k = k
    + (n+1) k = (λ m r . succ r) n (+ n k)

**Naloga:** V `lambda` definirajte funkcijo `+` in jo preizkusite.

#### Rešitev

    + := ^ n k . n (^ m r . succ r) k ;

### Naloga: množenje

Peanovi aksiomi za množenje se glasijo

    0 · k = 0
    (succ n) · k = k + n · k

**Naloga:** V `lambda` definirajte množenje `*` in ga preizkusite. Seveda je treba namesto `a * b` pisati `* a b`. Kako veliko število lahko izračunate, ne da bi vaš brskalnik pokleknil pod težo izredno neučinkovite implementacije aritmetike? (Če boste izzivali vaš brskalnik, da bo crknil, si rešitve najprej shranite v ločeno datoteko.)

#### Rešitev

    * := ^ n k . n (^ m r . + k r) 0 ;

### Naloga: odštevanje

Odštevanje lahko rekurzivno definiramo s pomočjo predhodnika. Dogovorimo se, da je `n - m` enak `0`, če je `m` večji od `n`. Tedaj dobimo:

    n - 0 = n
    n - (k+1) = pred (n - k)

Tokrat imamo primitivno rekurzijo na drugem argumentu, saj se v rekurzivnem klicu zmanjša `k`.

**Naloga:** V `lambda` definirajte odštevanje in ga preizkusite.

#### Rešitev

    - := ^ n k . k (^ m r . pred r) n ;

### Primerjava z `0`

Tudi predikate lahko definiramo s primitivno rekurzijo. Na primer, da želimo funkcijo `iszero`, ki vrne `true`, če je njen argument `0`, sicer `false`:

    iszero 0 = true
    iszero (n+1) = false

Tudi to je primitivna rekurzija, čeprav rekurzivnega klica ne vidimo! Lahko si mislimo, da je bil rekurzivni klic zavržen:

    iszero 0 = true
    iszero (n+1) = (λ m r . false) n (iszero n)

Od tod dobimo definicijo v jeziku `lambda`:

    iszero := ^ n . n (^ m r . false) true ;

### Relacija `≤`

Sedaj smo že zgradili nekaj osnovnih funkcij, s pomočjo katerih lahko definiramo nove, ne da bi vedno znova uporabljali primitivno rekurzijo. Denimo, relacijo `a ≤ b` lahko sestavimo s pomočjo odštevanja in `iszero`, ker velja

    a ≤ b  ⇔  a-b = 0

Pri tem smo s pridom upoštevali dejstvo, da smo definirali `a - b = 0`, če je `a < b`.

**Naloga:** v `lambda` definirajte funkcijo `<=`, tako da je `<= a b` enako `true`, če je `a` manjši ali enak `b`, sicer pa `false`. Uporabite že prej definirani funkciji `-` in `iszero`.

#### Rešitev

    <= := ^ n m . iszero (- n m) ;

### Relaciji `<` in `=`

Definirajte še funkcijo `<`, ki računa relacijo "strogo manjše". Namig:

    a < b  ⇔  a+1 ≤ b

Definirajte tudi funkcijo `==`, ki ugotovi, ali sta števili enaki.

#### Rešitev:

    < := ^ n m . <= (succ n) m ;
    == := ^ n m . and (<= n m) (<= m n) ;

### Naloga: iskanje števila, ki zadošča pogoju

Denimo, da imamo predikat `p`, ki za vsako število vrne `true` ali `false` in da želimo med števili `1`, `2`, …, `n-1` poiskati največje, ki zadošča `p`. Če takega števila ni, vrnemo `0`. To lahko izrazimo z rekurzivno funkcijo `find`:

- `find p 0` je enako `0`, ker ni števila med `1` in `-1`
- `find p (n+1)` je enak `n`, če velja `p n` enako `true`
- `find p (n+1)` je enak `find p n`, če ne velja `p n`

**Naloga:** Definirajte funkcijo `find`, ki sprejme predikat `p` in število `n`. Funkcija vrne največje izmed števil `1`, `2`, …, `n-1`, ki zadošča pogoju `p`. Če takega števila ni, naj vrne `0`. Funkcijo preizkusite na naslednjih primerih:

- med števili od `1` do `5` poišči največje število, ki je manjše od `3`:

                                  lambda> show (find (^ k . < k 3) 5)
                                  S (S Z)

- med števili od `1` do `5` poišči (največje) število, katerega kvadrat je enak devet:

                                  lambda> show (find (^ k . == (* k k) (+ 4 5)) 5)
                                  S (S (S Z))

#### Rešitev:

    find := ^ p n . n (^ m r . if (p m) m r) 0 ;

### Naloga deljenje

Definirajte funkcijo `/`, ki deli naravna števila. Če se deljenje ne izide, naj funkcija vrne `0`. Pri tej nalogi se je lahko zmotiti, da deljenje z `1` ne deluje pravilno, zato vsekakor preizkusite `/ 5 1`, ki mora vrniti `5`.

#### Rešitev:

    / := ^ n m . find (^ k . == (* m k) n) (succ n) ;

0. [SKRIPTA](../ppj-skripta/07-izpeljava-tipov/07-izpeljava-tipov.md)
1. [fun x -> fun y -> (x, y, y)](#naloga-1)
2. [fun f -> fun g -> f (g 42)](#naloga-2)
3. [if 3 < 5 then (fun x -> x) else (fun y -> (y, y))](#naloga-3)
4. [let rec f x = (if x = 0 then 1 else x \* f (x - 1))](#naloga-4)
5. [let rec map f l = match l with | [] -> [] | x :: xs -> f x :: map f xs](#naloga-5)

## Naloga 1

Izpeljite glavni tip izraza

    fun x -> fun y -> (x, y, y)

### Rešitev

Uvedemo nov parameter `α` in zabeležimo `x : α`. Funkcija ima tip `α → β`, kjer je `β` tip izraza `fun y -> (x, y, y)`.

Tip izraza `fun y -> (x, y, y)`: uvedemo nov parameter `δ` in zabeležimo `y : δ`. Tip izraza `(x, y, y)` je tako `α × δ × δ`. Funkcija `fun y -> (x, y, y)` ima torej tip `δ → α × δ × δ`. Dobimo enačbo `β = δ → α × δ × δ`.

V tipu `α → β` zamenjamo `β ↦ δ → α × δ × δ`, da dobimo glavni tip izraza:

    α → δ → α × δ × δ

## Naloga 2

Izpeljite glavni tip izraza

    fun f -> fun g -> f (g 42)

### Rešitev

Uvedemo nov parameter `α` in zabeležimo `f : α`. Funkcija ima tip `α → β`, kjer je `β` tip izraza `fun g -> f (g 42)`.

Tip funkcije `fun g -> f (g 42)`: uvedemo nov parameter `γ` in zabeležimo `g : γ`. Funkcija ima tip `γ → δ`, kjer je `δ` tip izraza `f (g 42)`. Dobimo enačbo `β = γ → δ`.

Tip izraza `f (g 42)` je `δ`, zato mora imeti funkcija `f` tip `ε → δ`, kjer je `ε` tip izraza `g 42`. Dobimo enačbo `α = ε → δ`.

Tip izraza `g 42` je `ε`, zato mora imeti funkcija `g` tip `int → ε`. Dobimo enačbo `γ = int → ε`.

Imamo naslednje enačbe:

    α = ε → δ
    β = γ → δ
    γ = int → ε

Upoštevamo definicijo `γ`:

    α = ε → δ
    β = int → ε → δ

In dobimo glavni tip celega izraza `α → β = (ε → δ) → (int → ε) → δ`.

## Naloga 3

Izpeljite glavni tip izraza

    if 3 < 5 then (fun x -> x) else (fun y -> (y, y))

### Rešitev

Tip lahko izpeljemo po kosih: posebej obravnavamo pogoj `3 < 5`, kjer preverimo, da je tip `bool`, nato pa izpeljemo tipa obeh vej in ju izenačimo.

Izraz `3 < 5` res ima tip `bool`, ker `3` in `5` imata tip `int` in `<` res vrne `bool`.

Tip funkcije `fun x -> x`: uvedemo nov parameter `α` in zabeležimo `x : α`. Nato izpeljemo tip izraza `x`, ki je seveda `α`. Torej ima `fun x -> x` tip `α → α`.

Tip funkcije `fun y -> (y, y)`: uvedemo nov parameter `β` in zabeležimo `y : β`. Nato izpeljemo tip izraza `(y, y)`. To je urejeni par, obe komponenti imata tip `β`, zato je tip urejenega para `(y, y)` enak `β × β`. Torej ima `fun y -> (y, y)` tip `β → β × β`.

Izenačimo tipa obeh vej:

    (α → α) = (β → β × β)

To je tudi edina enačba, ki jo moramo rešiti. Enačbo razbijemo na dve preprostejši enačbi:

    α = β
    α = β × β

Prva enačba nam da rešitev `α ↦ β`, ki jo upoštevamo v drugi enačbi:

    β = β × β

Ta enačba nima rešitve, ker se `β` pojavi na desni strani. Končni odgovor: izraz nima tipa.

## Naloga 4

Izpeljite glavni tip rekurzivne funkcije

    let rec f x = (if x = 0 then 1 else x * f (x - 1))

### Rešitev

Uvedemo parameter `α` in zabeležimo `f : α`.

Izraz `fun x -> if x = 0 then 1 else x * f (x - 1)` ima tip `β → γ`, pri čemer zabeležimo `x : β` in enačbo `α = β → γ`. Nato obravnavamo izraz `if x = 0 then 1 else x * f (x - 1)`.

Iz pogoja dobimo enačbo `β = int`.

Tip izraza `x * f (x - 1)`: izraz `x - 1` ima tip `int`, zato mora imeti `f` tip `int → γ`. Dobimo enačbo `α = int → γ`. Po drugi strani mora zaradi množenja imeti izraz`f (x - 1)` tip `int`, torej dobimo `γ = int`. Preveriti moramo še, da imata obe veji pogojnega stavka isti tip in da ima pogoj `x = 0` res tip `bool`.

Glavni tip `α` celega izraza je tako `int → int`.

## Naloga 5

Izpeljite glavni tip funkcije `map`:

    let rec map f l =
        match l with
        | [] -> []
        | x :: xs -> f x :: map f xs

Navodilo: uporabite pravilo za rekurzivne funkcije, ter pravila za sezname in `match`:

- prazen seznam `[]` ima tip `α list`, kjer je `α` nov parameter
- sestavljen seznam `e₁ :: e₂`:
    - izpeljemo tip `τ₁` izraza `e₁` in dobimo enačbe `E₁`
    - izpeljemo tip `τ₂` izraza `e₂` in dobimo enačbe `E₂`

    Tip `e₁ :: e₂` je `τ₁ list`, z enačbami `E₁`, `E₂` in `τ₂ = τ₁ list`.

- izraz `match e₁ with [] -> e₂ | x :: xs -> e₃`:
    - izpeljemo tip `τ₁` izraza `e₁` in dobimo enačbe `E₁`
    - izpeljemo tip `τ₂` izraza `e₂` in dobimo enačbe `E₂`
    - uvedemo nov parameter `α`, zabeležimo `x : α` in `xs : α list`, izpeljemo tip `τ₃` izraza `e₃` in dobimo enačbe `E₃`

    Tip izraza `match e₁ with [] -> e₂ | x :: xs -> e₃` je `τ₂` z enačbami `E₁`, `E₂`, `E₃`, `τ₁ = α list` in `τ₂ = τ₃`.

### Rešitev

Tip `map` označimo z `α`, tip `f` z `β` in `l` z `γ`. Nato izračunamo tip izraza `match`.

Prvi primer ima tip `δ list`, pri čemer je `δ` nov parameter.

Za drugi primer moramo izračunati tip izraza `f x :: map f xs`, pri čemer uvedemo nov parameter `ε` in zabeležimo `x : ε` in `xs : ε list`. Tip izraza `f x` označimo s `φ₁` in zapišemo enačbo `β = ε → φ₁`. Tip izraza `map f xs` označimo s `φ₂` in zapišemo enačbo `α = β → ε list → φ₂`. Tip celotnega izraza je `φ₁ list`, pri čemer mora veljati še `φ₂ = φ₁ list`.

Tip izraza `match` je torej `φ₂`, pri čemer morata veljati še enačbi `γ = ε list` in `δ list = φ₁ list`.

    α = β → ε list → φ₂
    β = ε → φ₁
    δ list = φ₁ list
    φ₂ = φ₁ list

Iz teh enačb dobimo tip funkcije `map`: `α = (ε → φ₁) → ε list → φ₁ list`.

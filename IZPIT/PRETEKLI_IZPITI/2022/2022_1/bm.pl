:- use_module(library(clpfd)).

zacetne_zaloge([a/10, b/3, c/0, d/5, e/1, m/3, g/2]).
cesta(a, b, 8).
cesta(b, c, 3).
cesta(c, d, 4).
cesta(a, e, 6).
cesta(e, m, 9).
cesta(m, g, 3).
cesta(g, d, 5).
cesta(g, b, 4).

sprazni(_, [], []) :- !.
sprazni(V, [V/_ | T], [V/0 | T]) :- !.
sprazni(V, [P/G | T], [P/G | Ret]) :- % P-postaja G-gorivo V-vozlisce
    V \= P,
    sprazni(V, T, Ret).

gorivo_v(_, [], 0) :- !.
gorivo_v(V, [V/L | _], L) :- !.
gorivo_v(V, [P/_ | T], L) :-
    V \= P,
    gorivo_v(V, T, L).

% Vozlisce, trenutno G1orivo, Z1aloge
% pretoci gorivo iz V v avto - novo stanje goriva G2, zaloge Z2
natoci(V, G1, Z1, G2, Z2) :-
    gorivo_v(V, Z1, Gorivo_v_V),
    G2 #= G1 + Gorivo_v_V,
    sprazni(V, Z1, Z2).
    
etapa(V1, G1, Z1, V2, G2, ZalogaPoTocenjuV1) :-
    (
        cesta(V1, V2, PotrebnaKolicinaGoriva)
        ;
        cesta(V2, V1, PotrebnaKolicinaGoriva)
    ),
    natoci(V1, G1, Z1, GorivoZaEtapo, ZalogaPoTocenjuV1),
    GorivoZaEtapo #>= PotrebnaKolicinaGoriva,
    G2 #= GorivoZaEtapo - PotrebnaKolicinaGoriva.

pot([_], G1, Z1, G1, Z1).
pot([V1, V2 | Rest], G1, Z1, G2, Z2) :-
    etapa(V1, G1, Z1, V2, GorivoPoEtapi, ZalogePoEtapi),
    pot([V2 | Rest], GorivoPoEtapi, ZalogePoEtapi, G2, Z2).

% pot([a,e,m,g,b,c,d,g,b,a], 22, zacetne_zaloge, G2, Z2).
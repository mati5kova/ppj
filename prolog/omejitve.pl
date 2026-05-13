:- use_module(library(clpfd)).

% Naloga
meeting(X, Y) :-
    X in 0..22,
    Y in 0..22,
    X + Y #= 22,
    2*X + 4*Y #= 72,
    labeling([], [X, Y]).

% Jedilnik
% Kosilo - sestavljeni iz glavne jedi, priloge, dveh dodatkov ki jih izberemo izmed predjedi, sadja in sladice
kosilo(Seznam) :-
    glavna_jed(GJ),
    priloga(P),
    (
        predjed(Dod1);
        sadje(Dod1);
        sladica(Dod1)
    ),
    (
        predjed(Dod2);
        sadje(Dod2);
        sladica(Dod2)
    ),
    Dod1 @< Dod2,
    Seznam = [GJ, P, Dod1, Dod2].
    
% Vegetarijansko kosilo
vege_kosilo(K) :-
    maplist(vege(), K).
    
% Ustrezno kosilo - preveri ali kosilo K ustreza dolocenim pogojem
% ustrezno_kosilo(Kosilo, MaxCena, MinKalorij, MaxKalorij, MinBeljakovin, MinOH) :-


% PROBLEM N DAM
safe_pair(X1/Y1, X2/Y2) :-
    X1 #\= X2,
    Y1 #\= Y2,
    abs(X1 - X2) #\= abs(Y1 - Y2).
    
safe_list(X/Y, L) :-
    maplist(safe_pair(X/Y), L).
    
safe_list([]).
safe_list([H | T]) :-
    safe_list(T),
    safe_list(H, T).
    
    
place_queens(N, I, L) :-
    I >= N, L = [];
    I < N,
    X is I + 1,
    Y in 1..N,
    L = [X/Y | Vmesni],
    place_queens(N, X, Vmesni).
    
queens(N, L) :-
    place_queens(N, 0, L),
    safe_list(L),
    term_variables(L, Vars),
    label(Vars).
    
    
    
    
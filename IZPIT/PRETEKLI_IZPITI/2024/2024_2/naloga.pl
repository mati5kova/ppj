:- use_module(library(clpfd)).

calc([], _, _) :- false.
calc([Var-Val | _], Var, Val).
calc([Var-Val | T], Expr, ValueOfVar) :-
    Expr \= Var,
    calc(T, Expr, ValueOfVar).


calc(_, Expr, Expr) :- number(Expr).

calc(Env, E1+E2, Result) :-
    calc(Env, E1, Res1),
    calc(Env, E2, Res2),
    Result #= Res1 + Res2.

calc(Env, E1-E2, Result) :-
    calc(Env, E1, Res1),
    calc(Env, E2, Res2),
    Result #= Res1 - Res2.

calc(Env, E1*E2, Result) :-
    calc(Env, E1, Res1),
    calc(Env, E2, Res2),
    Result #= Res1 * Res2.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
odstrani_desnega(X, [X|Xs], Xs) :-
    \+ member(X, Xs).

odstrani_desnega(X, [Y|Xs], [Y|Ys]) :-
    odstrani_desnega(X, Xs, Ys).

odstrani_vse_pojavitve(_, [], []).
odstrani_vse_pojavitve(X, [H | T], NewL) :-
    odstrani_vse_pojavitve(X, T, Temp),
    (
        X = H,
        NewL = Temp
        ;
        X \= H,
        NewL = [H | Temp]
    ).


min([H], H).
min([H | T], Min) :- 
    min(T, TempMin),
    (
    H < TempMin,
    Min = H
    ;
    H >= TempMin,
    Min = TempMin
    ).

min_rest(L, Min, Rest) :- 
    min(L, Min),
    odstrani_desnega(Min, L, Rest).

min2(L, Min1, Min2) :-
    min(L, Min1),
    odstrani_desnega(Min1, L, Temp),
    min(Temp, Min2).
    

odstrani_prvo_ujemanje(_, [], []) :- !.
odstrani_prvo_ujemanje(X, [X | T], T) :- !.
odstrani_prvo_ujemanje(X, [H | T], [H | Temp]) :-
    X \= H,
    odstrani_prvo_ujemanje(X, T, Temp).
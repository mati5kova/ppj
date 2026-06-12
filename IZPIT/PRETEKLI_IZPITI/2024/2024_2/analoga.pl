:- use_module(library(clpfd)).

calc([Var-Val | _], Var, Val).
calc([Var-_ | T], E, Res) :-
    Var \= E,
    calc(T, E, Res).

calc(_, E, E) :- number(E).

calc(Env, E1+E2, Res) :-
    calc(Env, E1, ResE1),
    calc(Env, E2, ResE2),
    Res #= ResE1 + ResE2.

calc(Env, E1*E2, Res) :-
    calc(Env, E1, ResE1),
    calc(Env, E2, ResE2),
    Res #= ResE1 * ResE2.

calc(Env, E1-E2, Res) :-
    calc(Env, E1, ResE1),
    calc(Env, E2, ResE2),
    Res #= ResE1 - ResE2.
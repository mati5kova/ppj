:- use_module(library(clpfd)).
:- use_module(library(lists)).

is_sorted([]) :- !.
is_sorted([_]) :- !.
is_sorted([H1, H2 | T]) :-
    H1 #< H2,
    is_sorted([H2 | T]).

narascajocaVrstica(V) :-
    is_sorted(V).

narascajoca(M) :-
    maplist(narascajocaVrstica, M),
    transpose(M, MT),
    maplist(narascajocaVrstica, MT).
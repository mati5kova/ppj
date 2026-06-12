:- use_module(library(clpfd)).

fib([]).
fib([1, 0]).
fib([H1, H2, H3 | T]) :-
    fib([H2, H3 | T]),
    H1 #= H2 + H3.

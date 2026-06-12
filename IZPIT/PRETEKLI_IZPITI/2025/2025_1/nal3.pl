rule([0 ,0 ,0], 0).
rule([0 ,0 ,1], 1).
rule([0 ,1 ,0], 1).
rule([0 ,1 ,1], 1).
rule([1 ,0 ,0], 1).
rule([1 ,0 ,1], 0).
rule([1 ,1 ,0], 0).
rule([1 ,1 ,1], 0).

last_elem([E], E).
last_elem([_| T], Temp) :-
    last_elem(T, Temp).

conc([], L2, L2).
conc([H | T], L2, [H | Rez]) :-
    conc(T, L2, Rez).

pad([], _) :- false.
pad([H | T], Out) :-
    T \= [],
    last_elem([H | T], ZadnjiIzIn),
    conc([ZadnjiIzIn, H | T], [H], Out).

% [0 ,0 ,0 ,1 ,0 ,0 ,0] -> [0 , 1 , 1 , 1 , 0] 

gen([_,_], []).
gen([A,B,C], [Ret]) :-
    rule([A,B,C], Ret).
gen([A, B, C | Rest], NextState) :-
    Rest \= [],
    gen([B,C | Rest], Temp),
    rule([A,B,C], New),
    NextState = [New | Temp].

next(State, NextState) :-
    pad(State, Padded),
    gen(Padded, NextState).
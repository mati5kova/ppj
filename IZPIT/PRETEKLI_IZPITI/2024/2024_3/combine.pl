:- use_module(library(clpfd)).

conc([], L2, L2).
conc([H | T], L2, [H | Rez]) :-
    conc(T, L2, Rez).

combine([], []).
combine([Seznam | OstaliSeznami], List) :-
    combine(OstaliSeznami, Temp),
    conc(Seznam, Temp, List).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

st_ponovitev(_, [], 0) :- !.
st_ponovitev(X, [H | _], 0) :-
    X #< H.
st_ponovitev(X, [H | T], StPonovitev) :-
    st_ponovitev(X, T, TempSt),
    (
        X #= H,
        StPonovitev #= TempSt + 1,
        !
        ;
        X #\= H,
        StPonovitev #= TempSt,
        !
    ).

liho_ponovitev(X, L) :-
    st_ponovitev(X, L, St),
    St mod 2 #\= 0.
sodo_ponovitev(X, L) :-
    \+ liho_ponovitev(X, L).

odstrani_vse_pojavitve(_, [], []).
odstrani_vse_pojavitve(X, [H | T], NewL) :-
    odstrani_vse_pojavitve(X, T, Temp),
    (
        X #= H,
        NewL = Temp, !
        ;
        X #\= H,
        NewL = [H | Temp], !
    ).

dedup([], []).
dedup([H | T], D) :-
    (
        sodo_ponovitev(H, [H | T]),
        odstrani_vse_pojavitve(H, T, OdstranjenoSodo),
        dedup(OdstranjenoSodo, D), !
        ;
        liho_ponovitev(H, [H | T]),
        odstrani_vse_pojavitve(H, T, OdstranjenoLiho),
        dedup(OdstranjenoLiho, Temp),
        D = [H | Temp], !
    ).
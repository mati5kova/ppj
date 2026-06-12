% popravek in do konca mora biti enako 
% ALI
% rekurzivno naprej brez popravka na trenutni stopnji

popravek([X | Tx], [X | Ty]) :-
    popravek(Tx, Ty).
popravek(X, Y) :-
    X = [_ | Tx],
    Y = Tx.
popravek(X, Y) :-
    X = Ty,
    Y = [_ | Ty].
popravek(X, Y) :-
    X = [Hx | Tx],
    Y = [Hy | Tx],
    dif(Hx, Hy).
popravek(X, Y) :-
    X = [Hx1, Hx2 | Tx],
    Y = [Hx2, Hx1 | Tx],
    dif(Hx1, Hx2).

pravilno([l,o,p,a]).
pravilno([k,o,l,a,r]).
pravilno([l,o,p,a,r]).
pravilno([l,o,p,a,t,a]).
pravilno([o,p,a,t]).
pravilno([r,o,p,a,r]).
pravilno([r,o,p,o,t]).


crkovalnik(X, Y) :-
    pravilno(Y),
    popravek(X, Y).
crkovalnik(X, Y) :-
    pravilno(Y),
    popravek(X, TempY),
    popravek(TempY, Y).

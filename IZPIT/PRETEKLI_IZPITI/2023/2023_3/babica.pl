mati(marija, ivan).
mati(mojca, ana).
mati(ana, peter).
mati(ana, klara).
oce(lojze, ana).
oce(franc, ivan).
oce(ivan, peter).
oce(ivan, klara).

babica(B) :-
    mati(B, A),
    (
        mati(A, _)
        ;
        oce(A, _)
    ).

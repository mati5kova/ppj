:- use_module(library(clpfd)).
:- use_module(library(lists)).

label_vars(Vars) :-
    labeling([], Vars).

nice_corners(A, B, C, D) :-
    (A = B; C = D, A = C; B = D), !.

nice_corners_row([_], [_]) :- !.
nice_corners_row(Row1, Row2) :-
    Row1 = [R1E1, R1E2 | RestRow1],
    Row2 = [R2E1, R2E2 | RestRow2],
    nice_corners(R1E1, R1E2, R2E1, R2E2),
    nice_corners_row([R1E2 | RestRow1], [R2E2 | RestRow2]).

nice_corners([_]) :- !.
nice_corners([Row1, Row2 | Rest]) :-
    nice_corners_row(Row1, Row2),
    nice_corners([Row2 | Rest]).


sum_rows([], []) :- !.
sum_rows([Row | Rest], [Sum | Sums]) :-
    sum(Row, #=, Sum),
    sum_rows(Rest, Sums).

sum_columns(M, V) :-
    transpose(M, Transposed),
    sum_rows(Transposed, V).


is_binary_matrix([]) :- !.
is_binary_matrix([Row | Rest]) :-
    Row ins 0..1,
    is_binary_matrix(Rest).

same_width([], _).
same_width([Row | Rest], Len) :-
    length(Row, Len),
    same_width(Rest, Len).

dungeon(M, H, V) :-
    length(M, NumRows),
    length(H, NumRows),

    length(V, NumCols),
    same_width(M, NumCols),

    is_binary_matrix(M),
    sum_rows(M, H),
    sum_columns(M, V).


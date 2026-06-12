:- use_module(library(lists)).
:- use_module(library(clpfd)).

length9(L) :- length(L, 9).
between1_9(L) :- L ins 1..9.

kvadrati_permutacija([],[],[]).
kvadrati_permutacija(
   [P1, P2, P3 | Ps],
   [Q1, Q2, Q3 | Qs],
   [R1, R2, R3 | Rs]) :-
   all_distinct([P1, P2, P3, Q1, Q2, Q3, R1, R2, R3]),
   kvadrati_permutacija(Ps, Qs, Rs).

sudoku(Rows) :-
    maplist(length9, Rows),
    maplist(between1_9, Rows),
    maplist(all_distinct, Rows),
    transpose(Rows, Columns),
    maplist(all_distinct, Columns),
    Rows = [R1, R2, R3, R4, R5, R6, R7, R8, R9],
    kvadrati_permutacija(R1, R2, R3),
    kvadrati_permutacija(R4, R5, R6),
    kvadrati_permutacija(R7, R8, R9).

find(Rows) :- append(Rows, Vs), label(Vs).

example1([[_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,8,5],
          [_,_,1,_,2,_,_,_,_],
          [_,_,_,5,_,7,_,_,_],
          [_,_,4,_,_,_,1,_,_],
          [_,9,_,_,_,_,_,_,_],
          [5,_,_,_,_,_,_,7,3],
          [_,_,2,_,1,_,_,_,_],
          [_,_,_,_,4,_,_,_,9]]).

% ena valid resitev
example2([[_,1,_,2,_,8,_,_,_],
          [_,_,_,7,_,_,_,2,6],
          [_,_,2,1,4,_,_,9,_],
          [_,_,_,_,_,2,7,_,1],
          [_,_,_,_,_,_,_,_,_],
          [3,_,4,8,_,_,_,_,_],
          [_,3,_,_,2,7,5,_,_],
          [4,8,_,_,_,3,_,_,_],
          [_,_,_,6,_,1,_,3,_]]).

%  ?- example2(R), sudoku(R), find(R), maplist(portray_clause, R).
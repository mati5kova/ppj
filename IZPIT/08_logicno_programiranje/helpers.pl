% 
% 
% SEZNAMI
% 
% 

% insert(X, L1, L2): the list L2 is obtained from L1 by inserting the element X at arbitrary position.
% ?- insert(1, [2,3], L).
%   L = [1,2,3] ;
%   L = [2,1,3] ;
%   L = [2,3,1].
insert(X, [], [X]). 
insert(X, [H|T], L2) :- 
    (
    L2 = [X,H|T]
    ;
    insert(X, T, Temp),
    L2 = [H | Temp]
    ).

% memb(M, L): M is an element of list L.
% ?- memb(X, [1,2,3]).
%   X = 1 ;
%   X = 2 ;
%   X = 3.
% ?- memb(1, [3,2,X]).
%   X = 1.
memb(M, [M | _]).
memb(M, [_|T]) :- 
    memb(M, T).

% del(X, L1, L2): the list L2 is obtained from L1 by deleting element X.
% returns all possible deletions (only one deletion per possibility)
del(X, [X | T], T).
del(X, [H | T], [H | Temp]) :-
    del(X, T, Temp).

% odstrani_prvo_ujemanje(X, L, NewL): the list NewL is obtained from L by deleting the firs occurance of X
% alias: remove, delete, dup, first occurance
odstrani_prvo_ujemanje(_, [], []) :- !.
odstrani_prvo_ujemanje(X, [X | T], T) :- !.
odstrani_prvo_ujemanje(X, [H | T], [H | Temp]) :-
    X \= H,
    odstrani_prvo_ujemanje(X, T, Temp).

% odstrani_desnega(X, L, NewL): NewL je seznam ki ga dobimo ce odstranimo zadnjo oz. najbolj desno pojavitev x
% ?- odstrani_desnega(1, [1,2,3,1,4,5,1], L).
%    L = [1, 2, 3, 1, 4, 5] ;
odstrani_desnega(X, [X|Xs], Xs) :-
    \+ member(X, Xs).
odstrani_desnega(X, [Y|Xs], [Y|Ys]) :-
    odstrani_desnega(X, Xs, Ys).

% odstrani_vse_pojavitve(X, L, NewL)
% remove all, remove_all, remove_all_occurences
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

% dup(L1, L2): the list L2 is obtained from L1 by duplicating every element.
dup([], []).
dup([H | T], [H, H | Temp]) :-
    dup(T, Temp).

% conc(L1, L2, L): the list L is obtained by appending the elements of L2 to L1.
% lahko uporabis tudi za delitev seznama na dva dela ?- conc(L1, L2, [a,b,c,d]).
% lahko uporabis za pridobitev prvih n elementov seznama in preostanek seznama ?- conc([X,Y], L2, [a,b,c,d,e,f]).
% lahko uporabis za iskanje duplikatov ?- conc(_, [X,X|_], [a,b,c,c,d,e,f,f,g,h,h]).
conc([], L2, L2).
conc([H | T], L2, [H | Rez]) :-
    conc(T, L2, Rez).

% last_elem(L, E): E is the last element of list L.
% zadnjih n(1,2,...) elementov lahko dobis tudi s funkcijo conc ?- conc(_, [El], [a,b,c,d,e,f]).
last_elem([E], E).
last_elem([_| T], Temp) :-
    last_elem(T, Temp).

% remove_last_element(L, NewL): the list NewL is obtained from list L by removing the last element
% remove_last_element([] ,[]). ce hoces dovoliti ?- remove_last_element([], L) -> L = [].
remove_last_element([A, _], [A]).
remove_last_element([H | T], [H | CutTail]) :-
    remove_last_element(T, CutTail).

% divide(L, L1, L2): the list L1 contains elements at odd positions in L, and the list L2 contains the elements at even positions in L.
divide([], [], []).
divide([A], [A], []).
divide([H1, H2 | T], [H1 | TempL1], [H2 | TempL2]) :-
    divide(T, TempL1, TempL2).

% permute(L1, L2): the list L2 is a permutation of the elements of the list L1.
permute([], []).
permute([H | T], L2) :-
    permute(T, Temp),
    insert(H, Temp, L2).

% 
% 
% SEZNAMI IN ARITMETIKA
% 
% 

% shiftleft(L1, L2): the list L2 is obtained from L1 by shifting elements to the left by one (circular shift).
% ?- shiftleft([1,2,3,4,5], X).
%   X = [2,3,4,5,1].
shiftleft([], []).
shiftleft([H | T], L2) :-
    conc(T, [H], L2).

% shiftright(L1, L2): the list L2 is obtained from L1 by shifting elements to the right by one (circular shift).
% ?- shiftright([1,2,3,4,5], X).
%   X = [5,1,2,3,4].
shiftright(L1, L2) :- shiftleft(L2, L1).

% rev(L1, L2): the list L2 is obtained from L1 by reversing the order of the elements.
rev([], []).
rev([H | T], L2) :-
    rev(T, Temp),
    conc(Temp, [H], L2).

% palindrome(L): the elements of list L are the same when read from the front or back of the list.
palindrome(L) :-
    rev(L, L).

% evenlen(L): the list L has an even number of elements.
evenlen([]).
evenlen([_, _ | T]) :-
    evenlen(T).

% oddlen(L): the list L has an odd number of elements.
oddlen([_ | T]) :- evenlen(T).

% len(L, Len): Len is the length of list L.
len([], 0).
len([_ | T], Len) :-
    len(T, Temp),
    Len is Temp + 1.

% min(L, Min): Min is the smallest value in list L.
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

% max(L, Max): Max is the largest value in list L.
max([A], A).
max([H | T], Max) :-
    max(T, TempMax),
    (
    H > TempMax,
    Max = H
    ;
    H =< TempMax,
    Max = TempMax
    ).

% sublist(L, SL): SL is a continuous sublist of list L. Your program should return every possible sublist; each answer may be returned more than once.
% ?- sublist([1,2,3], X).
%   X = [] ;
%   X = [1] ;
%   X = [1,2] ;
%   X = [1,2,3] ;
%   X = [2] ;
%   X = [2,3] ;
%   X = [3].
sublist([], []).
sublist(L, SL) :-
    conc(_, Rest, L),
    conc(SL, _, Rest).

% 
% 
% SORTIRANJE
% 
% 

% is_sorted(L): the elements of list L are sorted in non-decreasing (increasing) order.
is_sorted([]) :- !.
is_sorted([_]) :- !.
is_sorted([H1, H2 | T]) :-
    H1 =< H2,
    is_sorted([H2 | T]).

% sins(X, SortedList, NewList): the list NewList is obtained by inserting X into SortedList at the correct position to preserve the non-decreasing order of elements.
sins(X, [], [X]).
sins(X, [H | T], NewList) :-
    (
        X >= H ->
        sins(X, T, SubInserted),
        NewList = [H|SubInserted]
        ;
        NewList = [X,H|T]
    ).

% isort(L, SL): the list SL contains the elements of L sorted in non-decreasing order. Use the predicate sins/3 to implement insertion sort.
isort([], []).
isort([H | T], SL) :-
    isort(T, SubSorted),
    sins(H, SubSorted, SL).

% pivoting(P, L, S, G): the list S contains the elements of L smaller or equal to P, and the list G contains the elements of L greater than P. The order of elements in S and G should be the same as in L.
% ?- pivoting(4, [1,4,5,8,6,4,2], S, G).
%   S = [1,4,4,2], G = [5,8,6].
pivoting(_, [], [], []).
pivoting(P, [H | T], S, G) :-
    pivoting(P, T, SubS, SubG),
    (
    H =< P,
    S = [H | SubS],
    G = SubG
    ;
    H > P,
    G = [H | SubG],
    S = SubS
    ).

% quick_sort(L, SL): the list SL contains the elements of L sorted in non-decreasing order. Use the predicate pivoting/4 to implement quicksort.
quick_sort([], []).
quick_sort([H | T], SL) :-
    pivoting(H, T, Levo, Desno),
    quick_sort(Levo, SortiranoLevo),
    quick_sort(Desno, SortiranoDesno),
    conc(SortiranoLevo, [H | SortiranoDesno], SL).

% 
% 
% UPORABNE FUNKCIJE IZ library(lists)
% 
% 

:- use_module(library(lists)).

% member(X, L): X je element seznama L.
% Podobno kot tvoj memb/2.
% ?- member(X, [1,2,3]).
%   X = 1 ;
%   X = 2 ;
%   X = 3.
%
% ?- member(2, [1,2,3]).
%   true.

% append(ListOfLists, L): L je konkatenacija vseh seznamov v ListOfLists.
% ?- append([[1,2], [3], [4,5]], L).
%   L = [1,2,3,4,5].

% prefix(P, L): P je začetni del seznama L.
% ?- prefix(P, [a,b,c]).
%   P = [] ;
%   P = [a] ;
%   P = [a,b] ;
%   P = [a,b,c].
%
% ?- prefix([a,b], [a,b,c,d]).
%   true.

% nextto(X, Y, L): Y je neposredno za X v seznamu L.
% ?- nextto(a, b, [c,a,b,d]).
%   true.
%
% ?- nextto(X, Y, [1,2,3]).
%   X = 1, Y = 2 ;
%   X = 2, Y = 3.

% nth0(I, L, X): X je element seznama L na indeksu I.
% Štetje se začne z 0.
% ?- nth0(0, [a,b,c], X).
%   X = a.
%
% ?- nth0(I, [a,b,c], b).
%   I = 1.

% nth0(I, L, X, Rest): X je element na indeksu I,
% Rest pa je seznam L brez tega elementa.
% ?- nth0(I, [a,b,c], X, Rest).
%   I = 0, X = a, Rest = [b,c] ;
%   I = 1, X = b, Rest = [a,c] ;
%   I = 2, X = c, Rest = [a,b].
%
% Lahko se uporablja tudi za vstavljanje:
% ?- nth0(1, L, x, [a,b]).
%   L = [a,x,b].

% same_length(L1, L2): seznama L1 in L2 imata enako dolžino.
% ?- same_length([a,b,c], [1,2,3]).
%   true.
%
% ?- same_length([a,b], L).
%   L = [_A, _B].

% flatten(Nested, Flat): Flat je sploščen seznam Nested.
% ?- flatten([1,[2,3],[[4]],5], L).
%   L = [1,2,3,4,5].

% clumped(L, Pairs): zaporedne enake elemente združi v pare Element-Število.
% To je run-length encoding za zaporedne ponovitve.
% ?- clumped([a,a,b,a,a,a,c,c], R).
%   R = [a-2, b-1, a-3, c-2].
%
% Pozor: šteje zaporedne skupine, ne vseh pojavitev skupaj.

% numlist(Low, High, L): L je seznam celih števil od Low do High.
% ?- numlist(3, 7, L).
%   L = [3,4,5,6,7].
%
% ?- numlist(5, 3, L).
%   false.

% 
% 
% MNOŽICE KOT SEZNAMI (se vedno library(lists))
% 
% 

% is_set(L): L je pravi seznam brez duplikatov.
% ?- is_set([a,b,c]).
%   true.
%
% ?- is_set([a,b,a]).
%   false.

% list_to_set(L, Set): Set vsebuje iste elemente kot L,
% vendar brez duplikatov. Ohrani se levi/najzgodnejši pojav elementa.
% ?- list_to_set([a,b,a,c,b], S).
%   S = [a,b,c].

% intersection(S1, S2, S3): S3 je presek množic S1 in S2.
% ?- intersection([a,b,c], [b,c,d], S).
%   S = [b,c].

% union(S1, S2, S3): S3 je unija množic S1 in S2.
% ?- union([a,b], [b,c,d], S).
%   S = [a,b,c,d].

% subset(Sub, Set): vsi elementi Sub so tudi v Set.
% ?- subset([a,c], [a,b,c,d]).
%   true.
%
% ?- subset([a,x], [a,b,c,d]).
%   false.

% subtract(Set, Delete, Result): iz Set odstrani vse elemente,
% ki so v Delete.
% ?- subtract([a,b,c,d], [b,d], R).
%   R = [a,c].

% 
% 
% CLPFD
% 
% 

:- use_module(library(clpfd)).
% +   -   *   ^   min   max   mod   rem   abs   //   div
% #=   #\=   #>=   #=<   #>   #<

label_vars(Vars) :-
    labeling([], Vars).

matrix(N, M, Matrix) :-
    length(Matrix, N),
    maplist(same_length_(M), Matrix).

same_length_(N, Row) :-
    length(Row, N).

square_matrix(N, Matrix) :-
    matrix(N, N, Matrix).

matrix_vars(Matrix, Vars) :-
    append(Matrix, Vars).


    

    
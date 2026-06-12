:- use_module(library(lists)).

zdruzi(K, L, O, M) :-
    append(KL, [O], M),
    append(K, L, KL).

eval(L, N) :-
    eval_(L, [], N).


eval_([H | Rest], S, N) :-
    integer(H),
    eval_(Rest, [H | S], N).

eval_([plus | Rest], [B, A | RestS], N) :-
    E is A + B,
    eval_(Rest, [E | RestS], N).

eval_([krat | Rest], [B, A | RestS], N) :-
    E is A * B,
    eval_(Rest, [E | RestS], N).

eval_([minus | Rest], [B, A | RestS], N) :-
    E is A - B,
    eval_(Rest, [E | RestS], N).

eval_([], [N], N).
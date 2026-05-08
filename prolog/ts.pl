% program(Name, InState, InSymbol, OutState, OutSymbol, Direction).
program(plus1, q0, 1, q0, 1, right).
program(plus1, q0, b, final, 1, stay).

get_last_or_b([], b).
get_last_or_b([H | []], H).
get_last_or_b([_|T], E) :-
    T \= [],
    get_last_or_b(T, E).

get_first_or_b([], b).   
get_first_or_b([H | _], H).
    
remove_last([], []).
remove_last([_], []).
remove_last([H1 | T1], L2) :-
    remove_last(T1, Rez),
    L2 = [H1 | Rez].

remove_first([], []).
remove_first([_ | T], T).

reverse_list([], []).
reverse_list([H | T], L2) :-
    reverse_list(T, Rez),
    append(Rez, [H], L2).
    
% action(Direction, InL-InR, OutL-OutR)
action(stay, InL-InR, InL-InR).

action(right, InL-InR, OutL-OutR) :-
    get_first_or_b(InR, ElPodGlavo),
    remove_first(InR, OutR),
    OutL = [ElPodGlavo | InL].

action(left, InL-InR, OutL-OutR) :-
    get_first_or_b(InL, ZadnjiInL),
    OutR = [ZadnjiInL | InR],
    remove_first(InL, OutL).
    
% head_rest(R, Head, Rest)
head_rest([], b, []).
head_rest([RHead | RTail], RHead, RTail).
    
% step(Name, InL-InR, InState, OutL-OutR, OutState)
step(Name, InL-InR, InState, OutL-OutR, OutState) :-
    head_rest(InR, InSymbol, InRTail),
    program(Name, InState, InSymbol, OutState, OutSymbol, Direction),
    action(Direction, InL-[OutSymbol | InRTail], OutL-OutR).

% run(Name, State, InL-InR, OutL-OutR)
run(_, final, InL-InR, InL-InR).
run(Name, State, InL-InR, OutL-OutR) :-
    step(Name, InL-InR, State, OutLHalfway-OutRHalfway, OutState),
    run(Name, OutState, OutLHalfway-OutRHalfway, OutL-OutR).
    
% turing(Name, InTape, OutTape)
turing(Name, InTape, OutTape) :-
    run(Name, q0, []-InTape, OutL-OutR),
    reverse_list(OutL, OutLReversed),
    append(OutLReversed, OutR, OutTape).

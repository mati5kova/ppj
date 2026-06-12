sub(int, int).
sub(int, float).
sub(float, float).

sub(arrow(Tau1, Sigma1), arrow(Tau2, Sigma2)) :-
    sub(Tau2, Tau1),
    sub(Sigma1, Sigma2).
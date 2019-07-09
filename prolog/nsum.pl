% General n-sum problem
% https://leetcode.com/problems/4sum/
% https://leetcode.com/problems/3sum/

pushFront(X, Xs, [X | Xs]).
sumlist(Xs, S) :- foldl([X, Acc, Out]>>(Out is Acc + X), Xs, 0, S).

combinations(0,_,[[]]) :- !.
combinations(_, [], []) :- !.
combinations(N, [X | Xs], Ks) :-
    N > 0,
    combinations(N, Xs, K1s),
    M is N - 1,
    combinations(M, Xs, K2s),
    maplist(pushFront(X), K2s, K3s),
    append(K1s, K3s, Ks).

sumsTo(Target, Xs, Acc, [Xs | Acc]) :- sumlist(Xs, Target), !.
sumsTo(_, _, Acc, Acc).

n_sum(N, Nums, Target, Out) :-
    combinations(N, Nums, C),
    foldl(sumsTo(Target), C, [], Out).


% General n-sum closest
% https://leetcode.com/problems/3sum-closest/

closest(Target, C, Cb, Cb) :-
    sumlist(Cb, S1),
    sumlist(C, S2),
    distance(S1, Target, D1),
    distance(S2, Target, D2),
    D1 =< D2, !.

closest(_, C, _, C).

distance(X,Y,Z) :-
    W is X-Y,
    Z is abs(W).

% Returns the actual elements rather than the required sum
n_sum_closest(N, Nums, Target, Out) :-
    combinations(N, Nums, Comb), 
    Comb = [C | Cs],
    foldl(closest(Target), Cs, C, Out).

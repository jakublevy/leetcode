% https://leetcode.com/problems/subsets/
% https://leetcode.com/problems/subsets-ii/

pushFront(X, Xs, [X | Xs]).

subsets_i([], [[]]).
subsets_i([X | Xs], Out) :-
    subsets_i(Xs, Ys),
    maplist(pushFront(X), Ys, Zs),
    append(Ys, Zs, Out).

subsets_ii([], [[]]).
subsets_ii([X | Xs], Out) :-
    subsets_ii(Xs, Ys),
    maplist(pushFront(X), Ys, Zs),
    append(Ys, Zs, OutDup),
    unique(OutDup, Out).

notEqual(X, Y) :- X \== Y.

filter(_, [], []) :- !.
filter(Unary, [X | Xs], Z) :-
    filter(Unary, Xs, Z),
    \+ call(Unary, X), !.

filter(Unary, [X | Xs], [X | Z]) :- filter(Unary, Xs, Z).

unique([], []).
unique([X | Xs], [X | Zs]) :-
    filter(notEqual(X), Xs, Ys),
    unique(Ys, Zs).

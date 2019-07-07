% https://leetcode.com/problems/unique-binary-search-trees/
% https://leetcode.com/problems/unique-binary-search-trees-ii/

collection(From, To, C) :- findall(X, between(From, To, X), C).

less(V, X) :- V > X.
greater(V, X) :- V < X.

filter(_, [], []) :- !.
filter(Unary, [X | Xs], Z) :-
    filter(Unary, Xs, Z),
    \+ call(Unary, X), !.

filter(Unary, [X | Xs], [X | Z]) :- filter(Unary, Xs, Z).

unique_bst_ii(N, Bst) :-
    integer(N), !,
    collection(1, N, C),
    unique_bst_ii(C, Bst).

unique_bst_ii([], nil).
unique_bst_ii(Values, t(L, V, R)) :- 
    member(V, Values),
    filter(less(V), Values, Smaller),
    filter(greater(V), Values, Greater),
    unique_bst_ii(Smaller, L),
    unique_bst_ii(Greater, R).


unique_bst_i(N, Count) :-
    findall(Bst, unique_bst_ii(N, Bst), Bsts),
    length(Bsts, Count).

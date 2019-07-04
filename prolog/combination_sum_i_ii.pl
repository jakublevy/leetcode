%combination sum I
% https://leetcode.com/problems/combination-sum/
permutation_member(X, Xs) :-
    permutation(X, Y),
    member(Y, Xs).

sumlist(Xs, Y) :- foldl([I,J,K]>>(K is I+J), Xs, 0, Y).

combination_sum_i(_, Target, Acc, Acc) :- sumlist(Acc, Target).
combination_sum_i(Candidates, Target, Acc, Comb) :-
    sumlist(Acc, S),
    S < Target,
    member(C, Candidates),
    combination_sum_i(Candidates, Target, [C|Acc], Comb).

combination_sums_i(Candidates, Target, Combs) :- combination_sums_i(Candidates, Target, [], Combs).
combination_sums_i(Candidates, Target, Acc, Combs) :-
    combination_sum_i(Candidates, Target, [], C),
    \+ permutation_member(C, Acc), !,
    combination_sums_i(Candidates, Target, [C|Acc], Combs).

combination_sums_i(_, _, Acc, Acc).






%combination sum II
%https://leetcode.com/problems/combination-sum-ii/
combination_sum_ii(_, Target, Acc, Acc) :- sumlist(Acc, Target).
combination_sum_ii(Candidates, Target, Acc, Comb) :-
    Candidates \= [], %tadyto je pridano
    sumlist(Acc, S),
    S < Target,
    select(C, Candidates, RemainingCandidates), %tady je zmena
    combination_sum_ii(RemainingCandidates, Target, [C|Acc], Comb). %tady je zmena

combination_sums_ii(Candidates, Target, Combs) :- combination_sums_ii(Candidates, Target, [], Combs).
combination_sums_ii(Candidates, Target, Acc, Combs) :-
   combination_sum_ii(Candidates, Target, [], C),
   \+ permutation_member(C, Acc), !,
   combination_sums_ii(Candidates, Target, [C|Acc], Combs).

combination_sums_ii(_, _, Acc, Acc).

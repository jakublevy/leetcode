%https://leetcode.com/problems/group-anagrams/

input([eat, tea, tan, ate, nat, bat]).

already_processed(P, Xss) :-
    member(Xs, Xss),
    member(P, Xs).

is_anagram(X, Y) :-
    atom_chars(X, XChars),
    atom_chars(Y, YChars),
    intersection(XChars, YChars, I),
    length(I, L1),
    length(XChars, L2),
    length(YChars, L3),
    L1 =:= L2,
    L2 =:= L3.

anagram(_, X, Acc, Acc) :- already_processed(X, Acc), !.
anagram(Xs, X, Acc, [Ys | Acc]) :- findall(Y, (member(Y, Xs), is_anagram(X, Y)), Ys).

group_anagrams(Xs, Yss) :- foldl(anagram(Xs), Xs, [], Yss).


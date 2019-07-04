%https://leetcode.com/problems/group-anagrams/

vstup([eat, tea, tan, ate, nat, bat]).

jiz_zpracovan(P, Xss) :-
    member(Xs, Xss),
    member(P, Xs).

je_anagram(X, Y) :-
    atom_chars(X, XChars),
    atom_chars(Y, YChars),
    intersection(XChars, YChars, I),
    length(I, L1),
    length(XChars, L2),
    length(YChars, L3),
    L1 =:= L2,
    L2 =:= L3.

anagram(_, X, Acc, Acc) :- jiz_zpracovan(X, Acc), !.
anagram(Xs, X, Acc, [Ys | Acc]) :- findall(Y, (member(Y, Xs), je_anagram(X, Y)), Ys).

group_anagrams(Xs, Yss) :- foldl(anagram(Xs), Xs, [], Yss).


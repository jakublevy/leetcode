%https://leetcode.com/problems/letter-combinations-of-a-phone-number/

mapping([
    2-[a,b,c],
    3-[d,e,f],
    4-[g,h,i],
    5-[j,k,l],
    6-[m,n,o],
    7-[p,q,r,s],
    8-[t,u,v],
    9-[w,x,y,z]
    ]).

digit(D, Acc, [C|Acc]) :-
    mapping(M),
    member(D-Vals, M),
    member(C, Vals).

letter_combination(NumStr, Lc) :-
    atom_chars(NumStr, DigitsChars),
    foldl([C,Acc,[D | Acc]]>>atom_number(C,D), DigitsChars, [], Digits),
    foldl(digit, Digits, [], LcL),
    atomic_list_concat(LcL, Lc).

letter_combinations(NumStr, Lcs) :- findall(LC, letter_combination(NumStr, LC), Lcs).

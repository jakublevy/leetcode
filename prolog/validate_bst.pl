%https://leetcode.com/problems/validate-binary-search-tree/

input(t(t(nil,1,nil),2,t(nil,3,nil))).
input2(t(t(nil,1,nil),5,t(t(nil,3,nil),4,t(nil,6,nil)))).

less(nil, _) :- !.
less(V1, V2) :- V1 < V2.

greater(nil, _) :- !.
greater(V1, V2) :- V1 > V2.

value(nil, nil).
value(t(_,V,_), V).

validate(nil).
validate(t(L,V,R)) :-
    value(L, LV),
    value(R, RV),
    less(LV, V),
    greater(RV, V),
    validate(L),
    validate(R).

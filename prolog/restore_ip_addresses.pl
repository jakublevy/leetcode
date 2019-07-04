% Not optimal because of fold usage
% https://leetcode.com/problems/restore-ip-addresses/

foldr(_, [], Out, Out) :- !.
foldr(Binary, [X | Xs], Acc, Out) :-
    foldr(Binary, Xs, Acc, O1),
    call(Binary, X, O1, Out).

atom_digits(NumStr, Digits) :-
    atom_chars(NumStr, DigitsChars),
    foldr([C,Acc,[D | Acc]]>>atom_number(C,D), DigitsChars, [], Digits).

concat_numbers(X, Y, Z) :-
    number_string(X, XS),
    number_string(Y, YS),
    string_concat(XS, YS, ZS),
    number_string(Z, ZS).

valid_ip_num(X) :-
    X >= 0,
    X < 256,
    integer(X).

dots(D, [], [D]).
dots(D, ['.' | Acc], [D, '.' | Acc]).
dots(D, [C | Acc], [CD | Acc]) :-
    C \== '.',
    concat_numbers(C, D, CD),
    valid_ip_num(CD).

dots(D, [C | Acc], ['.', CD | Acc]) :-
    C \== '.',
    dots_count(Acc, E),
    E < 3,
    concat_numbers(C, D, CD),
    valid_ip_num(CD).

add_dot(X, A, A) :- X \== '.', !.
add_dot(_, A, B) :- B is A + 1.

dots_count(Xs, Y) :- foldl(add_dot, Xs, 0, Y).

combine_to_string(IP, IPStr) :- combine_to_string(IP, '', IPStr).
combine_to_string([], Acc, Acc).
combine_to_string(['.' | IP], Acc, IPStr) :-
    !, string_concat(Acc, '.', NewAcc),
    combine_to_string(IP, NewAcc, IPStr).

combine_to_string([D | IP], Acc, IPStr) :-
    number_string(D, DStr),
    string_concat(Acc, DStr, NewAcc),
    combine_to_string(IP, NewAcc, IPStr).

restore_ip_addresses(IpStr, IPStr) :-
    atom_digits(IpStr, IpDigits),
    foldl(dots, IpDigits, [], IPRev),
    dots_count(IPRev, 3),
    \+ IPRev = ['.' | _],
    reverse(IPRev, IP),
    combine_to_string(IP, IPStr).

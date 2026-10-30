:- consult('nn.pl').

:- begin_tests(nn).

test(zero) :- nn(0).
test(one) :- nn(s(0)).
test(three) :- nn(s(s(s(0)))).

test(atom, [fail]) :- nn(a).
test(bad_successor, [fail]) :- nn(s(a)).
test(integer_one, [fail]) :- nn(1).
test(list, [fail]) :- nn([a]).

test(first_answer, [true(X == 0)]) :- once(nn(X)).
test(enumeration, [true(L == [0, s(0), s(s(0)), s(s(s(0)))])]) :-
    findall(X, limit(4, nn(X)), L).

:- end_tests(nn).

:- run_tests.

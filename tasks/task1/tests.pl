:- consult('list3.pl').

:- begin_tests(list3).

test(exactly_three) :- list3([a,b,c]).
test(too_short, [fail]) :- list3([a,b]).
test(too_long, [fail]) :- list3([a,b,c,d]).
test(empty, [fail]) :- list3([]).

:- end_tests(list3).

:- run_tests.

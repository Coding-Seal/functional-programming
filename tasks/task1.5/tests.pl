:- consult('list_resolution.pl').

:- begin_tests(list_resolution).

test(empty) :- list([]).
test(one_element) :- list([1]).
test(two_elements) :- list([1,2]).
test(improper_list, [fail]) :- list([1,2|3]).
test(not_a_list, [fail]) :- list(foo).

:- end_tests(list_resolution).

:- run_tests.

:- consult('post.pl').

:- begin_tests(post).

test(main, [true(L == [2,3,+,4,5,-,*])]) :-
    once(post((2+3)*(4-5), L)).

test(lecture_tree, [true(L == [2,3,+,4,5,-,*])]) :-
    once(post(tree(*, tree(+, tree(2,void,void), tree(3,void,void)),
                      tree(-, tree(4,void,void), tree(5,void,void))), L)).

test(single_node, [true(L == [2,3,+])]) :- once(post(2+3, L)).
test(leaf, [true(L == [7])]) :- once(post(7, L)).
test(empty_tree, [true(L == [])]) :- once(post(void, L)).

test(with_variable, [true(L == [X,3,**,5,X,*,-,3,2,/,+])]) :-
    once(post(((X**3)-(5*X))+(3/2), L)).

test(ternary_term, [fail]) :- post(f(1,2,3), _).
test(void_not_a_leaf, [fail]) :- post(void, [void]).
test(wrong_order, [fail]) :- post((2+3)*(4-5), [*,+,2,3,-,4,5]).

:- end_tests(post).

:- run_tests.

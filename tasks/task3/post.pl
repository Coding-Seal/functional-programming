post(T, Xs) :-
    nonvar(T),
    T = tree(X, L, R),
    post(L, Ls),
    post(R, Rs),
    append(Rs, [X], Rs1),
    append(Ls, Rs1, Xs).
post(T, []) :- T == void.

post(T, Xs) :-
    compound(T),
    T =.. [X, L, R],
    post(L, Ls),
    post(R, Rs),
    append(Rs, [X], Rs1),
    append(Ls, Rs1, Xs).

post(T, [T]) :-
    \+ compound(T),
    T \== void.

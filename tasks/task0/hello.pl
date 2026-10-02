% Facts
parent(tom, bob).
parent(tom, liz).
parent(bob, ann).
parent(bob, pat).

% Rule: X is a grandparent of Z if X is a parent of Y,
% and Y is a parent of Z.
grandparent(X, Z) :-
    parent(X, Y),
    parent(Y, Z).

% Recursive rule: ancestor
ancestor(X, Y) :- parent(X, Y).
ancestor(X, Y) :- parent(X, Z), ancestor(Z, Y).

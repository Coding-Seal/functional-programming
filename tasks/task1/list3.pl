list3(L) :- list3(L, 3).

list3([], 0).
list3([_|T], N) :-
    N > 0,
    N1 is N - 1,
    list3(T, N1).

% my_lists.pl
%
% Reimplementations of standard list predicates, built only from
% unification, recursion, and pattern matching on [Head|Tail].
% Prefixed with `my_` so they don't clash with SWI-Prolog's built-ins
% of the same name (member/2, append/3, etc. already exist).
%
% Every predicate below follows the same shape:
%   - one clause (the "base case") that matches the empty list [],
%   - one clause (the "recursive case") that matches [Head|Tail] and
%     calls itself on the shorter list Tail.
% That's the whole pattern this file teaches.


% ---------------------------------------------------------------------
% my_member(X, List) — true if X occurs somewhere in List.
% ---------------------------------------------------------------------
%
% Clause 1 (base case): X is a member of a list if X is sitting right
% at the front. [X|_] unifies with any list whose head is X — the `_`
% means "don't care what the rest of the list is."
my_member(X, [X|_]).

% Clause 2 (recursive case): X is a member of [_|T] if X is a member
% of T. This peels off the head we don't care about and recurses on
% the tail, one element shorter each time.
my_member(X, [_|T]) :- my_member(X, T).

% How a query resolves, e.g. `my_member(b, [a,b,c])`:
%   1. Try clause 1: [b|_] unify with [a,b,c]? No, head is `a`, not `b`.
%   2. Try clause 2: [_|T] unifies with [a,b,c], so T = [b,c].
%      Recurse: my_member(b, [b,c]).
%   3. Try clause 1: [b|_] unify with [b,c]? Yes, head is `b`. Success.
% Because both clauses can match, `my_member(X, [a,b,c])` on backtrack
% will also enumerate every element via `;` — it's a search, not a
% single lookup.


% ---------------------------------------------------------------------
% my_length(List, N) — N is the number of elements in List.
% ---------------------------------------------------------------------
%
% Base case: the empty list has length 0.
my_length([], 0).

% Recursive case: a list [_|T] has length N if T has length N0 and
% N is N0 + 1. We strip one element off the front, recurse to find
% the tail's length, then add 1 for the element we stripped.
my_length([_|T], N) :-
    my_length(T, N0),
    N is N0 + 1.

% Walking `my_length([a,b,c], N)`:
%   my_length([a,b,c], N) :- my_length([b,c], N0), N is N0+1.
%   my_length([b,c], N0)  :- my_length([c],   N1), N0 is N1+1.
%   my_length([c],   N1)  :- my_length([],    N2), N1 is N2+1.
%   my_length([],    N2)  matches the base case directly: N2 = 0.
% Then the arithmetic unwinds on the way back out:
%   N1 is 0+1 = 1
%   N0 is 1+1 = 2
%   N  is 2+1 = 3
% `is` only runs once the right-hand side is fully known, so the
% additions happen bottom-up as the recursion returns, not top-down.


% ---------------------------------------------------------------------
% my_append(ListA, ListB, Result) — Result is ListA followed by ListB.
% ---------------------------------------------------------------------
%
% Base case: appending anything B to the empty list just gives B back.
my_append([], B, B).

% Recursive case: appending B to [H|T] gives [H| T-appended-with-B].
% We keep the head H in front, and recursively append B onto the
% shorter list T, naming the result TB.
my_append([H|T], B, [H|TB]) :-
    my_append(T, B, TB).

% Walking `my_append([1,2], [3,4], R)`:
%   my_append([1,2], [3,4], [1|TB1]) :- my_append([2], [3,4], TB1).
%   my_append([2], [3,4], [2|TB2])   :- my_append([], [3,4], TB2).
%   my_append([], [3,4], TB2) matches the base case: TB2 = [3,4].
% Unwinding:
%   TB1 = [2|TB2] = [2,3,4]
%   R   = [1|TB1] = [1,2,3,4]
%
% Because my_append's arguments are just unification (no `is`), it
% also works "backwards" — e.g. my_append(X, Y, [1,2,3]) will
% enumerate every way to split [1,2,3] into a prefix X and suffix Y.
% This bidirectionality is a distinctive Prolog feature that a
% typical imperative `append` function doesn't have for free.


% ---------------------------------------------------------------------
% my_reverse(List, Reversed) — Reversed is List in reverse order.
% ---------------------------------------------------------------------
%
% Naive version, built directly from my_append/3: reversing [H|T] is
% "reverse T, then append [H] at the end."
my_reverse([], []).
my_reverse([H|T], Reversed) :-
    my_reverse(T, RevT),
    my_append(RevT, [H], Reversed).

% This is simple but inefficient: my_append walks its whole first
% argument, and we call it once per element, so this is O(N^2) overall.
%
% my_reverse_acc/2 below is the standard fix: an accumulator that
% builds the reversed list as we go, so the whole thing is O(N).
%
% my_reverse_acc(List, Reversed) is the public predicate; it just sets
% up the accumulator, starting empty, and hands off to the 3-argument
% helper.
my_reverse_acc(List, Reversed) :-
    my_reverse_acc(List, [], Reversed).

% my_reverse_acc(Remaining, Acc, Reversed):
%   Remaining — the part of the input list not yet processed.
%   Acc       — the reversed list built so far.
%   Reversed  — bound to Acc once Remaining is empty.
%
% Base case: nothing left to process, so the accumulator already
% holds the fully-reversed list.
my_reverse_acc([], Acc, Acc).

% Recursive case: move H from the front of Remaining onto the front
% of Acc (that's what reverses the order), then keep going with T.
my_reverse_acc([H|T], Acc, Reversed) :-
    my_reverse_acc(T, [H|Acc], Reversed).

% Walking `my_reverse_acc([1,2,3], R)`  (Acc starts as []):
%   my_reverse_acc([1,2,3], [],      R) -> H=1,T=[2,3], Acc becomes [1]
%   my_reverse_acc([2,3],   [1],     R) -> H=2,T=[3],   Acc becomes [2,1]
%   my_reverse_acc([3],     [2,1],   R) -> H=3,T=[],    Acc becomes [3,2,1]
%   my_reverse_acc([],      [3,2,1], R) -> base case: R = [3,2,1]
% Each step does O(1) work (just consing H onto Acc), and there are N
% steps, so this version is O(N) instead of O(N^2).

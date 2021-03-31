initial([white, white, white, empty, black, black, black]).
final([black, black, black, empty, white, white, white]).

% Depth-limtied search
dls(State, _, [], _) :- final(State).
dls(_, _, _, 0) :- false.
dls(State, History, [[X, Y] | Actions], Limit) :-
  find_swap_indexes(State, X, Y),
  swap(State, X, Y, NextState),
  % Action = X-Y,
  not(member(NextState, History)),
  Limit2 is Limit - 1,
  dls(NextState, [NextState | History], Actions, Limit2).

either_empty(A, B) :-
  (A  = empty, B \= empty);
  (A \= empty, B  = empty).

% -List, +A, +B
find_swap_indexes(List, A, B) :- find_swap_indexes_aux(List, 0, A, B).
find_swap_indexes_aux([X, Y    |  _], C, C, B) :-
  either_empty(X, Y),
  B is C + 1.
find_swap_indexes_aux([X, _, Y |  _], C, C, B) :-
  either_empty(X, Y),
  B is C + 2.
find_swap_indexes_aux([_       | Xs], C, A, B) :-
  C2 is C + 1,
  find_swap_indexes_aux(Xs, C2, A, B).

% +List, +From, +To, -Result
swap([A,    B | Xs], 0,  1,  [B,    A | Xs]).
swap([A, X, B | Xs], 0,  2,  [B, X, A | Xs]).
swap([X       | Xs], I1, I2, [X       | Ys]) :-
  I11 is I1 - 1,
  I22 is I2 - 1,
  swap(Xs, I11, I22, Ys).

format_solution([X], R) :-
  format(atom(R), 'from ~w to ~w', X).
format_solution([[A, B] | Xs], Repr) :-
  format_solution(Xs, Rest),
  format(atom(Repr), 'from ~w to ~w\n~w', [A, B, Rest]).

main(Solution) :-
  initial(State),
  dls(State, [], Solution, 6969),
  format_solution(Solution, Repr),
  writeln(Repr).

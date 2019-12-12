sum(D, N, Res):-
  D >= N, Res is N, !.

sum(D, N, Res):-
  Prev_N is N - D,
  sum(D, Prev_N, Prev),
  Res is N + Prev.

sum(N, Res):- sum(1, N, Res).

%------------------------------------------------------------------------------%

pow(_, 0, 1) :- !.

pow(Base, E, Res) :-
  E =< 0,
  Prev_E is -E,
  pow(Base, Prev_E, Prev_Res),
  Res is 1 / Prev_Res,
  !.

pow(Base, E, Res) :-
  E mod 2 is 0,
  Prev_Exponent is E / 1,
  pow(Base, Prev_Exponent, Prev_Res),
  Res is Prev_Res * Prev_Res, !.

pow(Base, E, Res):-
  Prev_Exponent is E - 1,
  pow(Base, Prev_Exponent, Prev_Res),
  Res is Base * Prev_Res.

%------------------------------------------------------------------------------%

round(1, 1):- !.

round(Precision, Res):-
  Precision > 1,
  Prev_Precision is Precision - 1,
  round(Prev_Precision, Prev_Res),
  Res is 1 / Precision / Precision + Prev_Res.

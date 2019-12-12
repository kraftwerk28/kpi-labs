roditel(`ivan`,`nina`).
roditel(`ivan`,`oleg`).
roditel(`anna`,`nina`).
roditel(`anna`,`oleg`).
roditel(`oleg`,`larisa`).
roditel(`oleg`,`alla`).
roditel(`vira`,`alla`).
roditel(`vira`,`larisa`).
roditel(`larisa`,`natalia`).
roditel(`viktor`,`natalia`).

doesntHaveKids(X) :- \+ roditel(X, _).
isChildAndParent(X) :- roditel(X, _), roditel(_, X).

male(ivan).
male(oleg).
male(viktor).

father(X, Y) :- male(X), roditel(X, Y).
mother(X, Y) :- not(male(X)), roditel(X, Y).

son(X, Y) :- male(X), roditel(Y, X).
daughter(X, Y) :- not(male(X)), roditel(Y, X).

brother(X, Y) :- male(X), roditel(P, X), roditel(P, Y).

sister(X, Y) :- not(male(X)), roditel(P, X), roditel(P, Y).
uncle(X, Y) :- male(X), roditel(P, Y), brother(X, P).
aunt(X, Y) :- not(male(X)), roditel(P, Y), brother(X, P).

grandfather(X, Y) :- male(X), roditel(X, P), roditel(P, Y).
grandmother(X, Y) :- \+male(X), roditel(X, P), roditel(P, Y).

grandson(X, Y) :- male(X), roditel(P, X), roditel(Y, P).
granddaughter(X, Y) :- \+male(X), roditel(P, X), roditel(Y, P).

niece(X, Y) :- \+ male(X), parent(P, Y), (brother(Y, P); sister(Y, P)).
nephew(X, Y) :- male(X), parent(P, Y), (brother(Y, P); sister(Y, P)).

married(anna, ivan).
married(oleg, vira).
married(vira, oleg).
married(larisa, viktor).
married(viktor, larisa).

mother_in_law(X, Y) :- mother(X, P), married(P, Y).
father_in_law(X, Y) :- father(X, P), married(P, Y).

son(anatolii, vasyl).
daughter(olga, oksana).
% mother_in_law('vira', 'viktor').

% father_in_law('oleg', 'viktor').

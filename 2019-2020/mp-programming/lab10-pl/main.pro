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

father('ivan', 'nina').
father('ivan', 'oleg').
father('oleg', 'alla').
father('oleg', 'larisa').

mother('anna', 'nina').
mother('anna', 'oleg').
mother('vira', 'alla').
mother('vira', 'larisa').

son('oleg', 'ivan').
son('oleg', 'anna').

daughter('nina', 'ivan').
daughter('nina', 'anna').
daughter('alla', 'oleg').
daughter('alla', 'vira').
daughter('larisa', 'oleg').
daughter('larisa', 'vira').
daughter('natalia', 'larisa').
daughter('natalia', 'viktor').

/* brother - none */

sister('alla', 'larisa').
sister('larisa', 'alla').

aunt('nina', 'alla').
aunt('nina', 'larisa').
aunt('alla', 'natalia').

grandfather('ivan', 'alla').
grandfather('ivan', 'larisa').
grandfather('oleg', 'natalia').

grandmother('anna', 'alla').
grandmother('anna', 'larisa').
grandmother('vira', 'natalia').

granddaughter('alla', 'ivan').
granddaughter('alla', 'anna').
granddaughter('larisa', 'ivan').
granddaughter('larisa', 'anna').
granddaughter('natalia', 'oleg').
granddaughter('natalia', 'vira').

niece('alla', 'nina').
niece('larisa', 'nina').
niece('natalia', 'alla').

married('ivan', 'anna').
married('anna', 'ivan').
married('oleg', 'vira').
married('vira', 'oleg').
married('larisa', 'viktor').
married('viktor', 'larisa').

mother_in_law('anna', 'vira').
mother_in_law('vira', 'viktor').

father_in_law('oleg', 'viktor').

maximo([X], X).
maximo([X | Xs], X) :- maximo(Xs, M), X > M.
maximo([P | Xs], X) :- maximo(Xs, X), X >= P.

:- begin_tests(maximo).

test(maximo) :- maximo([5, 4, 13, 0, 9], 13), !.
test(maximo) :- maximo([5, 4, 0, 9], 9), !.
test(maximo) :- maximo([5, 4, 0], 5), !.
test(maximo) :- maximo([4], 4), !.

:- end_tests(maximo).

test :-
    run_tests,
    halt.

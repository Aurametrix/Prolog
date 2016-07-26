% HELLO WORLD.  Works with Sbp - Stony Brook Prolog - for Unix and 386 MS-DOS systems

hello :-
printstring("HELLO WORLD!!!!").

printstring([]).
printstring([H|T]) :- put(H), printstring(T).

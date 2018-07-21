:- initialization(main).
:- include('Api.pl').
:- include('Base.pl').

main :-
	loadAnimations(X),
	writeln(X).

:- initialization(main).
:- include('Api.pl').
:- include('Base.pl').

main :-
readFileLines("Base.pl", List),
writeln(List).

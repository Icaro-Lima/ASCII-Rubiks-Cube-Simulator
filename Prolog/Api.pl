:- include('Base.pl').

waitKey(ValidKeys, ReturnedKey) :-
get_single_char(X),
char_code(Y, X),
(member(Y, ValidKeys) ->
ReturnedKey = Y;
waitKey(ValidKeys, K), ReturnedKey = K
).

filledMatrix(FilledMatrix) :-
	filledMatrixAux(FilledMatrix, 0).

drawMatrix(Matrix) :-
	matrixToText(Matrix, Text), write(Text).

/*writeOnLine(StrIn, Str, I, StrOut) :-
	string_to_list(StrIn, ListIn), string_to_list(Str, List),
	string_to_list(StrOut, ListOut), 
	writeOnLine(ListIn, List, I, ListOut).*/

/*writeOnLine(Text, I).*/

/*writeText([Head|Tail], I, J, II) :-
	(
	II = I -> 
	).*/

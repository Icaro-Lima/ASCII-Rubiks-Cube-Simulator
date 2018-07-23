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

writeText([HeadIn|TailIn], Text, I, J, [HeadOut|TailOut]) :-
	(
	I > 0 -> II is I - 1, HeadOut = HeadIn, writeText(TailIn, Text, II, J, TailOut);
	writeOnLine(Text, HeadIn, J, HeadOut), TailOut = TailIn
	).

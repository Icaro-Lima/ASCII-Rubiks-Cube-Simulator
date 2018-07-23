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

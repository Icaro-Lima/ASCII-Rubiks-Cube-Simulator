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

writeCubeFace(MatrixIn, ColorMatrix, FaceName, I, J, MatrixOut) :-
	animations(Animations),
	writeCubeFaceAux(MatrixIn, ColorMatrix, Animations.get(FaceName), I, J, MatrixOut).

drawLogoAnimation() :-
	drawLogoAnimationAux(0).

drawMenu() :-
	cols(Cols), ColsDiv2 is Cols // 2,
	GName = "----------------------- RUBIK CUBE SIMULATOR -----------------------",
	Opcao1 = "Pressione I para Instruções",
	Opcao2 = "Pressione J para Jogar",
	TeamName = "Icaro Dantas, Igor Farias, Javan Lacerda, Lucas Araújo, Sérgio Duarte",

	string_length(GName, GNameLen),
	string_length(Opcao1, Opcao1Len),
	string_length(Opcao2, Opcao2Len),
	string_length(TeamName, TeamNameLen),

	filledMatrix(FilledMatrix),

	writeText(FilledMatrix, GName, 5, ColsDiv2 - GNameLen // 2, A),
	writeText(A, Opcao1, 8, ColsDiv2 - Opcao1Len // 2, B),
	writeText(B, Opcao2, 9, ColsDiv2 - Opcao2Len // 2, C),
	writeText(C, TeamName, 11, ColsDiv2 - TeamNameLen // 2, D),

	drawMatrix(D).

main :-
	drawMenu().

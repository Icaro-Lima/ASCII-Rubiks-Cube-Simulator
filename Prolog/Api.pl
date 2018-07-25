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

writeInstructions(MatrixIn, I, J, InGame, MatrixOut) :-
	writeText(MatrixIn, "7 - Rotaciona 1a linha em sentido horario", I, J, AA),
	writeText(AA, "9 - Rotaciona 1a linha em sentido anti-horario", I + 1, J, AB),
	writeText(AB, "4 - Rotaciona 2a linha em sentido horario", I + 2, J, AC),
	writeText(AC, "6 - Rotaciona 2a linha em sentido anti-horario", I + 3, J, AD),
	writeText(AD, "1 - Rotaciona 3a linha em sentido horario", I + 4, J, AE),
	writeText(AE, "3 - Rotaciona 3a linha em sentido anti-horario", I + 5, J, AF),
	writeText(AF, "Q - Rotaciona 1a coluna para cima", I + 6, J, AG),
	writeText(AG, "W - Rotaciona 2a coluna para cima", I + 7, J, AH),
	writeText(AH, "E - Rotaciona 3a coluna para cima", I + 8, J, AI),
	writeText(AI, "A - Rotaciona 1a coluna para baixo", I + 9, J, AJ),
	writeText(AJ, "S - Rotaciona 2a coluna para baixo", I + 10, J, AK),
	writeText(AK, "D - Rotaciona 3a coluna para baixo", I + 11, J, AL),
	writeText(AL, "R - Rotaciona 1a face em sentido horario", I + 12, J, AM),
	writeText(AM, "T - Rotaciona 2a face em sentido horario", I + 13, J, AN),
	writeText(AN, "Y - Rotaciona 3a face em sentido horario", I + 14, J, AO),
	writeText(AO, "F - Rotaciona 1a face em sentido anti-horario", I + 15, J, AP),
	writeText(AP, "G - Rotaciona 2a face em sentido anti-horario", I + 16, J, AQ),
	writeText(AQ, "H - Rotaciona 3a face em sentido anti-horario", I + 17, J, AR),
	writeText(AR, "X - Embaralha o cubo", I + 18, J, AS),
	writeText(AS, "Pressione M para voltar ao Menu", I + 20, J, AT),

	(
		\+InGame -> writeText(AT, "Pressione J para Jogar", I + 21, J, MatrixOut);
		MatrixOut = AT
	).

main :-
	drawLogoAnimation(),
	filledMatrix(Filled), writeInstructions(Filled, 0, 0, false, Out), drawMatrix(Out), get_single_char(_).

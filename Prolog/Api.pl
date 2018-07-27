:- include('Base.pl').
:- include('MovimentosLogicos.pl').

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

instructions() :-
	cols(Cols), rows(Rows),
	filledMatrix(Filled), writeInstructions(Filled, Rows // 2 - 11, Cols // 2 - 23, false, Out),
	drawMatrix(Out),
	waitKey(['m', 'M', 'j', 'J'], Key),
	downcase_atom(Key, KeyDownCase),
	(
		KeyDownCase = 'm' -> menu();
		cubeMatrix(Cube), gameLoop(Cube)
	).

menu() :-
	drawMenu(),
	waitKey(['i', 'I', 'j', 'J'], Key),
	downcase_atom(Key, KeyDownCase),
	(
		KeyDownCase = 'i' -> instructions();
		cubeMatrix(Cube), gameLoop(Cube)
	).

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

drawCubeDefault(ColorMatrix) :-
	rows(Rows), cols(Cols), I is Rows // 2 - 18, J is Cols // 2 - 37,

	filledMatrix(FilledMatrixWithoutInstructions),
	writeInstructions(FilledMatrixWithoutInstructions, 0, 0, true, FilledMatrix),

	writeCubeFace(FilledMatrix, ColorMatrix, 'Default', I, J, MatrixOut),
	drawMatrix(MatrixOut).

drawCubeMovement(Movement, ColorMatrix) :-
	rows(Rows), cols(Cols), I is Rows // 2 - 18, J is Cols // 2 - 37,
	SleepTime is 0.01,

	atom_concat(Movement, '_0', Face0),

	filledMatrix(FilledMatrixWithoutInstructions),
	writeInstructions(FilledMatrixWithoutInstructions, 0, 0, true, FilledMatrix),


	writeCubeFace(FilledMatrix, ColorMatrix, Face0, I, J, MatrixOut0),
	drawMatrix(MatrixOut0),
	sleep(SleepTime),

	atom_concat(Movement, '_1', Face1),

	writeCubeFace(FilledMatrix, ColorMatrix, Face1, I, J, MatrixOut1),
	drawMatrix(MatrixOut1),
	sleep(SleepTime),

	atom_concat(Movement, '_2', Face2),

	writeCubeFace(FilledMatrix, ColorMatrix, Face2, I, J, MatrixOut2),
	drawMatrix(MatrixOut2),
	sleep(SleepTime),

	atom_concat(Movement, '_3', Face3),

	writeCubeFace(FilledMatrix, ColorMatrix, Face3, I, J, MatrixOut3),
	drawMatrix(MatrixOut3),
	sleep(SleepTime),

	atom_concat(Movement, '_4', Face4),

	writeCubeFace(FilledMatrix, ColorMatrix, Face4, I, J, MatrixOut4),
	drawMatrix(MatrixOut4),
	sleep(SleepTime).

gameLoop(ColorMatrix) :-
	drawCubeDefault(ColorMatrix),
	waitKey(['r', 'R', 't', 'T', 'y', 'Y', 'f', 'F', 'g', 'G', 'h', 'H', '7', '9', '4', '6', '1', '3', 'e', 'E', 'd', 'D', 'w', 'W', 's', 'S', 'q', 'Q', 'a', 'A', 'm', 'M'], Key),
	downcase_atom(Key, KeyDownCase),

	(
		KeyDownCase = 'a' -> drawCubeMovement('ADown', ColorMatrix), aBaixo(ColorMatrix, NewColorMatrix), gameLoop(NewColorMatrix);
		KeyDownCase = 'q' -> drawCubeMovement('AUp', ColorMatrix), aCima(ColorMatrix, NewColorMatrix), gameLoop(NewColorMatrix);
		KeyDownCase = 's' -> drawCubeMovement('BDown', ColorMatrix), bBaixo(ColorMatrix, NewColorMatrix), gameLoop(NewColorMatrix);
		KeyDownCase = 'w' -> drawCubeMovement('BUp', ColorMatrix), bCima(ColorMatrix, NewColorMatrix), gameLoop(NewColorMatrix);
		KeyDownCase = 'd' -> drawCubeMovement('CDown', ColorMatrix), cBaixo(ColorMatrix, NewColorMatrix), gameLoop(NewColorMatrix);
		KeyDownCase = 'e' -> drawCubeMovement('CUp', ColorMatrix), cCima(ColorMatrix, NewColorMatrix), gameLoop(NewColorMatrix);

		KeyDownCase = '7' -> drawCubeMovement('0Left', ColorMatrix), zeroEsq(ColorMatrix, NewColorMatrix), gameLoop(NewColorMatrix);
		KeyDownCase = '9' -> drawCubeMovement('0Right', ColorMatrix), zeroDir(ColorMatrix, NewColorMatrix), gameLoop(NewColorMatrix);
		KeyDownCase = '4' -> drawCubeMovement('1Left', ColorMatrix), umEsq(ColorMatrix, NewColorMatrix), gameLoop(NewColorMatrix);
		KeyDownCase = '6' -> drawCubeMovement('1Right', ColorMatrix), umDir(ColorMatrix, NewColorMatrix), gameLoop(NewColorMatrix);
		KeyDownCase = '1' -> drawCubeMovement('2Left', ColorMatrix), doisEsq(ColorMatrix, NewColorMatrix), gameLoop(NewColorMatrix);
		KeyDownCase = '3' -> drawCubeMovement('2Right', ColorMatrix), doisDir(ColorMatrix, NewColorMatrix), gameLoop(NewColorMatrix);

		KeyDownCase = 'r' -> drawCubeMovement('aClockwise', ColorMatrix), aHorario(ColorMatrix, NewColorMatrix), gameLoop(NewColorMatrix);
		KeyDownCase = 't' -> drawCubeMovement('bClockwise', ColorMatrix), bHorario(ColorMatrix, NewColorMatrix), gameLoop(NewColorMatrix);
		KeyDownCase = 'y' -> drawCubeMovement('cClockwise', ColorMatrix), cHorario(ColorMatrix, NewColorMatrix), gameLoop(NewColorMatrix);
		KeyDownCase = 'f' -> drawCubeMovement('aCounterclockwise', ColorMatrix), aAntiHorario(ColorMatrix, NewColorMatrix), gameLoop(NewColorMatrix);
		KeyDownCase = 'g' -> drawCubeMovement('bCounterclockwise', ColorMatrix), bAntiHorario(ColorMatrix, NewColorMatrix), gameLoop(NewColorMatrix);
		KeyDownCase = 'h' -> drawCubeMovement('cCounterclockwise', ColorMatrix), cAntiHorario(ColorMatrix, NewColorMatrix), gameLoop(NewColorMatrix);

		menu()
	).

main :-
	/*drawLogoAnimation(),*/
	menu().

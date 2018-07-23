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

writeCubeFaceAux(MatrixIn, _, [], _, _, MatrixIn).

writeCubeFaceAux(MatrixIn, ColorMatrix, [FrameHead|FrameTail], I, J, MatrixOut) :-
	colorizeString(FrameHead, ColorMatrix, ColorFullText),
	writeText(MatrixIn, ColorFullText, I, J, MatrixOutAux), II is I + 1,
	writeCubeFaceAux(MatrixOutAux, ColorMatrix, FrameTail, II, J, MatrixOut).

writeCubeFace(MatrixIn, ColorMatrix, FaceName, I, J, MatrixOut) :-
	animations(Animations),
	writeCubeFaceAux(MatrixIn, ColorMatrix, Animations.get(FaceName), I, J, MatrixOut).

drawLogoAnimation() :-
	drawLogoAnimationAux(0).

main :-
	filledMatrix(FillMatrix), cubeMatrix(CubeMatrix),
	writeCubeFace(FillMatrix, CubeMatrix, 'Default', 0, 0, MatrixOut),
	drawMatrix(MatrixOut).

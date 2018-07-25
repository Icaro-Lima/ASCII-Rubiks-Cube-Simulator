getMatrixLine(I, A, B, C, MatrixIn, [AA, BB, CC]) :-
	nth0(I, MatrixIn, Line),

	nth0(A, Line, AA),
	nth0(B, Line, BB),
	nth0(C, Line, CC).

getMatrixCol(J, A, B, C, MatrixIn, [AA, BB, CC]) :-
	nth0(A, MatrixIn, LinhaA),
	nth0(B, MatrixIn, LinhaB),
	nth0(C, MatrixIn, LinhaC),

	nth0(J, LinhaA, AA),
	nth0(J, LinhaB, BB),
	nth0(J, LinhaC, CC).



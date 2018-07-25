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

replace(0, Element, [_|Tail], [Element|Tail]).

replace(Index, Element, [Head|Tail], [Head|TailOut]) :-
	N is Index - 1,
	replace(N, Element, Tail, TailOut).

swapL(0, Begin, End, Array, [Head|Tail], [HeadOut|Tail]) :-
	nth0(0, Array, A),
	nth0(1, Array, B),
	nth0(2, Array, C),

	replace(Begin, A, Head, AA),
	replace(Begin + 1, B, AA, BB),
	replace(End, C, BB, HeadOut).

swapL(I, Begin, End, Array, [Head|Tail], [Head|TailOut]) :-
	II is I - 1,
	swapL(II, Begin, End, Array, Tail, TailOut).

swapC(J, Begin, End, Array, MatrixIn, MatrixOut) :-
	nth0(0, Array, Array0),
	nth0(1, Array, Array1),
	nth0(2, Array, Array2),

	Beg1 is Begin + 1,

	nth0(Begin, MatrixIn, LineA),
	nth0(Beg1, MatrixIn, LineB),
	nth0(End, MatrixIn, LineC),

	replace(J, Array0, LineA, LineAA),
	replace(J, Array1, LineB, LineBB),
	replace(J, Array2, LineC, LineCC),

	replace(Begin, LineAA, MatrixIn, AA),
	replace(Beg1, LineBB, AA, BB),
	replace(End, LineCC, BB, MatrixOut).

test :-
	cubeMatrix(Matrix), swapC(0, 9, 11, [-1, -2, -3], Matrix, Out),
	writeln(Out).

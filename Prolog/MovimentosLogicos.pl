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

swapL(I, Begin, End, Array, MatrixIn, MatrixOut) :-
	nth0(0, Array, A),
	nth0(1, Array, B),
	nth0(2, Array, C),

	nth0(I, MatrixIn, Line),

	Beg1 is Begin + 1,

	replace(Begin, A, Line, Line0),
	replace(Beg1, B, Line0, Line1),
	replace(End, C, Line1, Line2),
	
	replace(I, Line2, MatrixIn, MatrixOut).


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

giraFaceHorario(Lini, Cini, Lfim, Cfim, MatrixIn, MatrixOut) :-
	Cfim1 is Cfim - 1, Lfim1 is Lfim - 1,

	getMatrixLine(Lini, Cini, Cfim1, Cfim, MatrixIn, A),
	getMatrixCol(Cfim, Lfim, Lfim1, Lini, MatrixIn, B),
	getMatrixLine(Lfim, Cini, Cfim1, Cfim, MatrixIn, C),
	getMatrixCol(Cini, Lfim, Lfim1, Lini, MatrixIn, D),

	swapL(Lini, Cini, Cfim, D, MatrixIn, MatrixIn0),
	swapC(Cini, Lini, Lfim, C, MatrixIn0, MatrixIn1),
	swapL(Lfim, Cini, Cfim, B, MatrixIn1, MatrixIn2),
	swapC(Cfim, Lini, Lfim, A, MatrixIn2, MatrixOut).

giraFaceAntiHorario(Lini, Cini, Lfim, Cfim, MatrixIn, MatrixOut) :-
	Cfim1 is Cfim - 1, Lfim1 is Lfim - 1,

	getMatrixLine(Lini, Cfim, Cfim1, Cini, MatrixIn, A),
	getMatrixCol(Cfim, Lini, Lfim1, Lfim, MatrixIn, B),
	getMatrixLine(Lfim, Cfim, Cfim1, Cini, MatrixIn, C),
	getMatrixCol(Cini, Lini, Lfim1, Lfim, MatrixIn, D),

	swapL(Lini, Cini, Cfim, B, MatrixIn, MatrixIn0),
	swapC(Cfim, Lini, Lfim, C, MatrixIn0, MatrixIn1),
	swapL(Lfim, Cini, Cfim, D, MatrixIn1, MatrixIn2),
	swapC(Cini, Lini, Lfim, A, MatrixIn2, MatrixOut).

aBaixo(MatrixIn, MatrixOut) :-
	getMatrixCol(3, 0, 1, 2, MatrixIn, A),
	getMatrixCol(3, 3, 4, 5, MatrixIn, B),
	getMatrixCol(3, 6, 7, 8, MatrixIn, C),
	getMatrixCol(3, 9, 10, 11, MatrixIn, D),

	swapC(3, 0, 2, D, MatrixIn, MatrixIn0),
	swapC(3, 3, 5, A, MatrixIn0, MatrixIn1),
	swapC(3, 6, 8, B, MatrixIn1, MatrixIn2),
	swapC(3, 9, 11, C, MatrixIn2, MatrixIn3),

	giraFaceHorario(3, 0, 5, 2, MatrixIn3, MatrixOut).

aCima(MatrixIn, MatrixOut) :-
	getMatrixCol(3, 0, 1, 2, MatrixIn, A),
	getMatrixCol(3, 3, 4, 5, MatrixIn, B),
	getMatrixCol(3, 6, 7, 8, MatrixIn, C),
	getMatrixCol(3, 9, 10, 11, MatrixIn, D),

	swapC(3, 0, 2, B, MatrixIn, MatrixIn0),
	swapC(3, 3, 5, C, MatrixIn0, MatrixIn1),
	swapC(3, 6, 8, D, MatrixIn1, MatrixIn2),
	swapC(3, 9, 11, A, MatrixIn2, MatrixIn3),

	giraFaceAntiHorario(3, 0, 5, 2, MatrixIn3, MatrixOut).

bBaixo(MatrixIn, MatrixOut) :-
	getMatrixCol(4, 0, 1, 2, MatrixIn, A),
	getMatrixCol(4, 3, 4, 5, MatrixIn, B),
	getMatrixCol(4, 6, 7, 8, MatrixIn, C),
	getMatrixCol(4, 9, 10, 11, MatrixIn, D),

	swapC(4, 0, 2, D, MatrixIn, MatrixIn0),
	swapC(4, 3, 5, A, MatrixIn0, MatrixIn1),
	swapC(4, 6, 8, B, MatrixIn1, MatrixIn2),
	swapC(4, 9, 11, C, MatrixIn2, MatrixOut).

bCima(MatrixIn, MatrixOut) :-
	getMatrixCol(4, 0, 1, 2, MatrixIn, A),
	getMatrixCol(4, 3, 4, 5, MatrixIn, B),
	getMatrixCol(4, 6, 7, 8, MatrixIn, C),
	getMatrixCol(4, 9, 10, 11, MatrixIn, D),

	swapC(4, 0, 2, B, MatrixIn, MatrixIn0),
	swapC(4, 3, 5, C, MatrixIn0, MatrixIn1),
	swapC(4, 6, 8, D, MatrixIn1, MatrixIn2),
	swapC(4, 9, 11, A, MatrixIn2, MatrixOut).

cBaixo(MatrixIn, MatrixOut) :-
	getMatrixCol(5, 0, 1, 2, MatrixIn, A),
	getMatrixCol(5, 3, 4, 5, MatrixIn, B),
	getMatrixCol(5, 6, 7, 8, MatrixIn, C),
	getMatrixCol(5, 9, 10, 11, MatrixIn, D),

	swapC(5, 0, 2, D, MatrixIn, MatrixIn0),
	swapC(5, 3, 5, A, MatrixIn0, MatrixIn1),
	swapC(5, 6, 8, B, MatrixIn1, MatrixIn2),
	swapC(5, 9, 11, C, MatrixIn2, MatrixIn3),

	giraFaceAntiHorario(3, 6, 5, 8, MatrixIn3, MatrixOut).

cCima(MatrixIn, MatrixOut) :-
	getMatrixCol(5, 0, 1, 2, MatrixIn, A),
	getMatrixCol(5, 3, 4, 5, MatrixIn, B),
	getMatrixCol(5, 6, 7, 8, MatrixIn, C),
	getMatrixCol(5, 9, 10, 11, MatrixIn, D),

	swapC(5, 0, 2, B, MatrixIn, MatrixIn0),
	swapC(5, 3, 5, C, MatrixIn0, MatrixIn1),
	swapC(5, 6, 8, D, MatrixIn1, MatrixIn2),
	swapC(5, 9, 11, A, MatrixIn2, MatrixIn3),

	giraFaceHorario(3, 6, 5, 8, MatrixIn3, MatrixOut).

zeroEsq(MatrixIn, MatrixOut) :-
	getMatrixLine(3, 0, 1, 2, MatrixIn, AA),
	getMatrixLine(3, 3, 4, 5, MatrixIn, B),
	getMatrixLine(3, 6, 7, 8, MatrixIn, C),
	getMatrixLine(11, 3, 4, 5, MatrixIn, DD),

	reverse(AA, A),
	reverse(DD, D),

	swapL(3, 0, 2, B, MatrixIn, MatrixIn0),
	swapL(3, 3, 5, C, MatrixIn0, MatrixIn1),
	swapL(3, 6, 8, D, MatrixIn1, MatrixIn2),
	swapL(11, 3, 5, A, MatrixIn2, MatrixIn3),

	giraFaceHorario(0, 3, 2, 5, MatrixIn3, MatrixOut).

zeroDir(MatrixIn, MatrixOut) :-
	getMatrixLine(3, 0, 1, 2, MatrixIn, A),
	getMatrixLine(3, 3, 4, 5, MatrixIn, B),
	getMatrixLine(3, 6, 7, 8, MatrixIn, CC),
	getMatrixLine(11, 3, 4, 5, MatrixIn, DD),

	reverse(CC, C),
	reverse(DD, D),

	swapL(3, 0, 2, D, MatrixIn, MatrixIn0),
	swapL(3, 3, 5, A, MatrixIn0, MatrixIn1),
	swapL(3, 6, 8, B, MatrixIn1, MatrixIn2),
	swapL(11, 3, 5, C, MatrixIn2, MatrixIn3),

	giraFaceAntiHorario(0, 3, 2, 5, MatrixIn3, MatrixOut).

umEsq(MatrixIn, MatrixOut) :-
	getMatrixLine(4, 0, 1, 2, MatrixIn, AA),
	getMatrixLine(4, 3, 4, 5, MatrixIn, B),
	getMatrixLine(4, 6, 7, 8, MatrixIn, C),
	getMatrixLine(10, 3, 4, 5, MatrixIn, DD),

	reverse(AA, A),
	reverse(DD, D),

	swapL(4, 0, 2, B, MatrixIn, MatrixIn0),
	swapL(4, 3, 5, C, MatrixIn0, MatrixIn1),
	swapL(4, 6, 8, D, MatrixIn1, MatrixIn2),
	swapL(10, 3, 5, A, MatrixIn2, MatrixOut).

umDir(MatrixIn, MatrixOut) :-
	getMatrixLine(4, 0, 1, 2, MatrixIn, A),
	getMatrixLine(4, 3, 4, 5, MatrixIn, B),
	getMatrixLine(4, 6, 7, 8, MatrixIn, CC),
	getMatrixLine(10, 3, 4, 5, MatrixIn, DD),

	reverse(CC, C),
	reverse(DD, D),

	swapL(4, 0, 2, D, MatrixIn, MatrixIn0),
	swapL(4, 3, 5, A, MatrixIn0, MatrixIn1),
	swapL(4, 6, 8, B, MatrixIn1, MatrixIn2),
	swapL(10, 3, 5, C, MatrixIn2, MatrixOut).

doisEsq(MatrixIn, MatrixOut) :-
	getMatrixLine(5, 0, 1, 2, MatrixIn, AA),
	getMatrixLine(5, 3, 4, 5, MatrixIn, B),
	getMatrixLine(5, 6, 7, 8, MatrixIn, C),
	getMatrixLine(9, 3, 4, 5, MatrixIn, DD),

	reverse(AA, A),
	reverse(DD, D),

	swapL(5, 0, 2, B, MatrixIn, MatrixIn0),
	swapL(5, 3, 5, C, MatrixIn0, MatrixIn1),
	swapL(5, 6, 8, D, MatrixIn1, MatrixIn2),
	swapL(9, 3, 5, A, MatrixIn2, MatrixIn3),

	giraFaceAntiHorario(6, 3, 8, 5, MatrixIn3, MatrixOut).

doisDir(MatrixIn, MatrixOut) :-
	getMatrixLine(5, 0, 1, 2, MatrixIn, A),
	getMatrixLine(5, 3, 4, 5, MatrixIn, B),
	getMatrixLine(5, 6, 7, 8, MatrixIn, CC),
	getMatrixLine(9, 3, 4, 5, MatrixIn, DD),

	reverse(CC, C),
	reverse(DD, D),

	swapL(5, 0, 2, D, MatrixIn, MatrixIn0),
	swapL(5, 3, 5, A, MatrixIn0, MatrixIn1),
	swapL(5, 6, 8, B, MatrixIn1, MatrixIn2),
	swapL(9, 3, 5, C, MatrixIn2, MatrixIn3),

	giraFaceHorario(6, 3, 8, 5, MatrixIn3, MatrixOut).

aHorario(MatrixIn, MatrixOut) :-
	getMatrixLine(2, 3, 4, 5, MatrixIn, A),
	getMatrixCol(6, 5, 4, 3, MatrixIn, B),
	getMatrixLine(6, 3, 4, 5, MatrixIn, C),
	getMatrixCol(2, 5, 4, 3, MatrixIn, D),

	swapL(2, 3, 5, D, MatrixIn, MatrixIn0),
	swapC(2, 3, 5, C, MatrixIn0, MatrixIn1),
	swapL(6, 3, 5, B, MatrixIn1, MatrixIn2),
	swapC(6, 3, 5, A, MatrixIn2, MatrixIn3),

	giraFaceHorario(3, 3, 5, 5, MatrixIn3, MatrixOut).

aAntiHorario(MatrixIn, MatrixOut) :-
	getMatrixLine(2, 5, 4, 3, MatrixIn, A),
	getMatrixCol(6, 3, 4, 5, MatrixIn, B),
	getMatrixLine(6, 5, 4, 3, MatrixIn, C),
	getMatrixCol(2, 3, 4, 5, MatrixIn, D),

	swapL(2, 3, 5, B, MatrixIn, MatrixIn0),
	swapC(6, 3, 5, C, MatrixIn0, MatrixIn1),
	swapL(6, 3, 5, D, MatrixIn1, MatrixIn2),
	swapC(2, 3, 5, A, MatrixIn2, MatrixIn3),

	giraFaceAntiHorario(3, 3, 5, 5, MatrixIn3, MatrixOut).

bHorario(MatrixIn, MatrixOut) :-
	getMatrixLine(1, 3, 4, 5, MatrixIn, A),
	getMatrixCol(7, 5, 4, 3, MatrixIn, B),
	getMatrixLine(7, 3, 4, 5, MatrixIn, C),
	getMatrixCol(1, 5, 4, 3, MatrixIn, D),

	swapL(1, 3, 5, D, MatrixIn, MatrixIn0),
	swapC(1, 3, 5, C, MatrixIn0, MatrixIn1),
	swapL(7, 3, 5, B, MatrixIn1, MatrixIn2),
	swapC(7, 3, 5, A, MatrixIn2, MatrixOut).

bAntiHorario(MatrixIn, MatrixOut) :-
	getMatrixLine(1, 5, 4, 3, MatrixIn, A),
	getMatrixCol(7, 3, 4, 5, MatrixIn, B),
	getMatrixLine(7, 5, 4, 3, MatrixIn, C),
	getMatrixCol(1, 3, 4, 5, MatrixIn, D),

	swapL(1, 3, 5, B, MatrixIn, MatrixIn0),
	swapC(7, 3, 5, C, MatrixIn0, MatrixIn1),
	swapL(7, 3, 5, D, MatrixIn1, MatrixIn2),
	swapC(1, 3, 5, A, MatrixIn2, MatrixOut).

cHorario(MatrixIn, MatrixOut) :-
	getMatrixLine(0, 3, 4, 5, MatrixIn, A),
	getMatrixCol(8, 5, 4, 3, MatrixIn, B),
	getMatrixLine(8, 3, 4, 5, MatrixIn, C),
	getMatrixCol(0, 5, 4, 3, MatrixIn, D),

	swapL(0, 3, 5, D, MatrixIn, MatrixIn0),
	swapC(0, 3, 5, C, MatrixIn0, MatrixIn1),
	swapL(8, 3, 5, B, MatrixIn1, MatrixIn2),
	swapC(8, 3, 5, A, MatrixIn2, MatrixIn3),

	giraFaceAntiHorario(9, 3, 11, 5, MatrixIn3, MatrixOut).

cAntiHorario(MatrixIn, MatrixOut) :-
	getMatrixLine(0, 3, 4, 5, MatrixIn, A),
	getMatrixCol(8, 5, 4, 3, MatrixIn, B),
	getMatrixLine(8, 3, 4, 5, MatrixIn, C),
	getMatrixCol(0, 5, 4, 3, MatrixIn, D),

	swapL(0, 3, 5, B, MatrixIn, MatrixIn0),
	swapC(8, 3, 5, C, MatrixIn0, MatrixIn1),
	swapL(8, 3, 5, D, MatrixIn1, MatrixIn2),
	swapC(0, 3, 5, A, MatrixIn2, MatrixIn3),

	giraFaceHorario(9, 3, 11, 5, MatrixIn3, MatrixOut).

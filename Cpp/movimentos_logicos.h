#include "base.h"
#include <vector>

using namespace std;

vector<int> getMatrixLine(int linha, int a, int b, int c) {
	vector<int> saida;
	saida.push_back(cube_matrix[linha][a]);
	saida.push_back(cube_matrix[linha][b]);
	saida.push_back(cube_matrix[linha][c]);
	
	return saida;
}

vector<int> getMatrixCol(int coluna, int a, int b, int c) {
	vector<int> saida;
	saida.push_back(cube_matrix[a][coluna]);
	saida.push_back(cube_matrix[b][coluna]);
	saida.push_back(cube_matrix[c][coluna]);
	
	return saida;
}

// Não precisa desse const e desse &, é apenas pra optimizar, pode deixar sem.
void swapL(int linha, int comeco, int fim, const vector<int> &array) {
	int aux = 0;
	for (int i = comeco; i <= fim; i++) {
		cube_matrix[linha][i] = array[aux];
		aux += 1;
	}
}

void swapC(int coluna, int comeco, int fim, const vector<int> &array) {
	int aux = 0;
	for (int i = comeco; i <= fim; i++) {
		cube_matrix[i][coluna] = array[aux];
		aux += 1;
	}
}

void giraFaceAntiHorario(int lIni, int cIni, int lFim, int cFim) {
	vector<int> a = getMatrixLine(lIni, cFim, cFim - 1, cIni);
	vector<int> b = getMatrixCol(cFim, lIni, lFim - 1, lFim);
	vector<int> c = getMatrixLine(lFim, cFim, cFim - 1, cIni);
	vector<int> d = getMatrixCol(cIni, lIni, lFim - 1, lFim);
	
	swapL(lIni, cIni, cFim, b);
	swapC(cFim, lIni, lFim, c);
	swapL(lFim, cIni, cFim, d);
	swapC(cIni, lIni, lFim, a);
}

void giraFaceHorario(int lIni, int cIni, int lFim, int cFim) {
	vector<int> a = getMatrixLine(lIni, cIni, cFim - 1, cFim);
	vector<int> b = getMatrixCol(cFim, lFim, lFim - 1, lIni);
	vector<int> c = getMatrixLine(lFim, cIni, cFim - 1, cFim);
	vector<int> d = getMatrixCol(cIni, lFim, lFim - 1, lIni);
	
	swapL(lIni, cIni, cFim, d);
	swapC(cIni, lIni, lFim, c);
	swapL(lFim, cIni, cFim, b);
	swapC(cFim, lIni, lFim, a);
}

void aAntiHorario() {
	vector<int> a = getMatrixLine(2, 5, 4, 3);
	vector<int> b = getMatrixCol(6, 3, 4, 5);
	vector<int> c = getMatrixLine(6, 5, 4, 3);
	vector<int> d = getMatrixCol(2, 3, 4, 5);
	
	swapL(2, 3, 5, b);
	swapC(6, 3, 5, c);
	swapL(6, 3, 5, d);
	swapC(2, 3, 5, a);
	
	giraFaceAntiHorario(3, 3, 5, 5);
}

void aHorario() {
	vector<int> a = getMatrixLine(2, 3, 4, 5);
	vector<int> b = getMatrixCol(6, 5, 4, 3);
	vector<int> c = getMatrixLine(6, 3, 4, 5);
	vector<int> d = getMatrixCol(2, 5, 4, 3);
	
	swapL(2, 3, 5, d);
	swapC(2, 3, 5, c);
	swapL(6, 3, 5, b);
	swapC(6, 3, 5, a);
	
	giraFaceHorario(3, 3, 5, 5);
}

void bAntiHorario() {
	vector<int> a = getMatrixLine(1, 5, 4, 3);
	vector<int> b = getMatrixCol(7, 3, 4, 5);
	vector<int> c = getMatrixLine(7, 5, 4, 3);
	vector<int> d = getMatrixCol(1, 3, 4, 5);
	
	swapL(1, 3, 5, b);
	swapC(7, 3, 5, c);
	swapL(7, 3, 5, d);
	swapC(1, 3, 5, a);
}
	
void bHorario() {
	vector<int> a = getMatrixLine(1, 3, 4, 5);
	vector<int> b = getMatrixCol(7, 5, 4, 3);
	vector<int> c = getMatrixLine(7, 3, 4, 5);
	vector<int> d = getMatrixCol(1, 5, 4, 3);
	
	swapL(1, 3, 5, d);
	swapC(1, 3, 5, c);
	swapL(7, 3, 5, b);
	swapC(7, 3, 5, a);
}

void cAntiHorario() {
	vector<int> a = getMatrixLine(0, 5, 4, 3);
	vector<int> b = getMatrixCol(8, 3, 4, 5);
	vector<int> c = getMatrixLine(8, 5, 4, 3);
	vector<int> d = getMatrixCol(0, 3, 4, 5);
	
	swapL(0, 3, 5, b);
	swapC(8, 3, 5, c);
	swapL(8, 3, 5, d);
	swapC(0, 3, 5, a);
	
	giraFaceHorario(9, 3, 11, 5);
}

void cHorario() {
	vector<int> a = getMatrixLine(0, 3, 4, 5);
	vector<int> b = getMatrixCol(8, 5, 4, 3);
	vector<int> c = getMatrixLine(8, 3, 4, 5);
	vector<int> d = getMatrixCol(0, 5, 4, 3);
	
	swapL(0, 3, 5, d);
	swapC(0, 3, 5, c);
	swapL(8, 3, 5, b);
	swapC(8, 3, 5, a);
	
	giraFaceAntiHorario(9, 3, 11, 5);
}


void zeroEsq() {
	vector<int> a = getMatrixLine(3, 0, 1, 2);
	vector<int> b = getMatrixLine(3, 3, 4, 5);
	vector<int> c = getMatrixLine(3, 6, 7, 8);
	vector<int> d = getMatrixLine(11, 3, 4, 5);
		
	swapL(3, 0, 2, b);
	swapL(3, 3, 5, c);
	swapL(3, 6, 8, d);
	swapL(11, 3, 5, a);
	
	giraFaceHorario(0, 3, 2, 5);
}

void zeroDir() {
	vector<int> a = getMatrixLine(3, 0, 1, 2);
	vector<int> b = getMatrixLine(3, 3, 4, 5);
	vector<int> c = getMatrixLine(3, 6, 7, 8);
	vector<int> d = getMatrixLine(11, 3, 4, 5);
		
	swapL(3, 0, 2, d);
	swapL(3, 3, 5, a);
	swapL(3, 6, 8, b);
	swapL(11, 3, 5, c);
		
	giraFaceAntiHorario(0, 3, 2, 5);
}

void umEsq() {
	vector<int> a = getMatrixLine(4, 0, 1, 2);
	vector<int> b = getMatrixLine(4, 3, 4, 5);
	vector<int> c = getMatrixLine(4, 6, 7, 8);
	vector<int> d = getMatrixLine(10, 3, 4, 5);
		
	swapL(4, 0, 2, b);
	swapL(4, 3, 5, c);
	swapL(4, 6, 8, d);
	swapL(10, 3, 5, a);
}

void umDir() {
	vector<int> a = getMatrixLine(4, 0, 1, 2);
	vector<int> b = getMatrixLine(4, 3, 4, 5);
	vector<int> c = getMatrixLine(4, 6, 7, 8);
	vector<int> d = getMatrixLine(10, 3, 4, 5);
		
	swapL(4, 0, 2, d);
	swapL(4, 3, 5, a);
	swapL(4, 6, 8, b);
	swapL(10, 3, 5, c);
}

void doisEsq() {
	vector<int> a = getMatrixLine(5, 0, 1, 2);
	vector<int> b = getMatrixLine(5, 3, 4, 5);
	vector<int> c = getMatrixLine(5, 6, 7, 8);
	vector<int> d = getMatrixLine(9, 3, 4, 5);
		
	swapL(5, 0, 2, b);
	swapL(5, 3, 5, c);
	swapL(5, 6, 8, d);
	swapL(9, 3, 5, a);
	
	giraFaceAntiHorario(6, 3, 8, 5);
}

void doisDir() {
	vector<int> a = getMatrixLine(5, 0, 1, 2);
	vector<int> b = getMatrixLine(5, 3, 4, 5);
	vector<int> c = getMatrixLine(5, 6, 7, 8);
	vector<int> d = getMatrixLine(9, 3, 4, 5);
		
	swapL(5, 0, 2, d);
	swapL(5, 3, 5, a);
	swapL(5, 6, 8, b);
	swapL(9, 3, 5, c);
	
	giraFaceHorario(6, 3, 8, 5);
}

void ABaixo() {
	vector<int> a = getMatrixCol(3, 0, 1, 2);
	vector<int> b = getMatrixCol(3, 3, 4, 5);
	vector<int> c = getMatrixCol(3, 6, 7, 8);
	vector<int> d = getMatrixCol(3, 9, 10, 11);
		
	swapC(3, 0, 2, d);
	swapC(3, 3, 5, a);
	swapC(3, 6, 8, b);
	swapC(3, 9, 11, c);
	
	giraFaceHorario(3, 0, 5, 2);
}

void ACima() {
	
	vector<int> a = getMatrixCol(3, 0, 1, 2);
	vector<int> b = getMatrixCol(3, 3, 4, 5);
	vector<int> c = getMatrixCol(3, 6, 7, 8);
	vector<int> d = getMatrixCol(3, 9, 10, 11);
		
	swapC(3, 0, 2, b);
	swapC(3, 3, 5, c);
	swapC(3, 6, 8, d);
	swapC(3, 9, 11, a);
		
	giraFaceAntiHorario(3, 0, 5, 2);
}

void BBaixo() {
	vector<int> a = getMatrixCol(4, 0, 1, 2);
	vector<int> b = getMatrixCol(4, 3, 4, 5);
	vector<int> c = getMatrixCol(4, 6, 7, 8);
	vector<int> d = getMatrixCol(4, 9, 10, 11);
		
	swapC(4, 0, 2, d);
	swapC(4, 3, 5, a);
	swapC(4, 6, 8, b);
	swapC(4, 9, 11, c);
}

void BCima() {
	vector<int> a = getMatrixCol(4, 0, 1, 2);
	vector<int> b = getMatrixCol(4, 3, 4, 5);
	vector<int> c = getMatrixCol(4, 6, 7, 8);
	vector<int> d = getMatrixCol(4, 9, 10, 11);
		
	swapC(4, 0, 2, b);
	swapC(4, 3, 5, c);
	swapC(4, 6, 8, d);
	swapC(4, 9, 11, a);
}

void CBaixo() {
	vector<int> a = getMatrixCol(5, 0, 1, 2);
	vector<int> b = getMatrixCol(5, 3, 4, 5);
	vector<int> c = getMatrixCol(5, 6, 7, 8);
	vector<int> d = getMatrixCol(5, 9, 10, 11);
		
	swapC(5, 0, 2, d);
	swapC(5, 3, 5, a);
	swapC(5, 6, 8, b);
	swapC(5, 9, 11, c);
	
	giraFaceAntiHorario(3, 6, 5, 8);
}

void CCima() {
	vector<int> a = getMatrixCol(5, 0, 1, 2);
	vector<int> b = getMatrixCol(5, 3, 4, 5);
	vector<int> c = getMatrixCol(5, 6, 7, 8);
	vector<int> d = getMatrixCol(5, 9, 10, 11);
		
	swapC(5, 0, 2, b);
	swapC(5, 3, 5, c);
	swapC(5, 6, 8, d);
	swapC(5, 9, 11, a);
		
	giraFaceHorario(3, 6, 5, 8);
}

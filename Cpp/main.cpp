#include <map>
#include <string>
#include <vector>
#include <fstream>
#include <iomanip>
#include <unistd.h>
#include <iostream>
#include <sys/ioctl.h>


using namespace std;


const string assets_path = "../Assets";

map< string, vector<string> > animations;
string ** matrix; // Matriz que armazena o estado atual das 'escrituras', antes de ser desenhada no terminal.
unsigned int rows, cols; // Tamanho do terminal, que também é o tamanho da matrix.

/**
 * AUXILIAR!
 * Lê um arquivo e retorna suas linhas em forma de um vetor de strings.
 */
vector<string> read_file(string file_path) {
    vector<string> vector_result;

    ifstream myfile;
    myfile.open(file_path);

    string temp;
    while (getline(myfile, temp)) {
        vector_result.push_back(temp);
    }

    myfile.close();

    return vector_result;
}

/**
 * AUXILIAR!
 * Carrega as animações.
 */
void load_animations() {
    string cube_path = assets_path + "/Cubo";

    animations["Default"] = read_file(cube_path + "/Default.txt");

    vector<string> names;
    names.push_back("0Left");
    names.push_back("1Left");
    names.push_back("2Left");
    names.push_back("0Right");
    names.push_back("1Right");
    names.push_back("2Right");

    names.push_back("AUp");
    names.push_back("BUp");
    names.push_back("CUp");
    names.push_back("ADown");
    names.push_back("BDown");
    names.push_back("CDown");

    names.push_back("aClockwise");
    names.push_back("bClockwise");
    names.push_back("cClockwise");
    names.push_back("aCounterclockwise");
    names.push_back("bCounterclockwise");
    names.push_back("cCounterclockwise");

    for (unsigned int i = 0; i < names.size(); i++) {
        for (int j = 0; j < 5; j++) {
            string name = names[i] + "_";
            name += (char)(j + 48);
            animations[name] = read_file(cube_path + "/"  + names[i] + "/" + (char)(48 + j) + ".txt");
        }
    }
}

/**
 * AUXILIAR!
 * Preenche a matriz com espaços.
 */
void fill_matrix() {
    for (unsigned int i = 0; i < rows; i++) {
        for (unsigned int j = 0; j < cols; j++) {
            matrix[i][j] = ' ';
        }
    }
}

/**
 * Desenha um frame e logo em seguida apaga toda a matriz.
 */
void draw_matrix() {
    for (unsigned int i = 0; i < rows; i++) {
        for (unsigned int j = 0; j < cols; j++) {
            cout << matrix[i][j];
        }

        if (i < rows - 1) {
            cout << endl;
        }
    }

    fill_matrix();
}

/**
 * Escreve texto em uma determinada posição (os espaços são transparentes).
 */
void write_text(unsigned int i, unsigned int j, const string &text) {
    for (unsigned int jj = 0; jj < text.length(); jj++) {
        if (text[jj] != ' ' && i < rows && j + jj < cols) {
            matrix[i][j + jj] = text[jj];
        }
    }
}

/**
 * Desenha um frame do cubo em uma determinada posição.
 */
void write_cube_face(int i, int j, string face_name) {
    vector<string> lines = animations[face_name];
    for (unsigned int ii = 0; ii < lines.size(); ii++) {
        write_text(ii + i, j, lines[ii]);
    }
}

/**
 * Pega o tamanho do console, 
 * cria uma matriz de strings, 
 * preenche essa matriz com espaços e 
 * carrega as animações."
 */
void setup() {
    cout << "Poderia expandir todo o terminal? (PRESSIONE ENTER)" << endl;
    cin.ignore();

    struct winsize terminal_size;
    ioctl(STDOUT_FILENO, TIOCGWINSZ, &terminal_size);
    rows = terminal_size.ws_row;
    cols = terminal_size.ws_col;

    matrix = new string *[rows];
    for (unsigned int i = 0; i < rows; i++) {
        matrix[i] = new string [cols];
    }

    fill_matrix();

    load_animations();

    cout << "Configurado! Mantenha o tamanho. (PRESSIONE ENTER)" << endl;
    cin.ignore();
}

int main() {
    setup();

	// Frame trivial:
	write_text(0, 0, "Olá mundo!");
    draw_matrix();
    usleep(3000000);
    
    //Frame trivial com texto centralizado:
    string texto = "Olá mundo!";
    write_text(rows / 2, cols / 2 - texto.length() / 2, texto);
    draw_matrix();
    usleep(3000000);
    
    //Frame composto:
    write_text(10, 10, "Nos duas fomos desenhadas");
    write_text(20, 20, "no mesmo frame ;D");
    draw_matrix();
    usleep(3000000);
    
    //Frame com um frame estático do cubo:
    write_text(0, 0, "O cubo esta sendo desenhado na posicao 10i10j.");
    write_cube_face(10, 10, "Default");
    draw_matrix();
    usleep(3000000);
    
    // Desenhando uma animação real do cubo:
    while (true) {
		for (int i = 0; i < 5; i++) {
			write_cube_face(0, 0, "BUp_" + to_string(i));
			draw_matrix();
			usleep(1000000);
		}
		write_cube_face(0, 0, "Default");
		draw_matrix();
		usleep(1000000);
	}
        
    cin.ignore();
}

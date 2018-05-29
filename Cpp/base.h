#include <map>
#include <vector>
#include <fstream>
#include <unistd.h>
#include <iostream>
#include <sys/ioctl.h>

using namespace std;

const string assets_path = "../Assets";

int cube_matrix[12][9]
{{000, 000, 000, 101, 101, 101, 000, 000, 000},
 {000, 000, 000, 101, 101, 101, 000, 000, 000},
 {000, 000, 000, 101, 101, 101, 000, 000, 000},
 {102, 102, 102, 103, 103, 103, 44, 44, 44},
 {102, 102, 102, 103, 103, 103, 44, 44, 44},
 {102, 102, 102, 103, 103, 103, 44, 44, 44},
 {000, 000, 000, 45, 45, 45, 000, 000, 000},
 {000, 000, 000, 45, 45, 45, 000, 000, 000},
 {000, 000, 000, 45, 45, 45, 000, 000, 000},
 {000, 000, 000, 100, 100, 100, 000, 000, 000},
 {000, 000, 000, 100, 100, 100, 000, 000, 000},
 {000, 000, 000, 100, 100, 100, 000, 000, 000}};


map< string, vector<string> > animations;
string ** matrix; // Matriz que armazena o estado atual das 'escrituras', antes de ser desenhada no terminal.
unsigned int rows, cols; // Tamanho do terminal, que também é o tamanho da matrix.
int cubo_mid_col;

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
    cubo_mid_col = cols / 2 - animations["Default"][0].length() / 2 - 8;

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
    
    for (unsigned int i = 0; i < 44; i++) {
		string name = "Logo_" + to_string(i);
		animations[name] = read_file(assets_path + "/Logo/" + to_string(i) + ".txt");
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
 * Pega o tamanho do console, 
 * cria uma matriz de strings, 
 * preenche essa matriz com espaços e 
 * carrega as animações."
 */
void setup() {
    cout << "Poderia expandir todo o terminal? (PRESSIONE ENTER APÓS EXPANDIR)" << endl;
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



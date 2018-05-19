#include <map>
#include <vector>
#include <fstream>
#include <iomanip>
#include <unistd.h>
#include <iostream>
#include <sys/ioctl.h>


using namespace std;


const string assets_path = "../Assets";

map< string, vector<string> > animations;
string ** matrix;
int rows, cols;

vector<string> read_file(string file_path) {
    vector<string> vector_result;

    ifstream myfile;
    myfile.open(file_path.c_str());

    string temp;
    while (getline(myfile, temp)) {
        vector_result.push_back(temp);
    }

    myfile.close();

    return vector_result;
}


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

    for (int i = 0; i < names.size(); i++) {
        for (int j = 0; j < 5; j++) {
            string name = names[i] + "_";
            name += (char)(j + 48);
            animations[name] = read_file(cube_path + "/"  + names[i] + "/" + (char)(48 + j) + ".txt");
        }
    }
}

void fill_matrix() {
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            matrix[i][j] = ' ';
        }
    }
}

void draw_matrix() {
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            cout << matrix[i][j];
        }

        if (i < rows - 1) {
            cout << endl;
        }
    }

    fill_matrix();
}

void write_text(int i, int j, const string &text) {
    for (int jj = 0; jj < text.length(); jj++) {
        if (text[jj] != ' ' && i < rows && j + jj < cols) {
            matrix[i][j + jj] = text[jj];
        }
    }
}

void write_cube_face(int i, int j, string face_name) {
    vector<string> lines = animations[face_name];
    for (int ii = 0; ii < lines.size(); ii++) {
        write_text(ii + i, j, lines[ii]);
    }
}

void setup() {
    cout << "Poderia expandir todo o terminal? (PRESSIONE ENTER)" << endl;
    cin.ignore();

    struct winsize terminal_size;
    ioctl(STDOUT_FILENO, TIOCGWINSZ, &terminal_size);
    rows = terminal_size.ws_row;
    cols = terminal_size.ws_col;

    matrix = new string *[rows];
    for (int i = 0; i < rows; i++) {
        matrix[i] = new string [cols];
    }

    fill_matrix();

    load_animations();

    cout << "Configurado! Mantenha o tamanho. (PRESSIONE ENTER)" << endl;
    cin.ignore();
}

int main() {
    setup();

    write_cube_face(0, 0, "Default");
    draw_matrix();
    usleep(1000000);


    cin.ignore();
}

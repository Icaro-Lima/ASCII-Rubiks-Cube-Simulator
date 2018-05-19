#include <iomanip>
#include <unistd.h>
#include <iostream>
#include <sys/ioctl.h>


using namespace std;


string ** matrix;
int rows, cols;

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
        matrix[i][j + jj] = text[jj];
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

    cout << "Configurado! Mantenha o tamanho. (PRESSIONE ENTER)" << endl;
    cin.ignore();
}

int main() {
    setup();
    cin.ignore();
}
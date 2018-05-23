#include <map>
#include <string>
#include <vector>
#include <fstream>
#include <iomanip>
#include <unistd.h>
#include <iostream>
#include <bits/stdc++.h>
#include <sys/ioctl.h>


using namespace std;


const string assets_path = "../Assets";

int cube_matrix[12][9]
 
{{000, 000, 000, 101, 101, 101, 000, 000, 000},
 {000, 000, 000, 101, 101, 101, 000, 000, 000},
 {000, 000, 000, 101, 101, 101, 000, 000, 000},
 {102, 102, 102, 103, 103, 103, 044, 044, 044},
 {102, 102, 102, 103, 103, 103, 044, 044, 044},
 {102, 102, 102, 103, 103, 103, 044, 044, 044},
 {000, 000, 000, 045, 045, 045, 000, 000, 000},
 {000, 000, 000, 045, 045, 045, 000, 000, 000},
 {000, 000, 000, 045, 045, 045, 000, 000, 000},
 {000, 000, 000, 100, 100, 100, 000, 000, 000},
 {000, 000, 000, 100, 100, 100, 000, 000, 000},
 {000, 000, 000, 100, 100, 100, 000, 000, 000}};


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
void write_sprite(int i, int j, string sprite_name) {
    vector<string> lines = animations[sprite_name];
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

/**
 * Escreve o menu na tela
 */
void draw_menu() {
	// Escreve menu do jogo
    string g_name = "-----------------------  RUBIK CUBE SIMULATOR -----------------------";
    string opcao_1 = "Pressione I para Instruções";
    string opcao_2 = "Pressione J para Jogar";
    string team_name = "Icaro Dantas, Igor Farias, Javan Lacerda, Lucas Araújo, Sérgio Duarte";
    int g_name_col = cols/2 - g_name.length() + 30;
    write_text(5, g_name_col, g_name);
    write_text(8, g_name_col + 20, opcao_1);
    write_text(9, g_name_col + 20, opcao_2);
    write_text(11, g_name_col, team_name);
    draw_matrix();
}

/**
 * Escreve as instruções do jogo na tela
 */
void draw_instructions() {
		int i = 5;
		
		write_text(i++, cols/2.7, "7 - Rotaciona primeira linha em sentido horário");
		write_text(i++, cols/2.7, "9 - Rotaciona primeira linha em sentido anti-horário");
		write_text(i++, cols/2.7, "4 - Rotaciona segunda linha em sentido horário");
		write_text(i++, cols/2.7, "6 - Rotaciona segunda linha em sentido anti-horário");
		write_text(i++, cols/2.7, "1 - Rotaciona terceira linha em sentido horário");
		write_text(i++, cols/2.7, "3 - Rotaciona terceira linha em sentido anti-horário");
		write_text(i++, cols/2.7, "R - Rotaciona primeira coluna para cima");
		write_text(i++, cols/2.7, "T - Rotciona segunda coluna para cima");
		write_text(i++, cols/2.7, "Y - Rotaciona terceira coluna para cima");
		write_text(i++, cols/2.7, "F - Rotaciona primeira coluna para baixo");
		write_text(i++, cols/2.7, "G - Rotaciona segunda coluna para baixo");
		write_text(i++, cols/2.7, "H - Rotaciona terceira coluna para baixo");
		write_text(i++, cols/2.7, "Pressione J para Jogar");
		write_text(i++, cols/2.7, "Pressione Q para voltar ao Menu");
		draw_matrix();
}

// Exemplo: wait_key(new char[4] { 'w', 'a', 's', 'd' }, 4)
char wait_key(char * possible_keys, int count) {
	system ("/bin/stty raw");

	while (true) {
		char x = getchar();
		cout << '\b' << ' ' << '\b';
		for (int i = 0; i < count; i++) {
			if (x == possible_keys[i]) {
				system ("/bin/stty cooked");
				return x;
			}
		}
		usleep(10000);
	}
	
}


/**
 * Desenha o cubo em formato padrão	
 */
void draw_default_cube(int row, int col) {
    write_sprite(row, col, "Default");
    draw_matrix();
}

/**
 * Rotaciona a primeira linha em sentido horário
 */
void rotate_first_row_left(int row, int col) {
	for (int i = 0; i < 5; i++) {
		write_sprite(row, col, "0Left_" + to_string(i));
		draw_matrix();
		usleep(1000000);
	}
	write_sprite(row, col, "Default");
	draw_matrix();
	usleep(1000000);
}

/**
 * Inicia o jogo
 */
void start_game(int row, int col) {
	char command = wait_key(new char[12] { '7', '9', '4', '6', '1', '3', 'R', 'T', 'Y', 'F', 'G', 'H'}, 12);
	
	if (command == '7') {
		rotate_first_row_left(row, col);
		start_game(row, col);
	} else {
		cin.ignore();
	}
	
	
}


// Exibe menu de opções
void menu_options() {
	char input = wait_key(new char[6] { 'i', 'I', 'j', 'J', 'q', 'Q' }, 6);
	
	if (input == 'i' || input == 'I') {
		draw_instructions();
	} else if (input == 'q' || input == 'Q') {
		draw_menu();
	} else {
	int mid_screen = rows/2;
	write_text(2, mid_screen + 20, "Bem vindo ao Rubik Cube Simulator!");
    draw_default_cube(2, mid_screen);
    start_game(2, mid_screen);
	usleep(3000000);
	}
	
	menu_options();
	cin.ignore();
}



int main() {
    setup();
    
    // Escreve menu do jogo
    draw_menu();
    
	menu_options();
	
    
    /* Frame trivial:
	write_text(0, 0, "Olá mundo!");
    draw_matrix();
    usleep(3000000);
    
    //Frame trivial com texto centralizado:
    string texto = "Olá mundo!";
    write_text(rows / 2, cols / 2 - texto.length() / 2, texto);
    draw_matrix();
    usleep(3000000);*/
    
    
    //Frame com um frame estático do cubo:
    /*
    write_text(0, 0, "Bem vindo ao Rubik Cube Simulator!");
    write_sprite(10, 10, "Default");
    draw_matrix();
    usleep(3000000);*/
    
    // Desenhando uma animação real do cubo:
    
    /* while (true) {
		for (int i = 0; i < 5; i++) {
			write_sprite(0, 0, "BUp_" + to_string(i));
			draw_matrix();
			usleep(1000000);
		}
		write_sprite(0, 0, "Default");
		draw_matrix();
		usleep(1000000);
	}
    
    cin.ignore();*/
}

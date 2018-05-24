#include "base.h"

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
void draw_instructions(int row, int col) {
		int i = row;
		
		write_text(i++, col, "7 - Rotaciona primeira linha em sentido horário");
		write_text(i++, col, "9 - Rotaciona primeira linha em sentido anti-horário");
		write_text(i++, col, "4 - Rotaciona segunda linha em sentido horário");
		write_text(i++, col, "6 - Rotaciona segunda linha em sentido anti-horário");
		write_text(i++, col, "1 - Rotaciona terceira linha em sentido horário");
		write_text(i++, col, "3 - Rotaciona terceira linha em sentido anti-horário");
		write_text(i++, col, "Q - Rotaciona primeira coluna para cima");
		write_text(i++, col, "W - Rotciona segunda coluna para cima");
		write_text(i++, col, "E - Rotaciona terceira coluna para cima");
		write_text(i++, col, "A - Rotaciona primeira coluna para baixo");
		write_text(i++, col, "S - Rotaciona segunda coluna para baixo");
		write_text(i++, col, "D - Rotaciona terceira coluna para baixo");
		write_text(i++, col, "R - Rotaciona primeira face em sentido horário");
		write_text(i++, col, "T - Rotaciona segunda face em sentido horário");
		write_text(i++, col, "Y - Rotaciona terceira face em sentido horário");
		write_text(i++, col, "F - Rotaciona primeira face em sentido anti-horário");
		write_text(i++, col, "G - Rotaciona segunda face em sentido anti-horário");
		write_text(i++, col, "H - Rotaciona terceira face em sentido anti-horário");
		write_text(i++, col, "Pressione J para Jogar");
		write_text(i++, col, "Pressione M para voltar ao Menu");
		draw_matrix();
}

void write_cube(int i, int j, string sprite_name){
	vector<string> lines = animations[sprite_name];
    for (unsigned int ii = 0; ii < lines.size(); ii++) {
		string line = lines[ii];
		
		int cod = -1;
		bool looked = false;
		for(int k = (int)line.length() - 1; k >= 0; k--){
			if ((line[k] >= 48 && line[k] <= 56) || (line[k] >= 65 && line[k] <= 88) || (line[k] >= 97 && line[k] <= 120)) {				
				if (!looked) {
					looked = true;
					
					if (line[k] >= 65 && line[k] <= 76) {
						cod = cube_matrix[line[k] - 65][3];
					} else if (line[k] >= 77 && line[k] <= 88) {
						cod = cube_matrix[line[k] - 77][4];
					} else if (line[k] >= 97 && line[k] <= 108) {
						cod = cube_matrix[line[k] - 97][5];
					} else if (line[k] >= 109 && line[k] <= 120) {
						cod = line[k] - 109;
						int row = cod / 3;
						int col = cod % 3;
						
						cod = cube_matrix[row + 3][col + 6];
					} else if (line[k] >= 48 && line[k] <= 56) {
						cod = line[k] - 48;
						int row = cod / 3;
						int col = cod % 3;
						
						cod = cube_matrix[row + 3][col];
					}
					
					line.insert(k + 1, "\033[0m");
				}
				
				line[k] = ' ';
			} else {
				if (looked) {
					looked = false;
					line.insert(k + 1, "\033[" + to_string(cod) + "m");
				}
			}
		}

        write_text(ii + i, j, line);
    }
	
}


/**
 * Desenha o cubo em formato padrão	
 */
void draw_default_cube(int row, int col) {
    write_sprite(row, col, "Default");
    draw_matrix();
}

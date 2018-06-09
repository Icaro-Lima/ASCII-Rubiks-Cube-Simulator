#include "base.h"

// Exemplo: wait_key(new char[4] { 'w', 'a', 's', 'd' }, 4)
/**
 * Aguarda receber um dos caracteres definidos como parâmetro e o retorna
 */
char wait_key(char * possible_keys, int count) {
	system("/bin/stty raw");
	while (true)
	{
		char x = getchar();
		//printf("\b \b");
		for (int i = 0; i < count; i++)
		{
			if (x == possible_keys[i])
			{
				system("/bin/stty cooked");
				return x;
			}
		}
		usleep(10000);
	}
}

/**
 * Escreve texto em uma determinada posição (os espaços são transparentes).
 */
void write_text(unsigned int i, unsigned int j, const string &text)
{
	for (unsigned int jj = 0; jj < text.length(); jj++)
	{
		if (i < rows)
		{
			matrix[i][j + jj] = text[jj];
		}
	}
}

/**
 * Desenha um frame e logo em seguida apaga toda a matriz.
 */
void draw_matrix()
{
	string acum = "";
	for (unsigned int i = 0; i < rows - 1; i++)
	{
		for (unsigned int j = 0; matrix[i][j] != '\0'; j++)
		{
			acum += matrix[i][j];
			//printf("%c", matrix[i][j]);
		}

		if (i < rows - 1)
		{
			acum += '\n';
			//printf("\n");
		}
	}
	cout << acum << endl;

	fill_matrix();
}

/**
 * Escreve o menu do jogo na tela
 */
void draw_menu() {
    string g_name = "-----------------------  RUBIK CUBE SIMULATOR -----------------------";
    string opcao_1 = "Pressione I para Instruções";
    string opcao_2 = "Pressione J para Jogar";
    string opcao_3 = "Pressione ESC para Sair";
    string team_name = "Icaro Dantas, Igor Farias, Javan Lacerda, Lucas Araújo, Sérgio Duarte";
    write_text(5, cols / 2 - g_name.length() / 2, g_name);
    write_text(8, cols / 2 - opcao_1.length() / 2, opcao_1);
    write_text(9, cols / 2 - opcao_2.length() / 2, opcao_2);
    write_text(10, cols / 2 - opcao_3.length() / 2, opcao_3);
    write_text(12, cols / 2 - team_name.length() / 2, team_name);
    draw_matrix();
}

/**
 * Escreve as instruções do jogo na tela
 */
void write_instructions(int row, int col, bool ingame) {
		int i = row;
		
		write_text(i++, col, "7 - Rotaciona 1a linha em sentido horario");
		write_text(i++, col, "9 - Rotaciona 1a linha em sentido anti-horario");
		write_text(i++, col, "4 - Rotaciona 2a linha em sentido horario");
		write_text(i++, col, "6 - Rotaciona 2a linha em sentido anti-horario");
		write_text(i++, col, "1 - Rotaciona 3a linha em sentido horario");
		write_text(i++, col, "3 - Rotaciona 3a linha em sentido anti-horario");
		write_text(i++, col, "Q - Rotaciona 1a coluna para cima");
		write_text(i++, col, "W - Rotaciona 2a coluna para cima");
		write_text(i++, col, "E - Rotaciona 3a coluna para cima");
		write_text(i++, col, "A - Rotaciona 1a coluna para baixo");
		write_text(i++, col, "S - Rotaciona 2a coluna para baixo");
		write_text(i++, col, "D - Rotaciona 3a coluna para baixo");
		write_text(i++, col, "R - Rotaciona 1a face em sentido horario");
		write_text(i++, col, "T - Rotaciona 2a face em sentido horario");
		write_text(i++, col, "Y - Rotaciona 3a face em sentido horario");
		write_text(i++, col, "F - Rotaciona 1a face em sentido anti-horario");
		write_text(i++, col, "G - Rotaciona 2a face em sentido anti-horario");
		write_text(i++, col, "H - Rotaciona 3a face em sentido anti-horario");
		write_text(i++, col, "X - Embaralha o cubo");
		write_text(++i, col, "ESC - Sair do jogo");
		write_text(++i, col, "Pressione M para voltar ao Menu");
		
		if (ingame == false) {
			write_text(++i, col, "Pressione J para Jogar");
		}
}

/**
 * Escreve em uma face qualquer do cubo aplicando a cor necessária.
 * 
 */
void write_cube(int i, int j, string sprite_name, bool instructions = true)
{
	if (instructions) write_instructions(i + 8, 0, true);
	
	vector<string> lines = animations[sprite_name];
	for (unsigned int ii = 0; ii < lines.size(); ii++)
	{
		string line = lines[ii];

		int cod = -1;
		bool looked = false;
		for (int k = (int)line.length() - 1; k >= 0; k--)
		{
			if ((line[k] >= 48 && line[k] <= 56) || (line[k] >= 65 && line[k] <= 88) || (line[k] >= 97 && line[k] <= 120))
			{
				if (!looked)
				{
					looked = true;

					if (line[k] >= 65 && line[k] <= 76)
					{
						cod = cube_matrix[line[k] - 65][3];
					}
					else if (line[k] >= 77 && line[k] <= 88)
					{
						cod = cube_matrix[line[k] - 77][4];
					}
					else if (line[k] >= 97 && line[k] <= 108)
					{
						cod = cube_matrix[line[k] - 97][5];
					}
					else if (line[k] >= 109 && line[k] <= 120)
					{
						cod = line[k] - 109;
						int row = cod / 3;
						int col = cod % 3;

						cod = cube_matrix[row + 3][col + 6];
					}
					else if (line[k] >= 48 && line[k] <= 56)
					{
						cod = line[k] - 48;
						int row = cod / 3;
						int col = cod % 3;

						cod = cube_matrix[row + 3][col];
					}

					line.insert(k + 1, "\033[0m");
				}

				line[k] = ' ';
			}
			else
			{
				if (looked)
				{
					looked = false;
					line.insert(k + 1, "\033[" + to_string(cod) + "m");
				}
			}
		}

		write_text(ii + i, j, line);
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

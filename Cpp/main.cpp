#include "api.h"
#include "movimentos_logicos.h"

#define esc 27
#define CUBE_ORIGIN_ROW 0

using namespace std;

void menu_options();

/**
 * Rotaciona a linha ou coluna desejada conforme passado por parâmetro.
 * (rotate)
    **/
void rotate_cube(string rotate)
{
	for (int i = 0; i < 5; i++)
	{
		write_cube(CUBE_ORIGIN_ROW, cubo_mid_col, rotate + to_string(i));
		draw_matrix();
		usleep(50000);
	}

	if (rotate == "0Left_")
	{
		zeroEsq();
	}
	else if (rotate == "0Right_")
	{
		zeroDir();
	}
	else if (rotate == "1Left_")
	{
		umEsq();
	}
	else if (rotate == "1Right_")
	{
		umDir();
	}
	else if (rotate == "2Left_")
	{
		doisEsq();
	}
	else if (rotate == "2Right_")
	{
		doisDir();
	}
	else if (rotate == "AUp_")
	{
		ACima();
	}
	else if (rotate == "ADown_")
	{
		ABaixo();
	}
	else if (rotate == "BUp_")
	{
		BCima();
	}
	else if (rotate == "BDown_")
	{
		BBaixo();
	}
	else if (rotate == "CUp_")
	{
		CCima();
	}
	else if (rotate == "CDown_")
	{
		CBaixo();
	}
	else if (rotate == "aClockwise_")
	{
		aHorario();
	}
	else if (rotate == "bClockwise_")
	{
		bHorario();
	}
	else if (rotate == "cClockwise_")
	{
		cHorario();
	}
	else if (rotate == "aCounterclockwise_")
	{
		aAntiHorario();
	}
	else if (rotate == "bCounterclockwise_")
	{
		bAntiHorario();
	}
	else if (rotate == "cCounterclockwise_")
	{
		cAntiHorario();
	}

	write_cube(CUBE_ORIGIN_ROW, cubo_mid_col, "Default");
	draw_matrix();
	usleep(50000);
}

void shuffle_cube()
{

	for (int i = 0; i < 25; i++)
	{
		int element = rand() % 18 + 1;

		switch (element)
		{

		case 1:
			rotate_cube("0Left_");
			break;
		case 2:
			rotate_cube("0Right_");
			break;

		case 3:
			rotate_cube("1Left_");
			break;

		case 4:
			rotate_cube("1Right_");
			break;

		case 5:
			rotate_cube("2Left_");
			break;

		case 6:
			rotate_cube("2Right_");
			break;

		case 7:
			rotate_cube("AUp_");
			break;

		case 8:
			rotate_cube("BUp_");
			break;

		case 9:
			rotate_cube("CUp_");
			break;

		case 10:
			rotate_cube("ADown_");
			break;

		case 11:
			rotate_cube("BDown_");
			break;

		case 12:
			rotate_cube("CDown_");
			break;

		case 13:
			rotate_cube("aClockwise_");
			break;

		case 14:
			rotate_cube("bClockwise_");
			break;

		case 15:
			rotate_cube("cClockwise_");
			break;

		case 16:
			rotate_cube("aCounterclockwise_");
			break;

		case 17:
			rotate_cube("bCounterclockwise_");
			break;

		default:
			rotate_cube("cCounterclockwise_");
			break;
		}
	}
}

/**
 * Inicia o jogo
 */
void game_loop()
{
	char command = wait_key(new char[35]{'7', '9', '4', '6', '1', '3',
										 'Q', 'W', 'E', 'A', 'S', 'D',
										 'q', 'w', 'e', 'a', 's', 'd',
										 'R', 'T', 'Y', 'r', 't', 'y',
										 'F', 'G', 'H', 'f', 'g', 'h',
										 'M', 'm', 'x', 'X', esc},
							35);

	if (command == '7')
	{
		rotate_cube("0Left_");
	}
	else if (command == '9')
	{
		rotate_cube("0Right_");
	}
	else if (command == '4')
	{
		rotate_cube("1Left_");
	}
	else if (command == '6')
	{
		rotate_cube("1Right_");
	}
	else if (command == '1')
	{
		rotate_cube("2Left_");
	}
	else if (command == '3')
	{
		rotate_cube("2Right_");
	}
	else if (command == 'Q' || command == 'q')
	{
		rotate_cube("AUp_");
	}
	else if (command == 'W' || command == 'w')
	{
		rotate_cube("BUp_");
	}
	else if (command == 'E' || command == 'e')
	{
		rotate_cube("CUp_");
	}
	else if (command == 'A' || command == 'a')
	{
		rotate_cube("ADown_");
	}
	else if (command == 'S' || command == 's')
	{
		rotate_cube("BDown_");
	}
	else if (command == 'D' || command == 'd')
	{
		rotate_cube("CDown_");
	}
	else if (command == 'R' || command == 'r')
	{
		rotate_cube("aClockwise_");
	}
	else if (command == 'T' || command == 't')
	{
		rotate_cube("bClockwise_");
	}
	else if (command == 'Y' || command == 'y')
	{
		rotate_cube("cClockwise_");
	}
	else if (command == 'F' || command == 'f')
	{
		rotate_cube("aCounterclockwise_");
	}
	else if (command == 'G' || command == 'g')
	{
		rotate_cube("bCounterclockwise_");
	}
	else if (command == 'H' || command == 'h')
	{
		rotate_cube("cCounterclockwise_");
	}
	else if (command == 'M' || command == 'm')
	{
		draw_menu();
		menu_options();
	}

	else if (command == 'X' || command == 'x')
	{
		shuffle_cube();
	}

	else if (command == esc)
	{
		exit(0);
	}

	game_loop();
}

void start_game()
{
	string bem_vindo = "Bem vindo ao Rubik Cube Simulator!";
	write_text(2, cols / 2 - bem_vindo.length() / 2, bem_vindo);
	write_cube(2, cubo_mid_col, "Default");
	draw_matrix();
	shuffle_cube();
	game_loop();
	usleep(3000000);
}

/**
 * Gerencia a lógica das opções do menu
 */
void menu_options()
{
	char input = wait_key(new char[7]{'i', 'I', 'j', 'J', 'm', 'M', esc}, 7);

	if (input == 'i' || input == 'I')
	{
		write_instructions(5, cols / 2.7, false);
		draw_matrix();
	}
	else if (input == 'm' || input == 'M')
	{
		draw_menu();
	}
	else if (input == 'j' || input == 'J')
	{
		start_game();
	}
	else
	{
		exit(0);
	}

	menu_options();
}

int main()
{
	setup();

	draw_menu();

	menu_options();
}

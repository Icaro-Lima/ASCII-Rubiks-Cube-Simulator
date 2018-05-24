#include "api.h"

using namespace std;

/**
 * Rotaciona a linha ou coluna desejada conforme passado por parâmetro.
 * (rotate)
    **/
void rotate_cube(int row, int col, string rotate) {
	
	for (int i = 0; i < 5; i++) {
		write_sprite(row, col, rotate + to_string(i));
		draw_matrix();
		usleep(200000);
	}
	write_sprite(row, col, "Default");
	draw_matrix();
	usleep(200000);
}

/**
 * Inicia o jogo
 */	
void start_game(int row, int col) {
	char command = wait_key(new char[30] { '7', '9', '4', '6', '1', '3',
											'Q', 'W', 'E', 'A', 'S', 'D',
											'q', 'w', 'e', 'a', 's', 'd',
											'R', 'T', 'Y', 'r', 't', 'y',
											'F', 'G', 'H', 'f', 'g', 'h'}, 30);
	
	if (command == '7') {
		rotate_cube(row, col, "0Left_");
	} else if (command == '9'){
		rotate_cube(row, col, "0Right_");
	} else if (command == '4'){
		rotate_cube(row, col, "1Left_");
	} else if (command == '6'){
		rotate_cube(row, col, "1Right_");
	} else if (command == '1'){
		rotate_cube(row, col, "2Left_");
	} else if (command == '3'){
		rotate_cube(row, col, "2Right_");
	} else if (command == 'Q' || command == 'q'){
		rotate_cube(row, col, "AUp_");
	} else if (command == 'W' || command == 'w'){
		rotate_cube(row, col, "BUp_");
	} else if (command == 'E' || command == 'e'){
		rotate_cube(row, col, "CUp_");
	} else if (command == 'A' || command == 'a'){
		rotate_cube(row, col, "ADown_");
	} else if (command == 'S' || command == 's'){
		rotate_cube(row, col, "BDown_");
	} else if (command == 'D' || command == 'd'){
		rotate_cube(row, col, "CDown_");
	} else if (command == 'R' || command == 'r') {
		rotate_cube(row, col, "aClockwise_");
	} else if (command == 'T' || command == 't') {
		rotate_cube(row, col, "bClockwise_");
	} else if (command == 'Y' || command == 'y') {
		rotate_cube(row, col, "cClockwise_");
	} else if (command == 'F' || command == 'f') {
		rotate_cube(row, col, "aCounterclockwise_");
	} else if (command == 'G' || command == 'g') {
		rotate_cube(row, col, "bCounterclockwise_");
	} else if (command == 'H' || command == 'h') {
		rotate_cube(row, col, "cCounterclockwise_");
	}
	else {
		cin.ignore();
	}
	
	start_game(row, col);
	
	
}

// Exibe menu de opções
void menu_options() {
	char input = wait_key(new char[6] { 'i', 'I', 'j', 'J', 'm', 'M' }, 6);
	
	if (input == 'i' || input == 'I') {
		draw_instructions(5, cols/2.7);
	} else if (input == 'm' || input == 'M') {
		draw_menu();
	} else {
	int mid_screen = rows/2;
	write_text(2, mid_screen + 20, "Bem vindo ao Rubik Cube Simulator!");
    draw_default_cube(2, mid_screen + 15);
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

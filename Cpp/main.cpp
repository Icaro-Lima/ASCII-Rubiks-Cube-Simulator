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
void rotate_cube(string rotate) {
	for (int i = 0; i < 5; i++) {
		write_cube(CUBE_ORIGIN_ROW, cubo_mid_col, rotate + to_string(i));
		draw_matrix();
		usleep(50000);
	}
	
	if (rotate == "0Left_") {
		zeroEsq();
	}
	
	write_cube(CUBE_ORIGIN_ROW, cubo_mid_col, "Default");
	draw_matrix();
	usleep(50000);
}

/**
 * Inicia o jogo
 */	
void game_loop() {
	char command = wait_key(new char[33] { '7', '9', '4', '6', '1', '3',
											'Q', 'W', 'E', 'A', 'S', 'D',
											'q', 'w', 'e', 'a', 's', 'd',
											'R', 'T', 'Y', 'r', 't', 'y',
											'F', 'G', 'H', 'f', 'g', 'h',
											'M', 'm', esc }, 33);
	
	
	if (command == '7') {
		rotate_cube("0Left_");
	} else if (command == '9'){
		rotate_cube("0Right_");
	} else if (command == '4'){
		rotate_cube("1Left_");
	} else if (command == '6'){
		rotate_cube("1Right_");
	} else if (command == '1'){
		rotate_cube("2Left_");
	} else if (command == '3'){
		rotate_cube("2Right_");
	} else if (command == 'Q' || command == 'q'){
		rotate_cube("AUp_");
	} else if (command == 'W' || command == 'w'){
		rotate_cube("BUp_");
	} else if (command == 'E' || command == 'e'){
		rotate_cube("CUp_");
	} else if (command == 'A' || command == 'a'){
		rotate_cube("ADown_");
	} else if (command == 'S' || command == 's'){
		rotate_cube("BDown_");
	} else if (command == 'D' || command == 'd'){
		rotate_cube("CDown_");
	} else if (command == 'R' || command == 'r') {
		rotate_cube("aClockwise_");
	} else if (command == 'T' || command == 't') {
		rotate_cube("bClockwise_");
	} else if (command == 'Y' || command == 'y') {
		rotate_cube("cClockwise_");
	} else if (command == 'F' || command == 'f') {
		rotate_cube("aCounterclockwise_");
	} else if (command == 'G' || command == 'g') {
		rotate_cube("bCounterclockwise_");
	} else if (command == 'H' || command == 'h') {
		rotate_cube("cCounterclockwise_");
	} else if (command == 'M' || command == 'm') {
		draw_menu();
		menu_options();
	} else if (command == esc) {
		exit(0);
	}
	
	game_loop();
}

/**
 * Gerencia a lógica das opções do menu
 */
void menu_options() {
	char input = wait_key(new char[7] { 'i', 'I', 'j', 'J', 'm', 'M', esc }, 7);
	
	if (input == 'i' || input == 'I') {
		write_instructions(5, cols/2.7, false);
		draw_matrix();
	} else if (input == 'm' || input == 'M') {
		draw_menu();
	} else if (input == 'j' || input == 'J') {
		string bem_vindo = "Bem vindo ao Rubik Cube Simulator!";
		write_text(2, cols / 2 - bem_vindo.length() / 2, bem_vindo);
		write_cube(2, cubo_mid_col, "Default");
		draw_matrix();
		game_loop();
		usleep(3000000);
	} else {
		exit(0);
	}
	
	menu_options();
}

int main() {
    setup();
    
    draw_menu();
    
	menu_options();
	
    
  
}

#include <bits/stdc++.h>
#include<chrono>

using namespace std;

void sleep(long millis) {
  this_thread::sleep_for(chrono::milliseconds(millis));
}

void draw_line(char x, int size) {
  for (int i = 0; i < size; i++) {
    cout << x;
  }
}

int main() {
  char * quadros = new char[9] { ' ', ' ', 'O', '@', 'X', 'x' };
  int anim = 0;
  while (true) {
    system("cls");
    draw_line(quadros[anim++ % 7], 20);
    sleep(100);
  }
}

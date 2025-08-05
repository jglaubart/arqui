// Ejercicio 4 ---> Teclado por poleo

#include <keyboard.h>
#include <naiveConsole.h>

extern uint8_t getPressedKey();
static const char sc_to_ascii[128] = {
    0,  27, '1','2','3','4','5','6','7','8','9','0','-','=','\b', '\t',
    'q','w','e','r','t','y','u','i','o','p','[',']','\n', 0,
    'a','s','d','f','g','h','j','k','l',';','\'','`', 0, '\\','z','x',
    'c','v','b','n','m',',','.','/', 0, '*', 0, ' ', 0,
    0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
    0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
    0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
    0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0
};
  
  uint8_t get_key(void){
      return getPressedKey();
  }
  
  void ncPrintPressedKey(void){
    ncPrintStyle("Press a Key", 0x0B);
    char key = sc_to_ascii[get_key()];
    ncNewline();
    ncPrint("Pressed key: ");
    ncPrintChar(key);
    ncNewline();
  }
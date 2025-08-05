#ifndef NAIVE_CONSOLE_H
#define NAIVE_CONSOLE_H

#include <stdint.h>

void ncPrint(const char * string);
void ncPrintChar(char character);
void ncNewline();
void ncPrintDec(uint64_t value);
void ncPrintHex(uint64_t value);
void ncPrintBin(uint64_t value);
void ncPrintBase(uint64_t value, uint32_t base);
void ncClear();

//Ej1
void ncPrintCharStyle(char character, uint8_t style);
void ncPrintStyle(const char * string, uint8_t style);

//Ej 3
void ncPrintDate();

#endif
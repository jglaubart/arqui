#include <naiveConsole.h>

static uint32_t uintToBase(uint64_t value, char * buffer, uint32_t base);

static char buffer[64] = { '0' };
static uint8_t * const video = (uint8_t*)0xB8000;
static uint8_t * currentVideo = (uint8_t*)0xB8000;
static const uint32_t width = 80;
static const uint32_t height = 25 ;

void ncPrint(const char * string)
{
	int i;

	for (i = 0; string[i] != 0; i++)
		ncPrintChar(string[i]);
}

void ncPrintChar(char character)
{
	*currentVideo = character;
	currentVideo += 2;
}

//Ejercicio 1 ---> Agrega formato a las letras de printChar. Se avanza 2 en currentVideo porque se guarda primero el caracter y luego el color
void ncPrintCharStyle(char character, uint8_t style){
	*currentVideo++ = character;
	*currentVideo++ = style;
}

void ncPrintStyle(const char * string, uint8_t style){
	int i;
	for (i = 0; string[i] != 0; i++)
		ncPrintCharStyle(string[i], style);
}
//Ejercicio 1


//Ej 3 --> getHorRTC
extern uint8_t getSecs();
extern uint8_t getMins();
extern uint8_t getHours();
extern uint8_t getDay();
extern uint8_t getMonth();
extern uint8_t getYear();

void ncPrintDate(){
	int hour = getHours();
	int minute = getMins();
	int second = getSecs();

	int day = getDay();
	int month = getMonth();
	int year = getYear();

	hour -= 3;

	// UTC to UTC-3 adjustment
	if (hour < 0) {
		hour += 24;
		day--;

		if (day == 0) {
			month--;
			if (month == 0) {
				month = 12;
				year--;
			}

			switch (month) {
				case 1: case 3: case 5: case 7: case 8: case 10: case 12:
					day = 31;
					break;
				case 4: case 6: case 9: case 11:
					day = 30;
					break;
				case 2:
					day = (year % 4 == 0 && (year % 100 != 0 || year % 400 == 0)) ? 29 : 28;
					break;
			}
		}
	}

	ncPrint("Date: ");
	ncPrintHex(day);
	ncPrint("/");
	ncPrintHex(month);
	ncPrint("/");
	ncPrintHex(year);
	ncNewline();

	ncPrint("Time: ");
	ncPrintHex(hour);
	ncPrint(":");
	ncPrintHex(minute);
	ncPrint(":");
	ncPrintHex(second);
	ncNewline();
}
//Ej 3

void ncNewline()
{
	do
	{
		ncPrintChar(' ');
	}
	while((uint64_t)(currentVideo - video) % (width * 2) != 0);
}

void ncPrintDec(uint64_t value)
{
	ncPrintBase(value, 10);
}

void ncPrintHex(uint64_t value)
{
	ncPrintBase(value, 16);
}

void ncPrintBin(uint64_t value)
{
	ncPrintBase(value, 2);
}

void ncPrintBase(uint64_t value, uint32_t base)
{
    uintToBase(value, buffer, base);
    ncPrint(buffer);
}

void ncClear()
{
	int i;

	for (i = 0; i < height * width; i++)
		video[i * 2] = ' ';
	currentVideo = video;
}

static uint32_t uintToBase(uint64_t value, char * buffer, uint32_t base)
{
	char *p = buffer;
	char *p1, *p2;
	uint32_t digits = 0;

	//Calculate characters for each digit
	do
	{
		uint32_t remainder = value % base;
		*p++ = (remainder < 10) ? remainder + '0' : remainder + 'A' - 10;
		digits++;
	}
	while (value /= base);

	// Terminate string in buffer.
	*p = 0;

	//Reverse string in buffer.
	p1 = buffer;
	p2 = p - 1;
	while (p1 < p2)
	{
		char tmp = *p1;
		*p1 = *p2;
		*p2 = tmp;
		p1++;
		p2--;
	}

	return digits;
}

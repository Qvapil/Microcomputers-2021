/*
 * ex2.c
 */ 

#include <avr/io.h>


int main(void)
{
	char input,A,B,C,D,F0,F1;
	DDRB=0xFF;		 // initialise PORTB as output
	DDRA=0x00;		// initialise PORTA as input
	while(1)
	{
		input = PINA & 0x0F;	//input bits 0-3 from PORTA
		A = input & 0x01;			// A is bit 0
		B = (input & 0x02) >> 1;	// B is bit 1, shift once
		C = (input & 0x04) >> 2;	// C is bit 2, shift twice
		D = (input & 0x08) >> 3;	// D is bit 3, shift thrice
		
		F0 = ~((A & B & ~C)|(C & D));	// calculate F0
		F0 = F0 & 0x01;		// isolate bit 0
		F1 = ((A | B) & (C | D));	// calculate F1
		F1 = (F1 << 1) & 0x02;	// shift F1 once to the left and isolate bit 1
		
		PORTB = F1 | F0; // output at PORTB
	}
	return 0;
}

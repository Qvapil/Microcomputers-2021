/*
*ex3.c
*/

#include<avr/io.h>

char x,input;

int main(void){
	
	DDRA = 0xFF;                     // Initialise PORTA as output
	DDRC = 0x00;      		  // Initialise PORTC as input
	x = 1;         		         // Initialise x for
	
	while(1){
		input=PINC;
		if(input == 1)               // SW0 is pressed
		if(x == 128) x = 1;    // If 10000000 then 00000001 else
		else x = x << 1;       // Shift left once
		else if(input == 2)          // SW1 is pressed
		if(x == 1) x = 128;    // If 00000001 then 10000000 else
		else x = x >> 1;       // Shift right once
		else if(input == 4)          // SW2 is pressed
		x=128;                 // Led7 (MSB)
		else if(input == 8)          // SW3 is pressed
		x = 1;                 // Led0 (LSB)
		while(PINC != 0);            // Wait until push-button is unpressed
		PORTA = x;                   // Apply the change of the output
	}
	return 0;
}



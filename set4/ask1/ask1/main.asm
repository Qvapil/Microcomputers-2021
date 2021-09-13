.include "m16def.inc"
reset:
ldi r24,low(RAMEND)  ; Initialize stack pointer
out SPL,r24
ldi r24,high(RAMEND) ;
out SPH,r24
ser r24		; Initialize PORTA for output
out DDRA,r24
clr r24
out DDRB,r24		; Initialize PORTB for input

main:		
ldi r26,01		; Start from LED0
rcall move_left
nop
rcall move_right
rjmp main

move_left: 
in r24,PINB 		; Input PB0
andi r24,01		; Keep LSB
cpi r24,01		; If PB0 = 1 don’t move
breq move_left
out PORTA,r26
cpi r26,80		; Check if reached MSB
brcc end_left		; If MSB return
lsl r26		; Else shift left and continue
rjmp move_left	

end_left: ret

move_right: 
in r24,PINB		; Input PB0
andi r24,01		; Keep LSB
cpi r24,01		; If PB0 = 1 don’t move
breq move_right
out PORTA,r26
cpi r26,01		; Check if reached LSB
breq end_right	; If LSB return
lsr r26		; Else shift right and continue
rjmp move_right

end_right: ret

INCLUDE macros.asm

DATA_SEG SEGMENT
    TABLE DB 128 DUP(?) 
    TWO DB DUP(2)
DATA_SEG ENDS

CODE_SEG SEGMENT
    ASSUME CS:CODE_SEG, DS:DATA_SEG

MAIN PROC FAR
    MOV AX, DATA_SEG
    MOV DS, AX
    
    MOV DI, 0
    MOV CX, 128   
  FILL_TABLE:
    MOV TABLE[DI], CL
    INC DI
    LOOP FILL_TABLE
    
    MOV DH, 0
    MOV AX, 0
    MOV BX, 0
    MOV DI, 0
    MOV CX, 128
  
  ADD_ODDS:
    PUSH AX
    MOV AH, 0
    MOV AL, TABLE[DI]   
    DIV TWO
    CMP AH, 0
    POP AX
    JE IS_EVEN  
    MOV DL, TABLE[DI]
    ADD AX, DX
    INC BX
  
  IS_EVEN: 
    INC DI
    LOOP ADD_ODDS
  
  AVERAGE:  
    MOV DX,0
    DIV BX  
    CALL 16BIN_DEC
    
    NEWLINE
    
    MOV AL, TABLE[0]
    MOV BL, TABLE[127]
    MOV DI, 0
    MOV CX, 128
  
  CHECKMAX:
    CMP AL, TABLE[DI]
    JC NEWMAX
    JMP CHECKMIN
  
  NEWMAX:
    MOV AL, TABLE[DI]
  
  CHECKMIN:
    CMP TABLE[DI], BL
    JC NEWMIN
    JMP NEXT
  
  NEWMIN: 
    MOV BL, TABLE[DI]
  
  NEXT:
    INC DI
    LOOP CHECKMAX
  
    CALL PRINT_NUM8_HEX
    PRINT  ' '
    MOV AL, BL
    CALL PRINT_NUM8_HEX
    
    EXIT
 
MAIN ENDP    

16BIN_DEC PROC NEAR   
    MOV CX, 0
  ADDR1:
    MOV DX, 0
    MOV BX, 10
    DIV BX
    PUSH DX
    INC CX
    CMP AX,0
    JNE ADDR1
  ADDR2:
    POP DX
    PRINT_NUM DL
    LOOP ADDR2
    RET
16BIN_DEC ENDP

PRINT_NUM8_HEX PROC NEAR
    MOV DL,AL
    AND DL,0F0H 
    MOV CL,4
    ROR DL,CL
    CMP DL,0
    JE SKIP0
    CALL PRINT_HEX
  SKIP0:
    MOV DL,AL
    AND DL,0FH 
    CALL PRINT_HEX
    RET
PRINT_NUM8_HEX ENDP

PRINT_HEX PROC NEAR 
    CMP DL,9 
    JG CHARACTER
    ADD DL,30H ;48
    JMP SHOW
  CHARACTER:
    ADD DL,37H ;55 
  SHOW:
    PRINT DL
    RET
PRINT_HEX ENDP 

CODE_SEG ENDS  
;END MAIN     


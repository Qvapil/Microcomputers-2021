INCLUDE macros.asm
DATA_SEG SEGMENT
    MSG1 DB "START(Y,N):$"
    MSG2 DB "ERROR$" 
ENDS

CODE_SEG SEGMENT
    ASSUME CS:CODE_SEG, DS:DATA
    
    MAIN PROC FAR
        MOV AX, DATA_SEG
        MOV DS, AX
        PRINT_STR MSG1 
      START:
        READ
        CMP AL, 'N' 
        JE  QUIT
        CMP AL, 'Y'
        JE ANS
        JMP START
      ANS:
        PRINT AL
        NEWLINE
      NEXT:
        ;MOV DX, 0
        ;MOV CX, 3
      INPUT:
        CALL HEX_KEYB
        CMP AL, 'N'
        JE QUIT
        MOV DL, AL
        ROL DL, 4
        CALL HEX_KEYB
        CMP AL, 'N'
        JE QUIT
        OR DL, AL
        ROL DX, 4
        CALL HEX_KEYB
        CMP DL, 'N'
        JE QUIT
        OR DL, AL
        
        TABS
        MOV AX,DX
        CMP AX, 2047
        JBE FIRST_CASE
        CMP AX, 3071
        JBE SECOND_CASE
        PRINT_STR MSG2
        NEWLINE
        JMP NEXT 
        
      FIRST_CASE:
        MOV BX, 800
        MUL BX
        MOV BX, 4095
        DIV BX
        JMP SHOW
      
      SECOND_CASE:
        MOV BX, 3200
        MUL BX
        MOV BX, 4095
        DIV BX  
        SUB AX, 1200
      SHOW:
        CALL PRINT_DEC
        
        MOV AX, DX
        MOV BX, 10
        MUL BX
        MOV BX, 4095
        DIV BX
        PRINT ','
        ADD AL, 48
        PRINT AL
        NEWLINE
        JMP NEXT
        
      QUIT: 
        PRINT AL
        EXIT
    MAIN ENDP
    
    HEX_KEYB PROC NEAR
       IGNORE:
         READ
         CMP AL, 'N'
         JE RETURN
         CMP AL, 48   ;48, ('O'=30H)
         JL IGNORE     ;<0
         CMP AL, 57   ;57, ('9'=39H) 
         JG ISLETTER   ;>9          
         PRINT AL  
         SUB AL, 48   ;ASCII code
         JMP RETURN
       ISLETTER:
         CMP AL, 'A'
         JL IGNORE
         CMP AL,'F'
         JG IGNORE
         PRINT AL 
         SUB AL, 55  ;(55)ASCII to number
       RETURN:
         RET
    HEX_KEYB ENDP 
    
    PRINT_DEC PROC NEAR      
        PUSH DX
        MOV CX, 0  
      GET_DEC:      
        MOV DX, 0
        MOV BX, 10 
        DIV BX
        PUSH DX
        INC CX
        CMP AX,0
        JNE GET_DEC
      SHOW_DEC:  
        POP DX
        ADD DL,30H
        PRINT DL
        LOOP SHOW_DEC
        POP DX 
        RET        
    PRINT_DEC ENDP 

CODE_SEG ENDS
END MAIN
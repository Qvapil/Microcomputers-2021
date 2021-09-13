INCLUDE macros.asm


CODE_SEG SEGMENT
    ASSUME CS:CODE_SEG
    
    MAIN PROC FAR 
    ;  START:
;        MOV DX,0
;        MOV CX,3
;      INPUT:
;        CALL HEX_KEYB
;        CMP AL, 'T'
;        JE QUIT
;        SHL BX, 1
;        SHL BX, 1
;        SHL BX, 1
;        SHL BX, 1
;        ADD BL, AL
;        LOOP INPUT
                     
        START:
           CALL HEX_KEYB
           CMP AL, 'T'
           JE QUIT
           MOV BL, AL
           ROL BL, 4
           CALL HEX_KEYB
           CMP AL, 'T'
           JE QUIT
           OR BL, AL
           ROL BX, 4
           CALL HEX_KEYB
           CMP AL, 'T'
           JE QUIT
           OR BL, AL
        
        
        PRINT '='
        CALL PRINT_DEC
        PRINT '='
        CALL PRINT_OCT
        PRINT '='
        CALL PRINT_BIN
        NEWLINE
        
        JMP START
      
      QUIT: 
        EXIT
    MAIN ENDP
    
    HEX_KEYB PROC NEAR
       IGNORE:
         READ
         CMP AL, 'T'
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
        MOV DX, BX     
        PUSH BX
        MOV CX, 0  
        MOV AX, DX
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
        ADD DX,30H
        PRINT DL
        LOOP SHOW_DEC
        POP BX 
        RET        
    PRINT_DEC ENDP
    
    PRINT_OCT PROC NEAR    
        PUSH BX
        MOV DX,BX 
        MOV CX,0
        MOV AX,DX
      GET_OCT:
        MOV DX,0 
        MOV BX, 8
        DIV BX
        PUSH DX
        INC CX
        CMP AX,0
        JNE GET_OCT
      SHOW_OCT:
        POP DX
        ADD DX,30H
        PRINT DL
        LOOP SHOW_OCT   
        POP BX
        RET
    PRINT_OCT ENDP

    PRINT_BIN PROC NEAR 
        MOV DX,BX 
        MOV CX,0
        MOV AX,DX
      GET_BIN:
        MOV DX,0 
        MOV BX, 2
        DIV BX
        PUSH DX
        INC CX
        CMP AX,0
        JNE GET_BIN
      SHOW_BIN:
        POP DX
        ADD DX,30H
        PRINT DL
        LOOP SHOW_BIN
        RET
    PRINT_BIN ENDP  
        
CODE_SEG ENDS
    END MAIN
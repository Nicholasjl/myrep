CRLF    MACRO
        MOV AH,02H
        MOV DL,0DH
        INT 21H
        MOV AH,02H
        MOV DL,0AH
        INT 21H
        ENDM
DATA    SEGMENT
MARK    DB  ?
MESS    DB  'input:$'
ERROR   DB  0DH,0AH,'input error!',0DH,0AH,'$'
DATA    ENDS
STACK1  SEGMENT
STA     DW  32 DUP(?)
STACK1  ENDS
CODE    SEGMENT 
        ASSUME CS:CODE,DS:DATA,SS:STACK1
START:  MOV     AX,DATA        
        MOV     DS,AX
HEAD:   CRLF
        MOV     MARK,0
        MOV     AH,09H
        LEA     DX,MESS
        INT     21H
        CALL    GETNUM
        CMP     MARK,01H
        JE      HEAD
        MOV     CX,0010H
        MOV     BX,DX
SHOW:   ROL     BX,1
        MOV     DL,BL
        AND     DL,01H
        ADD     DL,30H
        MOV     AH,02H
        INT     21H
        LOOP    SHOW
        JMP     HEAD
FINI:   MOV     AX,4C00H
        INT     21H
GETNUM  PROC    NEAR
        XOR     DX,DX
GO:     MOV     AH,01H
        INT     21H
        CMP     AL,0DH
        JE      HCHH
        CMP     AL,20H
        JE      FINI
        CMP     AL,30H
        JB      WRONG
        SUB     AL,30H
        CMP     AL,0AH
        JB      BINGO
        CMP     AL,11H
        JB      WRONG
        SUB     AL,07H
        CMP     AL,0FH
        JBE     BINGO
        CMP     AL,2AH
        JB      WRONG
        CMP     AL,2FH
        JA      WRONG
        SUB     AL,20H
BINGO:  MOV     CL,04
        SHL     DX,CL
        XOR     AH,AH
        ADD     DX,AX
        JMP     GO
WRONG:  MOV     AH,09H
        MOV     DX,OFFSET ERROR
        INT     21H
        MOV     MARK,01H
HCHH:   PUSH    DX
        CRLF
        POP     DX
        RET
GETNUM  ENDP
CODE    ENDS
        END     START

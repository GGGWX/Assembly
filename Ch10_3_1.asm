DATA SEGMENT

DATA ENDS

CODE    SEGMENT
        ASSUME  CS:CODE,DS:DATA
        

;lower bound: 0V / 0.019V = 0
;upper bound: 5V / 0.019V = 262 > 2^8 -1 = 0FFH so upper bound = 00H
;
;
;
BEGIN:  MOV AL,0     ;lower bound
UP:     OUT 220H,AL
        INC AL
        CMP AL,00H
        JNZ UP
        DEC AL

DOWN:   OUT 220H,AL
        DEC AL
        CMP AL,00H
        JNZ DOWN
        JMP BEGIN



CODE    ENDS
END     BEGIN

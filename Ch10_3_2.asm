DATA SEGMENT

DATA ENDS

CODE    SEGMENT
        ASSUME  CS:CODE,DS:DATA
        
;lower bound: 1.2V / 0.019V = 61 = 3DH
;upper bound: 4V / 0.019V = 205 = 0CDH 
BEGIN:  MOV AL,3DH     ;lower bound
UP:     OUT 220H,AL
        INC AL
        CMP AL,0CDH
        JNZ UP
        CALL DELAY
        DEC AL

DOWN:   OUT 220H,AL
        DEC AL
        CMP AL,3DH
        JNZ DOWN
        CALL DELAY
        JMP BEGIN
        
DELAY:  ;delay for 20ms
        RET

CODE    ENDS
END     BEGIN

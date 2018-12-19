DATA    SEGMENT
ANS     DB 9 DUP(?)
COUNT   DB 0
MAX     EQU 8
DATA    ENDS

CODE    SEGMENT
        ASSUME CS:CODE,DS:DATA,ES:DATA

MAIN    PROC FAR
        PUSH DS
        SUB AX,AX
        PUSH AX
        MOV AX,DATA
        MOV DS,AX

        MOV BL,1        ;int i = 1
        CALL QUEEN
        
        MOV AH,0        
        MOV AL,COUNT
        MOV DL,10
        DIV DL
        MOV CX,AX
        OR CH,30H       ;reference: https://blog.csdn.net/xiaoyuge16/article/details/51362325
        OR CL,30H
        MOV DL,CL       ;print the first number
        MOV AH,2
        INT 21H
        MOV DL,CH       ;print the second number
        MOV AH,2
        INT 21H
        RET
MAIN    ENDP

QUEEN   PROC NEAR
        CMP BL,MAX       
        JA  PRINTA      ;print answer
        MOV BH,0        ;int j = 0
LOOPA:  INC BH
        CMP BH,MAX
        JA  EXIT        ;if j>8 then exit loop
        MOV CL,0        ;int k = 0
LOOPB:  INC CL
        CMP CL,BL       ;compare k and i   
        JE  NEXT        ;if i == k then go to recursion
        MOV DH,0
        MOV DL,CL
        MOV SI,DX
        MOV CH,ANS[SI]  ;CH=ans[k]
        CMP CH,BH  
        JE  NEXT        ;if ans[k] == j
        MOV DL,BL
        SUB DL,CL       ;DL=i-k
        MOV DH,CH
        SUB DH,BH       ;DH=ans[k] - j
        CMP DH,0
        JGE COMP
        NEG DH          ;|DH|
COMP:   CMP DL,DH
        JE NEXT
        JMP LOOPB
NEXT:   CMP CL,BL       ;compare i and k
        JNE LOOPA
        MOV DH,0
        MOV DL,BL
        MOV SI,DX
        MOV ANS[SI],BH  ;ans[i] = j
        PUSH BX
        INC BL
        CALL QUEEN
        POP BX
        JMP LOOPA
PRINTA: CALL MYPRINT
EXIT:   RET
QUEEN   ENDP

MYPRINT PROC NEAR
        MOV CX,0        ;i=0
LOOPP:  INC CX
        CMP CX,MAX
        JA EXITP        ;if i > 8 then print \n
        MOV SI,CX
        MOV DL,ANS[SI]  ;print number
        OR DL,30H
        MOV AH,2
        INT 21H
        MOV DL,20H      ;print white space
        MOV AH,2
        INT 21H
        JMP LOOPP
EXITP:  INC COUNT
        MOV DL,0AH      ;print \n
        MOV AH,2
        INT 21H
        RET
MYPRINT ENDP

CODE    ENDS
        END MAIN
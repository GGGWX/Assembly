DATA    SEGMENT

DATA    ENDS

CODE    SEGMENT
        ASSUME CS:CODE,DS:DATA,ES:DATA

MAIN    PROC FAR        ;sub process and invoke process are in different segment
BEGIN:  PUSH DS
        SUB AX,AX
        PUSH AX         ;use these so that we can use RET to return to DOS
        MOV AX,DATA
        MOV DS,AX

        MOV BH,2        ;int i = 2

LOOPA:  CMP BH,100      
        JA EXIT         ;if i > 100 then stop
        MOV BL,2        ;int j = 2

LOOPB:  CMP BL,BH       
        JA NEXT         ;if j>i then jump to LOOPA
        JE PRINT        ;if j==i then j is a prime number
        MOV AX,0        
        MOV AL,BH       ;AL saves quotient and AH saves remainder(8-bit)
        DIV BL          ;i/j
        CMP AH,0        ;if i%j==0 then j is not a prime number
        JE NEXT         ;jump to LOOPA
        INC BL          ;j++
        JMP LOOPB       

PRINT:  MOV AH,0        
        MOV AL,BH
        MOV DH,10
        DIV DH
        MOV CX,AX
        OR CH,30H       ;reference: https://blog.csdn.net/xiaoyuge16/article/details/51362325
        OR CL,30H
        MOV DL,CL       ;print the first number
        MOV AH,2
        INT 21H
        MOV DL,CH       ;print the second number
        MOV AH,2
        INT 21H
        MOV DL,20H      ;print white space
        MOV AH,2
        INT 21H

NEXT:   INC BH          ;i++   
        JMP LOOPA

EXIT:   RET

MAIN    ENDP

CODE    ENDS
        END MAIN
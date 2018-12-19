DATA    SEGMENT
FIBH    DW 0                ;reference: https://www.cnblogs.com/wanghj-dz/p/3973543.html
FIBL    DW 0                ;H for higher 8 bits, L for lower part
TIMES   EQU 30              ;first times-count numbers of fibonacci sequence
DATA    ENDS

CODE    SEGMENT
        ASSUME CS:CODE,DS:DATA,ES:DATA

MAIN    PROC FAR        
        PUSH DS
        SUB AX,AX
        PUSH AX
        MOV AX,DATA
        MOV DS,AX

        MOV CL,0           ;i = 0        
LOOPA:  INC CL              
        CMP CL,TIMES
        JA EXIT
        MOV FIBH,0
        MOV FIBL,0
        CALL FIB
        CALL PRINT
        JMP LOOPA
EXIT:   RET
MAIN    ENDP

FIB     PROC NEAR
BEGIN:  CMP CL,2            
        JA RECU             ;go to recursion
        MOV FIBL,1
        MOV FIBH,0          ;starts from 01,01
        JMP EXITF
RECU:   DEC CL              
        CALL FIB            ;fib(i-1)
        DEC CL
        PUSH FIBL           
        PUSH FIBH
        CALL FIB            ;fib(i-2)
        POP BX              ;BX = FIBH
        POP DX              ;DX = FIBL
        ADD FIBL,DX         
        ADC FIBH,BX         
        INC CL
        INC CL
EXITF:  RET
FIB     ENDP

PRINT   PROC NEAR
        MOV DX,FIBH         ;2^16 - 1 < fib(25) = 75025
        MOV AX,FIBL
        MOV BX,10000        
        DIV BX              ;AX saves quotient and DX saves remainder(16-bit)
        PUSH DX             ;store the remainder
        MOV DL,10           ;print the first two numbers
        DIV DL              
        MOV BX,AX           
        OR BX,3030H
        MOV DL,BL
        MOV AH,2
        INT 21H
        MOV DL,BH
        MOV AH,2
        INT 21H

        POP AX              ;get the remainder
        MOV DX,100          
        DIV DL              ;AL saves quotient and AH saves remainder(8-bit)
        PUSH AX             ;store the remainder
        MOV AH,0
        MOV DL,10           ;print the next two numbers
        DIV DL              
        MOV BX,AX           
        OR BX,3030H         ;convert to hexadecimal
        MOV DL,BL
        MOV AH,2
        INT 21H
        MOV DL,BH
        MOV AH,2
        INT 21H

        POP AX              ;get the remainder
        XCHG AL,AH          ;exchange the value between AL and AH
        MOV AH,0
        MOV DL,10           ;print the last two numbers
        DIV DL              
        MOV BX,AX           
        OR BX,3030H
        MOV DL,BL
        MOV AH,2
        INT 21H
        MOV DL,BH
        MOV AH,2
        INT 21H
        MOV DL,20H  
        MOV AH,2        
        INT 21H
        RET
PRINT   ENDP

CODE    ENDS
        END MAIN
TITLE   CSA_ASSIGNMENT     ORDER_MENU

.MODEL SMALL
.STACK 64
.DATA

    ;MENU TITLE 
    MENU_TITLE_MSG  DB  "FOOD AND BEVERAGE MENU", 13, 10, '$'
    
    ;ORDER SERVICES
    ORD1            DB  "1. SNACK & COLA(CAN)                                 RM 5.00", 13, 10, '$'
    ORD2            DB  "2. MAGGIE CURRY BIG CUP & COLA(CAN) & SNACK          RM12.50", 13, 10, '$'
    ORD3            DB  "3. 2 MAGGIE CURRY BIG CUP & 2 COLA(CAN)              RM18.00", 13, 10, '$'
    ORD4            DB  "4. MAGGIE CURRY BIG CUP & 2 COLA(CAN) & 2 SNACK      RM18.00", 13, 10, '$'
    ORDER_SELECTION_MSG   DB  "PLEASE ENTER YOUR SELECTION >> ", '$'
    ERROR_MSG       DB  "INVALID INPUT, PLEASE TRY AGAIN!", 13, 10, '$'
    
    ASKQUANTITY_MSG DB  "ENTER QUANTITY >> ",'$'
    ADDORDER_MSG    DB  "ANOTHER ORDER? (1-YES/0-NO) >> ",'$'
    CONFIRM_ORDER_MSG   DB  "CONFORM ORDER",'$'
    
    EDIT_ORDER_MSG  DB  "DO YOU WANT TO MODIFY YOUR ORDER? >>",'$'



    ;New line
    CR EQU 0DH      ;represent carriage return with CR
    LF EQU 0AH      ;represent line feed with LF


;-------------------------------------------------
.CODE
    MAIN PROC FAR

    MOV AX , @DATA
    MOV DS , AX

    MOV AH , 00
    MOV AL , 02
    INT 10H

    CALL FAR PTR ORDER_MENU

    MOV	AX , 4C00H	    ;PLEASE PREPARE, I WANT TO PERFORM THE PROPER EXIT (4C00H)
    INT	21H		        ;CARRY OUT THE OPERATION
    
    MAIN ENDP

    ORDER_MENU PROC FAR

        MOV AH,09H
        LEA DX,MENU_TITLE_MSG
        INT 21H

        CALL FAR PTR NEWLINE

        MOV AH,09H
        LEA DX,ORD1
        INT 21H

        MOV AH,09H
        LEA DX,ORD2
        INT 21H

        MOV AH,09H
        LEA DX,ORD3
        INT 21H

        MOV AH,09H
        LEA DX,ORD4
        INT 21H

        CALL FAR PTR NEWLINE

        MOV AH,09H
        LEA DX,ORDER_SELECTION_MSG
        INT 21H

        RET

    ORDER_MENU ENDP

    PRINT_ERROR_MSG PROC FAR

    PRINT_ERROR_MSG ENDP

    EDIT_ORDER PROC FAR

    EDIT_ORDER ENDP

    NEWLINE PROC FAR
        MOV AH,02H
        MOV DL,CR
        INT 21H
        MOV DL,LF
        INT 21H

        RET

    NEWLINE ENDP

END MAIN

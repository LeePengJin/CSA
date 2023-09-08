TITLE       CSA_ASSIGNMENT      LOGIN MODULE    ;title
.MODEL      SMALL               ;memory of model used
.STACK      64                  ;declare stack segment
.DATA                           ;declare data segment
    ;String
    ;main menu section
    WELCOMEMESSAGE  DB  "                            WELCOME TO CYPHER CAFE", 13, 10, '$'
    MAINMENU_O1 DB  "                            1. LOG IN", 13, 10, '$'
    MAINMENU_O2 DB  "                            2. EXIT", 13, 10, '$'
    MAINMENUMESSAGE DB  "PLEASE ENTER YOUR CHOICE -->", '$'
    MAINMENU_ERROR_MESSAGE  DB  "INVALID INPUT, PLEASE TRY AGAIN!", 13, 10, '$'
    USERNAME_DISPLAY        DB  "PLEASE ENTER USERNAME -->", '$'
    PASSWORD_DISPLAY        DB  "PLEASE ENTER PASSWORD -->", '$'
    USERNAME    DB  "admin123", '$'
    PASSWORD    DB  "pass1234", '$'
    WRONG_UP_MESSAGE    DB  "Wrong Username or Password entered, Please enter again.", 13, 10, '$'
    CORRECT_MESSAGE  DB  "CORRECT USERNAME", 13, 10, '$'

    ;staff menu section
    STAFF_MENU_MESSAGE    DB  "                              *CYHPER CAFE*", 13, 10, '$'
    STAFF_MENU_OPTION1    DB  "                            1. RENT COMPUTERS", 13, 10, '$'
    STAFF_MENU_OPTION2    DB  "                            2. ORDER SERVICES", 13, 10, '$'
    STAFF_MENU_OPTION3    DB  "                            3. CREATE REPORTS", 13, 10, '$'
    STAFF_MENU_OPTION4    DB  "                            4. LOG OUT", 13, 10, '$'
    STAFF_MENU_PROMT_MSG  DB  "PLEASE ENTER YOUR CHOICE -->", '$'
    STAFF_MENU_ERROR_MSG  DB  "INVALID INPUT, PLEASE TRY AGAIN!", 13, 10, '$'

    ;rent computer section
    RENT_PC_MESSAGE     DB  "HERE IS RENT PC",'$'

    ;order service section
    ORDER_SERVICE_MESSAGE   DB  "HERE IS ORDER SERVICE",'$'

    ;reports section
    REPORTS_MESSAGE     DB  "HERE IS REPORT",'$'

    ;exit section
    THANKYOU_MSG        DB  "THANKS FOR COMING, HAVE A NICE DAY!!!",'$'

    ;Input
    MAINMENU_INPUT  LABEL   BYTE        ;declare array
    MAX_MAINMENU     DB  20                 ;size of array, you only allow user to type the value with 19+1 
    ACTUAL_MAINMENU  DB  ?                  ;refer the number of character, your computer will help you to calculate the number of character and store it inside the string input
    SPACE_MAINMENU   DB  20 DUP(' ')  
    
    USERNAME_INPUT  LABEL   BYTE
    MAX_USERNAME     DB  20
    ACTUAL_USERNAME  DB  ?                
    SPACE_USERNAME   DB  20 DUP(' ') 

    PASSWORD_INPUT  LABEL   BYTE
    MAX_PASSWORD     DB  20
    ACTUAL_PASSWORD  DB  ?
    SPACE_PASSWORD   DB  20 DUP(' ')

    STAFF_MENU_INPUT LABEL   BYTE
    MAX_STAFF_MENU     DB  20
    ACTUAL_STAFF_MENU  DB  ?
    SPACE_STAFF_MENU   DB  20 DUP(' ')

    ;New line
    CR EQU 0DH      ;represent carriage return with CR
    LF EQU 0AH      ;represent line feed with LF

;================================================================
.CODE                                           ;declare code segment

    MAIN PROC FAR                             ;start of prgram

    MOV AX,@DATA                                ;storing the address of the data segment to the ax register
    MOV DS,AX                                   ;moving the value of the ax register to ds register

    MOV AH,00
    MOV AL,02
    INT 10H                                     ;clear screen

    MAINMENU PROC FAR
        MOV AH,09H                              ;prepare to display
        LEA DX,WELCOMEMESSAGE                   ;load the address of the string
        INT 21H                                 ;proceed to display

        MOV AH,09H                              ;prepare to display
        LEA DX,MAINMENU_O1                      ;load the address of the string
        INT 21H                                 ;proceed to display

        MOV AH,09H                              ;prepare to display
        LEA DX,MAINMENU_O2                      ;load the address of the string
        INT 21H                                 ;proceed to display

        MOV AH,09H
        LEA DX,MAINMENUMESSAGE                  ;display main menu message
        INT 21H

        MOV AH,0AH
        LEA DX,MAINMENU_INPUT                   ;accept input with echo
        INT 21H                                 ;proceed to accept user input

        CALL FAR PTR NEW_LINE

        .386
        MOVZX   BX,ACTUAL_MAINMENU
        MOV SPACE_MAINMENU[BX],'$'                  ;add the '$' sign to indicate the end of the string

        CALL FAR PTR NEW_LINE

        CMP SPACE_MAINMENU[0],"1"                                ;if user input is 1, go to login module
        JE  LOGIN                  

        CMP SPACE_MAINMENU[0],"2"                                ;if user input is 2, exit the program
        JE  EXIT

        CALL FAR PTR MAINMENU_ERROR_INPUT

        MAINMENU_ERROR_INPUT PROC FAR
            CALL FAR PTR NEW_LINE

            MOV AH,09H
            LEA DX,MAINMENU_ERROR_MESSAGE           ;display error message
            INT 21H

            JMP MAINMENU

            RET

        MAINMENU_ERROR_INPUT ENDP

        LOGIN PROC FAR
            CALL FAR PTR NEW_LINE

            MOV AH,09H                 
            LEA DX,USERNAME_DISPLAY         
            INT 21H                                 ;prompt user to enter username

            MOV AH,0AH
            LEA DX,USERNAME_INPUT
            INT 21H                                 ;accept user input

            .386
            MOVZX   BX,ACTUAL_USERNAME 
            MOV SPACE_USERNAME[BX],'$'              ;store username inputed

            CALL FAR PTR NEW_LINE

            MOV AH,09H                 
            LEA DX,PASSWORD_DISPLAY         
            INT 21H                                 ;prompt user to enter password

            MOV AH,0AH
            LEA DX,PASSWORD_INPUT
            INT 21H                                 ;accept user password

            .386
            MOVZX   BX,ACTUAL_PASSWORD 
            MOV SPACE_PASSWORD[BX],'$'              ;store password inputed

            CALL FAR PTR NEW_LINE

            MOV DI,0

            CALL FAR PTR USERNAME_LOOP



        LOGIN ENDP

        USERNAME_LOOP PROC FAR
            ;load the character from the string
            MOV AL,SPACE_USERNAME[DI]               ;load first character from username inputed
            MOV BL,USERNAME[DI]                     ;load first character from valid username

            CMP AL,BL                               ;compare both character
            JNE INCORRECT_UP

            CMP AL,'$'
            JE  CHECK_USERNAME_END                  ;check whether the string has reach the end

            INC DI                                  ;increment for di

            JMP USERNAME_LOOP                       ;loop again to compare the next character

            RET

        USERNAME_LOOP ENDP

        CHECK_USERNAME_END PROC FAR
            CMP BL,'$'                              ;check whether valid username has reach the end 
            JNE INCORRECT_UP                        ;if not display error message

            MOV DI,0
            JMP PASSWORD_LOOP                       ;if yes proceed to check password

            RET

        CHECK_USERNAME_END ENDP

        PASSWORD_LOOP PROC FAR
            ;load the character from the string
            MOV AL,SPACE_PASSWORD[DI]               ;load first character from password inputed
            MOV BL,PASSWORD[DI]                     ;load first character from valid password

            CMP AL,BL                               ;compare both character
            JNE INCORRECT_UP

            CMP AL,'$'
            JE  CHECK_PASSWORD_END                  ;check whether the password inputed has reach the end

            INC DI                                  ;increment for di

            JMP PASSWORD_LOOP                       ;loop again to compare the next character

        PASSWORD_LOOP ENDP

        CHECK_PASSWORD_END PROC FAR
            CMP BL,'$'                              ;check whether valid password has reach the end 
            JNE INCORRECT_UP                        ;if not display error message

            MOV DI,0
            CALL FAR PTR DISPLAY_MENU                        ;if yes proceed to let user enter menu

            RET

        CHECK_PASSWORD_END ENDP

        INCORRECT_UP PROC FAR
            MOV AH,09H
            LEA DX, WRONG_UP_MESSAGE
            INT 21H                                 ;display error message

            CALL LOGIN                               ;jump back to login

            RET
        
        INCORRECT_UP ENDP

        RET
    MAINMENU ENDP

    DISPLAY_MENU PROC FAR
        CALL FAR PTR NEW_LINE

        MOV AH,09H
        LEA DX,STAFF_MENU_MESSAGE                ;display menu message
        INT 21H

        MOV AH,09H                              
        LEA DX,STAFF_MENU_OPTION1                                        
        INT 21H                                 ;display menu option 1

        MOV AH,09H                              
        LEA DX,STAFF_MENU_OPTION2                                        
        INT 21H                                 ;display menu option 2

        MOV AH,09H                              
        LEA DX,STAFF_MENU_OPTION3                                        
        INT 21H                                 ;display menu option 3

        MOV AH,09H                              
        LEA DX,STAFF_MENU_OPTION4                                        
        INT 21H                                 ;display menu option 4

        MOV AH,09H                              
        LEA DX,STAFF_MENU_PROMT_MSG                                        
        INT 21H                                 ;prompt user input

        MOV AH,0AH
        LEA DX,STAFF_MENU_INPUT
        INT 21H                                 ;accept user input

        .386
        MOVZX   BX,ACTUAL_STAFF_MENU 
        MOV SPACE_STAFF_MENU[BX],'$'              ;store username inputed

        CALL FAR PTR NEW_LINE

        CMP SPACE_STAFF_MENU[0],"1"                                ;if choose 1
        JE  RENT_PC                                                ;jump to RENT_PC function

        CMP SPACE_STAFF_MENU[0],"2"                                ;if choose 2
        JE  ORDER_SERVICE                                          ;jump to ORDER_SERVICE function

        CMP SPACE_STAFF_MENU[0],"3"                                ;if choose 3
        JE  REPORTS                                                ;jump to REPORTS function

        CMP SPACE_STAFF_MENU[0],"4"                                ;if choose 4
        MOV AH,00
        MOV AL,02
        INT 10H                                                    ;clear screen
        JE  MAINMENU                                               ;jump to back to LOGIN

        CALL FAR PTR STAFF_MENU_INPUT_ERROR

        STAFF_MENU_INPUT_ERROR PROC FAR
            CALL FAR PTR NEW_LINE

            MOV AH,09H                              
            LEA DX,STAFF_MENU_ERROR_MSG                             ;display error message                                   
            INT 21H  

            JMP DISPLAY_MENU

            RET

        STAFF_MENU_INPUT_ERROR ENDP

        RENT_PC PROC FAR
            MOV AH,09H
            LEA DX,RENT_PC_MESSAGE
            INT 21H

            CALL DISPLAY_MENU

            RET

        RENT_PC ENDP
        
        ORDER_SERVICE PROC FAR
            MOV AH,09H
            LEA DX,ORDER_SERVICE_MESSAGE
            INT 21H

            CALL DISPLAY_MENU

            RET

        ORDER_SERVICE ENDP

        REPORTS PROC FAR
            MOV AH,09H
            LEA DX,REPORTS_MESSAGE
            INT 21H

            CALL DISPLAY_MENU

            RET

        REPORTS ENDP

        JMP DISPLAY_MENU

        RET
    DISPLAY_MENU ENDP

    NEW_LINE PROC FAR

        MOV AH,02H                              ;prepare to display char
        MOV DL,CR                               ;move the char to be display
        INT 21H                                 ;proceed to display
        MOV DL,LF                               ;move the line feed
        INT 21H                                 ;proceed to display

        RET

    NEW_LINE ENDP

    EXIT PROC NEAR
        CALL FAR PTR NEW_LINE

        MOV AH,09H
        LEA DX,THANKYOU_MSG
        INT 21H

        MOV AX,4C00H                            ;prepare to exit
        INT 21H                                 ;carry out exit

        RET
    EXIT ENDP

    MAIN ENDP

END MAIN
TITLE       CSA_ASSIGNMENT      LOGIN MODULE    ;title
.MODEL      SMALL               ;memory of model used
.STACK      64                  ;declare stack segment
.DATA                           ;declare data segment
    ;String
    ;main menu section
    WELCOMEMESSAGE  DB  "                            WELCOME TO CYPHER CAFE", '$'
    MAINMENU_O1 DB  "                            1. LOG IN", '$'
    MAINMENU_O2 DB  "                            2. EXIT", '$'
    MAINMENUMESSAGE DB  "PLEASE ENTER YOUR CHOICE -->", '$'
    MAINMENU_ERROR_MESSAGE  DB  "INVALID INPUT, PLEASE TRY AGAIN!",'$'
    USERNAME_DISPLAY        DB  "PLEASE ENTER USERNAME -->", '$'
    PASSWORD_DISPLAY        DB  "PLEASE ENTER PASSWORD -->", '$'
    USERNAME    DB  "admin123",'$'
    PASSWORD    DB  "pass1234",'$'
    WRONG_UP_MESSAGE    DB  "Wrong Username or Password entered, Please enter again.",'$'
    CORRECT_MESSAGE  DB  "CORRECT USERNAME",'$'

    ;staff menu section
    STAFF_MENU_MESSAGE    DB  "                              *CYHPER CAFE*",'$'
    STAFF_MENU_OPTION1    DB  "                            1. RENT COMPUTERS",'$'
    STAFF_MENU_OPTION2    DB  "                            2. ORDER SERVICES",'$'
    STAFF_MENU_OPTION3    DB  "                            3. CREATE REPORTS",'$'
    STAFF_MENU_OPTION4    DB  "                            4. LOG OUT",'$'
    STAFF_MENU_PROMT_MSG  DB  "PLEASE ENTER YOUR CHOICE -->",'$'
    STAFF_MENU_ERROR_MSG  DB  "INVALID INPUT, PLEASE TRY AGAIN!",'$'

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

    MAIN PROC                                   ;start of prgram

    MOV AX,@DATA                                ;storing the address of the data segment to the ax register
    MOV DS,AX                                   ;moving the value of the ax register to ds register

    MOV AH,00
    MOV AL,02
    INT 10H                                     ;clear screen

    MAINMENU:

        MOV AH,09H                              ;prepare to display
        LEA DX,WELCOMEMESSAGE                   ;load the address of the string
        INT 21H                                 ;proceed to display

        ;new line
        MOV AH,02H                              ;prepare to display char
        MOV DL,CR                               ;move the char to be display
        INT 21H                                 ;proceed to display
        MOV DL,LF                               ;move the line feed
        INT 21H                                 ;proceed to display

        MOV AH,09H                              ;prepare to display
        LEA DX,MAINMENU_O1                      ;load the address of the string
        INT 21H                                 ;proceed to display

        ;new line
        MOV AH,02H                              ;prepare to display char
        MOV DL,CR                               ;move the char to be display
        INT 21H                                 ;proceed to display
        MOV DL,LF                               ;move the line feed
        INT 21H                                 ;proceed to display

        MOV AH,09H                              ;prepare to display
        LEA DX,MAINMENU_O2                      ;load the address of the string
        INT 21H                                 ;proceed to display

        ;new line
        MOV AH,02H                              ;prepare to display char
        MOV DL,CR                               ;move the char to be display
        INT 21H                                 ;proceed to display
        MOV DL,LF                               ;move the line feed
        INT 21H                                 ;proceed to display

        MOV AH,09H
        LEA DX,MAINMENUMESSAGE                  ;display main menu message
        INT 21H

        MOV AH,0AH
        LEA DX,MAINMENU_INPUT                   ;accept input with echo
        INT 21H                                 ;proceed to accept user input

        MOV AH,02H
        MOV DL,0DH
        INT 21H
        MOV DL,0AH
        INT 21H                                 ;perform next line

        .386
        MOVZX   BX,ACTUAL_MAINMENU
        MOV SPACE_MAINMENU[BX],'$'                  ;add the '$' sign to indicate the end of the string

        MOV AH,02H
        MOV DL,0DH
        INT 21H
        MOV DL,0AH
        INT 21H                                 ;perform next line

        CMP SPACE_MAINMENU[0],"1"                                ;if user input is 1, go to login module
        JE  LOGIN                  

        CMP SPACE_MAINMENU[0],"2"                                ;if user input is 2, exit the program
        JE  EXIT

        JMP MAINMENU_ERROR_INPUT

    MAINMENU_ERROR_INPUT:
        MOV AH,02H
        MOV DL,0DH
        INT 21H
        MOV DL,0AH
        INT 21H                                 ;perform next line

        MOV AH,09H
        LEA DX,MAINMENU_ERROR_MESSAGE           ;display error message
        INT 21H

        MOV AH,02H
        MOV DL,0DH
        INT 21H
        MOV DL,0AH
        INT 21H                                 ;perform next line

        JMP MAINMENU

    LOGIN:
        MOV AH,02H
        MOV DL,0DH
        INT 21H
        MOV DL,0AH
        INT 21H                                 ;perform next line

        MOV AH,09H                 
        LEA DX,USERNAME_DISPLAY         
        INT 21H                                 ;prompt user to enter username

        MOV AH,0AH
        LEA DX,USERNAME_INPUT
        INT 21H                                 ;accept user input

        .386
        MOVZX   BX,ACTUAL_USERNAME 
        MOV SPACE_USERNAME[BX],'$'              ;store username inputed

        MOV AH,02H
        MOV DL,0DH
        INT 21H
        MOV DL,0AH
        INT 21H                                 ;perform next line

        MOV AH,09H                 
        LEA DX,PASSWORD_DISPLAY         
        INT 21H                                 ;prompt user to enter password

        MOV AH,0AH
        LEA DX,PASSWORD_INPUT
        INT 21H                                 ;accept user password

        .386
        MOVZX   BX,ACTUAL_PASSWORD 
        MOV SPACE_PASSWORD[BX],'$'              ;store password inputed

        MOV AH,02H
        MOV DL,0DH
        INT 21H
        MOV DL,0AH
        INT 21H                                 ;perform next line

        MOV DI,0

    USERNAME_LOOP:
        ;load the character from the string
        MOV AL,SPACE_USERNAME[DI]               ;load first character from username inputed
        MOV BL,USERNAME[DI]                     ;load first character from valid username

        CMP AL,BL                               ;compare both character
        JNE INCORRECT_UP

        CMP AL,'$'
        JE  CHECK_USERNAME_END                  ;check whether the string has reach the end

        INC DI                                  ;increment for di

        JMP USERNAME_LOOP                       ;loop again to compare the next character

    CHECK_USERNAME_END:
        CMP BL,'$'                              ;check whether valid username has reach the end 
        JNE INCORRECT_UP                        ;if not display error message

        MOV DI,0
        JMP PASSWORD_LOOP                       ;if yes proceed to check password

    PASSWORD_LOOP:
        ;load the character from the string
        MOV AL,SPACE_PASSWORD[DI]               ;load first character from password inputed
        MOV BL,PASSWORD[DI]                     ;load first character from valid password

        CMP AL,BL                               ;compare both character
        JNE INCORRECT_UP

        CMP AL,'$'
        JE  CHECK_PASSWORD_END                  ;check whether the password inputed has reach the end

        INC DI                                  ;increment for di

        JMP PASSWORD_LOOP                       ;loop again to compare the next character

    CHECK_PASSWORD_END:
        CMP BL,'$'                              ;check whether valid password has reach the end 
        JNE INCORRECT_UP                        ;if not display error message

        MOV DI,0
        JMP DISPLAY_MENU                        ;if yes proceed to let user enter menu

    INCORRECT_UP:
        MOV AH,09H
        LEA DX, WRONG_UP_MESSAGE
        INT 21H                                 ;display error message

        MOV AH,02H
        MOV DL,0DH
        INT 21H
        MOV DL,0AH
        INT 21H                                 ;perform next line

        JMP LOGIN                               ;jump back to login

    DISPLAY_MENU:
        MOV AH,02H
        MOV DL,0DH
        INT 21H
        MOV DL,0AH
        INT 21H                                 ;perform next line

        MOV AH,09H
        LEA DX,STAFF_MENU_MESSAGE                ;display menu message
        INT 21H

        MOV AH,02H                              
        MOV DL,CR                               
        INT 21H                                
        MOV DL,LF                              
        INT 21H                                 ;perform new line

        MOV AH,09H                              
        LEA DX,STAFF_MENU_OPTION1                                        
        INT 21H                                 ;display menu option 1

        MOV AH,02H                              
        MOV DL,CR                               
        INT 21H                                
        MOV DL,LF                              
        INT 21H                                 ;perform new line

        MOV AH,09H                              
        LEA DX,STAFF_MENU_OPTION2                                        
        INT 21H                                 ;display menu option 2

        MOV AH,02H                              
        MOV DL,CR                               
        INT 21H                                
        MOV DL,LF                              
        INT 21H                                 ;perform new line

        MOV AH,09H                              
        LEA DX,STAFF_MENU_OPTION3                                        
        INT 21H                                 ;display menu option 3

        MOV AH,02H                              
        MOV DL,CR                               
        INT 21H                                
        MOV DL,LF                              
        INT 21H                                 ;perform new line

        MOV AH,09H                              
        LEA DX,STAFF_MENU_OPTION4                                        
        INT 21H                                 ;display menu option 4

        MOV AH,02H                              
        MOV DL,CR                               
        INT 21H                                
        MOV DL,LF                              
        INT 21H                                 ;perform new line

        MOV AH,09H                              
        LEA DX,STAFF_MENU_PROMT_MSG                                        
        INT 21H                                 ;prompt user input

        MOV AH,0AH
        LEA DX,STAFF_MENU_INPUT
        INT 21H                                 ;accept user input

        .386
        MOVZX   BX,ACTUAL_STAFF_MENU 
        MOV SPACE_STAFF_MENU[BX],'$'              ;store username inputed

        MOV AH,02H
        MOV DL,0DH
        INT 21H
        MOV DL,0AH
        INT 21H                                 ;perform next line

        CMP SPACE_STAFF_MENU[0],"1"                                ;if choose 1
        JE  RENT_PC                             ;jump to RENT_PC function

        CMP SPACE_STAFF_MENU[0],"2"                                ;if choose 2
        JE  ORDER_SERVICE                       ;jump to ORDER_SERVICE function

        CMP SPACE_STAFF_MENU[0],"3"                                ;if choose 3
        JE  REPORTS                             ;jump to REPORTS function

        CMP SPACE_STAFF_MENU[0],"4"                                ;if choose 4
        MOV AH,00
        MOV AL,02
        INT 10H                                     ;clear screen
        JE  MAINMENU                               ;jump to back to LOGIN

        JMP STAFF_MENU_INPUT_ERROR

    STAFF_MENU_INPUT_ERROR:
        MOV AH,02H                              
        MOV DL,CR                               
        INT 21H                                
        MOV DL,LF                              
        INT 21H                                 ;perform new line

        MOV AH,09H                              
        LEA DX,STAFF_MENU_ERROR_MSG             ;display error message                                   
        INT 21H  

        MOV AH,02H                              
        MOV DL,CR                               
        INT 21H                                
        MOV DL,LF                              
        INT 21H                                 ;perform new line

        JMP DISPLAY_MENU

    RENT_PC:
        MOV AH,09H
        LEA DX,RENT_PC_MESSAGE
        INT 21H

        MOV AH,02H
        MOV DL,0DH
        INT 21H
        MOV DL,0AH
        INT 21H                                 ;perform next line

        JMP DISPLAY_MENU
    
    ORDER_SERVICE:
        MOV AH,09H
        LEA DX,ORDER_SERVICE_MESSAGE
        INT 21H

        MOV AH,02H
        MOV DL,0DH
        INT 21H
        MOV DL,0AH
        INT 21H                                 ;perform next line

        JMP DISPLAY_MENU

    REPORTS:
        MOV AH,09H
        LEA DX,REPORTS_MESSAGE
        INT 21H

        MOV AH,02H
        MOV DL,0DH
        INT 21H
        MOV DL,0AH
        INT 21H                                 ;perform next line

        JMP DISPLAY_MENU

    EXIT:
        MOV AH,02H
        MOV DL,0DH
        INT 21H
        MOV DL,0AH
        INT 21H                                 ;perform next line

        MOV AH,09H
        LEA DX,THANKYOU_MSG
        INT 21H

        MOV AX,4C00H                            ;prepare to exit
        INT 21H                                 ;carry out exit

    MAIN ENDP

END MAIN
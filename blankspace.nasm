;Assignment no:05
;Roll No:48
;Class : SE-A
;Name: Vaibhav Bhausaheb Aher

;problem Statement:Write X86 ALP to find, a) Number of Blank spaces b) Number of lines c) ;Occurrence of a particular character. Accept the data from the text file. The text file has to be 'accessed during 

;Program_1 execution and write FAR PROCEDURES in Program_2 for the rest of the 

;processing. Use of PUBLIC and EXTERN directives is mandatory. 

;macro.asm ;macros as per 64 bit conventions 

;************************************************************ 

extern    far_proc     ; [ FAR PROCRDURE 
                    ;   USING EXTERN DIRECTIVE ] 

global    filehandle, char, buf, abuf_len 

%include    "macro.asm" 

;************************************************************ 
section .data 
    nline        db    10 
    nline_len    equ    $-nline 

    ano        db     10,10,10,10,"ML assignment 05 :- String Operation using Far Procedure" 
            db           10,"---------------------------------------------------",10 
    ano_len    equ    $-ano 

    filemsg    db    10,"Enter filename for string operation    : " 
    filemsg_len    equ    $-filemsg   
  
    charmsg    db    10,"Enter character to search    : " 
    charmsg_len    equ    $-charmsg 

    errmsg    db    10,"ERROR in opening File...",10 
    errmsg_len    equ    $-errmsg 

    exitmsg    db    10,10,"Exit from program...",10,10 
    exitmsg_len    equ    $-exitmsg 

;************************************************************ 
section .bss 
    buf            resb    4096 
    buf_len        equ    $-buf        ; buffer initial length 

    filename        resb    50   
    char            resb    2   

    filehandle        resq    1 
    abuf_len        resq    1        ; actual buffer length 


;************************************************************ 
section .text 
    global _start 
       
_start: 
        display    ano,ano_len        ;assignment no. 

        display    filemsg,filemsg_len       
        accept     filename,50 
        dec    rax 
        mov    byte[filename + rax],0        ; blank char/null char 

        display    charmsg,charmsg_len       
        accept     char,2 
       
        fopen    filename            ; on succes returns handle 
        cmp    rax,-1H            ; on failure returns -1 
        jle    Error 
        mov    [filehandle],rax   

        fread    [filehandle],buf, buf_len 
        mov    [abuf_len],rax 

        call    far_proc 
        jmp    Exit 

Error:    display    errmsg, errmsg_len 

Exit:    display    exitmsg,exitmsg_len 
   
    display nline,nline_len 

    mov rax,60 
 mov rdi,0 
    syscall



global    far_proc       

extern    filehandle, char, buf, abuf_len 

%include "macro.asm" 
;************************************************************ 
section .data 
    nline        db    10,10 
    nline_len:    equ    $-nline 

    smsg        db    10,"No. of spaces are    : " 
    smsg_len:    equ    $-smsg 
    
    nmsg        db    10,"No. of lines are    : " 
    nmsg_len:    equ    $-nmsg 

    cmsg        db    10,"No. of character occurances are    : " 
    cmsg_len:    equ    $-cmsg 


;************************************************************ 
section .bss 

    scount    resq    1 
    ncount    resq    1 
    ccount    resq    1 

    dispbuff    resb    4 

;************************************************************ 
section .text 
;    global    _main 
;_main: 

far_proc:                  ;FAR Procedure 
    
        mov    rax,0 
        mov    rbx,0 
        mov    rcx,0 
        mov    rsi,0   

        mov    bl,[char] 
        mov    rsi,buf 
        mov    rcx,[abuf_len] 

again:    mov    al,[rsi] 

case_s:    cmp    al,20h        ;space : 32 (20H) 
        jne    case_n 
        inc    qword[scount] 
        jmp    next 

case_n:    cmp    al,0Ah        ;newline : 10(0AH) 
        jne    case_c 
        inc    qword[ncount] 
        jmp    next 

case_c:    cmp    al,bl            ;character 
        jne    next 
        inc    qword[ccount] 

next:   inc    rsi 
        dec    rcx            ; 
        jnz    again            ;loop again 

        display smsg,smsg_len 
        mov    rbx,[scount] 
        call    display16_proc 
    
        display nmsg,nmsg_len 
        mov    rbx,[ncount] 
        call    display16_proc 

        display cmsg,cmsg_len 
        mov    rbx,[ccount] 
        call     display16_proc 

    fclose    [filehandle] 
    ret 


display16_proc: 
    mov rdi,dispbuff    ;point esi to buffer 
    mov rcx,4        ;load number of digits to display 
dispup1: 
    rol bx,4        ;rotate number left by four bits 
    mov dl,bl        ;move lower byte in dl 
    and dl,0fh        ;mask upper digit of byte in dl 
    add dl,30h        ;add 30h to calculate ASCII code 
    cmp dl,39h        ;compare with 39h 
    jbe dispskip1        ;if less than 39h akip adding 07 more 
    add dl,07h        ;else add 07 

dispskip1: 
    mov [rdi],dl        ;store ASCII code in buffer 
    inc rdi            	;point to next byte 
    loop dispup1	    ;decrement the count of digits to display 
		                ;if not zero jump to repeat 

    display dispbuff,4    
    
    ret 

%macro accept 2 
    mov    rax,0    ;read 
    mov    rdi,0    ;stdin/keyboard 
    mov    rsi,%1    ;buf 
    mov    rdx,%2    ;buf_len 
    syscall 
%endmacro 

%macro display 2 
    mov    rax,1    ;print 
    mov    rdi,1    ;stdout/screen 
    mov    rsi,%1    ;msg 
    mov    rdx,%2    ;msg_len 
    syscall 
%endmacro 

%macro fopen 1 
    mov    rax,2        ;open 
    mov    rdi,%1        ;filename 
    mov    rsi,2        ;mode RW 
    mov    rdx,0777o    ;File permissions 
    syscall 
%endmacro 

%macro fread 3 
    mov    rax,0    ;read 
    mov    rdi,%1    ;filehandle 
    mov    rsi,%2    ;buf 
    mov    rdx,%3    ;buf_len 
    syscall 
%endmacro 

%macro fwrite 3 
    mov    rax,1    ;write/print 
    mov    rdi,%1    ;filehandle 
    mov    rsi,%2    ;buf 
    mov    rdx,%3    ;buf_len 
    syscall 
%endmacro 

%macro fclose 1 
    mov    rax,3        ;close 
    mov    rdi,%1    ;file handle 
    syscall 
%endmacro


;**************OUTPUT************************* 
;gescoe@gescoe-OptiPlex-3020:~$ cd Downloads 
;gescoe@gescoe-OptiPlex-3020:~/Downloads$ nasm -f elf64 file1.asm 
;gescoe@gescoe-OptiPlex-3020:~/Downloads$ nasm -f elf64 file2.asm 
;gescoe@gescoe-OptiPlex-3020:~/Downloads$ ld file1.o  file2.o -o file2 
;gescoe@gescoe-OptiPlex-3020:~/Downloads$ ./file2 
;ML assignment  :- String Operation using Far Procedure 
--------------------------------------------------- 

;Enter filename for string operation    : t.txt 

;Enter character to search    : y 

;No. of spaces are    : 0006 
;No. of lines are    : 000A 
;No. of character occurances are    : 0004 

;Exit from program... 

;gescoe@gescoe-OptiPlex-3020:~/Downloads$ 

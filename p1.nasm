section .data
msg1 db 'NIKITA',0ah
len1 equ $-msg1

msg2 db 'SY',0ah
len2 equ $-msg2

msg3 db 'A',0ah
len3 equ $-msg3

msg4  db '30',0ah
len4 equ $-msg4

msg5 db 'Gokhale clg',0ah
len5 equ $-msg5

msg6 db 'Enter your age: ',0AH
len6 equ $-msg6

msg7 db 'Your age is: ',0AH
len7 equ $-msg7

%macro write 2
mov edx,%2
mov esi,%1
mov edi,1
mov eax,1
syscall
%endmacro

%macro read 2
mov edx,%2
mov esi,%1
mov edi,0
mov eax,0
syscall
%endmacro

section .bss
num1 resb 1


section .text
global _start
_start:

write msg1,len1
write msg2,len2
write msg3,len3
write msg4,len4
write msg5,len5
write msg6,len6
read num1,1
write msg7,len7
write num1,1

mov rax,60
syscall

section .data
     msg dw 'hello,world! ',0AH
     len equ $-msg

section .bss
     
     
section .text     
     global _start
     _start:
          mov edx,len
          mov esi,msg
          mov edi,1
          mov eax,1
          syscall
          
          mov rax,60
          syscall

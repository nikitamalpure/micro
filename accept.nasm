section .data
               msg db ' accept the values ',0AH
               len equ $-msg

               msg2 db 'entered numbers are ' ,0AH
               len2 equ $-msg
               
               
             
section .bss
               
            num1 resb 2
            
                          
                              
section .text
               global _start
               _start:
               
               
               mov edx,len
               mov esi,msg
               mov edi,1
               mov eax,1
               syscall
               
               
               mov edx,num1
               mov esi,2
               mov edi,0  ; it will accept num1
               mov eax,0
               syscall
               
               
               
               mov edx,len2
               mov esi,msg2
               mov edi,1
               mov eax,1
               syscall
               
               
               mov edx,num1
               mov esi,2
               mov edi,1 ; it will accept num1
               mov eax,1
               syscall
               
               
               
               mov rax,60
               syscall                     

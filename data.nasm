section .data
     msg1 dw 'Name = nikita malpure',0AH
     len1 equ $-msg1
     msg2 db ' class = SA2 ',0AH
     len2 equ $-msg2
     msg3 db ' RollNo = 27 ',0DH
     len3 equ $-msg3  
   
   
   

section .bss
     
     
section .text     
     global _start
     _start:
          mov edx,len1
          mov esi,msg1
          mov edi,1
          mov eax,1
          syscall
          
          mov edx,len2
          mov esi,msg2
          mov edi,1
          mov eax,1
          syscall
          
          mov edx,len3
          mov esi,msg3
          mov edi,1
          mov eax,1
          syscall
          
          mov rax,60
          syscall

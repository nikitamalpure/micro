;
%macro write 2
mov rdx,%1
mov rsi,%2
mov rdi,1
mov rax,1
syscall
%endmacro

section .data
arr dq 1234567890000000h ,-1244000000000000h,-1232000000000000h ,-1250000000000000h
n equ 4
pmsg db "Positive count is:",0Ah
plen equ $ -pmsg
nmsg db "Negative count is:",0Ah
nlen equ $ -nmsg
nwline db 10	;for new line
  
  
  section .bss
	  pcnt resq 11
	  ncnt resq 11
	  num  resb 16
  
  section .text
	  global _start
       _start:
       mov rsi,arr
       mov rdi,n
       mov rbx,0
       mov rcx,0
       
       up:mov rax,[rsi]
              cmp rax ,0000000000000000h
              js negative
              
              positive: inc rbx
                        jmp next
                        
              negative: inc rcx
              
              next:
                    add rsi,8
                    dec rdi
                    jnz up
                    mov [pcnt],rbx
                    mov [ncnt],rcx
                    
                    ; call disp
                   write plen,pmsg
                   mov rax,[pcnt]
                     
                   call disp
                   write nwline,1
                   
                   write nlen,nmsg
                   mov rbx,[ncnt]
                   
                   call disp
                   write nwline,1
                  
                   mov rax,60
                   mov rbx,0
                   syscall
                   

                  disp:
                mov rcx,2
                 mov rdi,num
        
                 l5:
        	          rol bl,4
        	         mov al,bl
        	         and al,0Fh
        	         cmp al,09h
        	         jnz l4
        	         add al,07h
                 
                                 
                 l4:
                 	add al,30h
                 	mov [edi],al
                 	inc edi
                 	dec ecx
                 	jnz l5
                 	write 2,num
	                ret
            

              
;    gescoe@gescoe-OptiPlex-3020:~$ nasm -f elf64 Assign1.nasm
;gescoe@gescoe-OptiPlex-3020:~$ ld Assign1.o -o Assign1
;escoe@gescoe-OptiPlex-3020:~$ ./Assign1
;Positive count is:0000000000000001;
;Negative count is:0000000000000003
;gescoe@gescoe-OptiPlex-3020:~$ 
               

;Problem Statement :- Write 80387 ALP to Find Roots Of Quadriatic Equation.
;Name :- Vaibhav Bhausaheb Aher 
;std :- SE(Comp) Div :- A
;Batch :-SA-3
;Roll No.:- 48     

section .data
		msg1 db "Complex Root",0Ah
		msglen1 equ $-msg1
		msg2 db "Root1: ", 0Ah
		msglen2 equ $-msg2
		msg3 db "Root2: ",0Ah
		msglen3 equ $-msg3
		a dd 1.00
		b dd 8.00
		c dd 15.00
		four dd 4.00
		two dd 2.00

		hdec dq 100
		point db "."
		
section .bss
	
					root1 resd 1
					root2 resd 1
					resbuff rest 1
					temp resb 2
					disc resd 1

				%macro write 2			
					mov rax,1 
					mov rdi,1
					mov rsi,%1
					mov rdx,%2
					syscall
				%endmacro

				%macro read 2			
					mov rax,0
					mov rdi,0
					mov rsi,%1
					mov rdx,%2
					syscall
				%endmacro

				%macro exit 0			
					mov rax,60
					xor rdi,rdi
					syscall
				%endmacro

section .text
			  global _start
			  _start:
  
		     finit				
			 fld dword[b]			
			 fmul dword[b] 		
			 fld dword[a]		
			 fmul dword[c] 		
			  fmul dword[four]		  
			  fsub	 			
			  ftst 				
			  fstsw ax			
			  sahf		
			  jb no_real_solutions 		
			  fsqrt 			

			  fst dword[disc] 	
			  fsub dword[b] 			
			  fdiv dword[a] 			
			  fdiv dword[two]
			  write msg2,msglen2  
     		 call disp_proc 
			  fldz				
			  fsub dword[disc]		
			  fsub dword[b] 			
			  fdiv dword[a]		
			  fdiv dword[two]
			  
			  write msg3,msglen3
			  call disp_proc 
			  jmp exi

			 no_real_solutions:
			 write msg1,msglen1
			 
			 exi : 
			 mov rax,60
			 mov rdi,1
			 syscall
			  	

			disp_proc:
				FIMUL dword[hdec]
				FBSTP tword[resbuff]
				mov rsi,resbuff+9
				mov rcx,09
			  next1:
			  	
			  	push rcx
			  	push rsi
			  	
			  	mov bl,[rsi]
			  	call disp
			  	
			  	pop rsi
			  	pop rcx
			  	
			  	dec rsi
			  	loop next1
			  	
			  	push rsi
			  	write point,1
			  	pop rsi
			  	
			  	mov bl,[rsi]
			  	call disp
			  	ret
  	
  	disp:
	  	mov edi,temp          
	  	mov ecx,02              
	  	
 dispup1:                   
			    rol bl,4			    
		        mov dl,bl				
		        and dl,0fh			
		        add dl,30h			
		        cmp dl,39h		
		        jbe dispskip1			
		        add dl,07h			
		  
 dispskip1:
		            mov [edi],dl		
		            inc edi			
    		        loop dispup1		
	    	        write temp,2		
		            ret		                    

;OUTPUT :-
;gescoe@hadoopslave1:~$ nasm -f elf64 root.nasm
;gescoe@hadoopslave1:~$ ld  root.o -o root
;gescoe@hadoopslave1:~$ ./root
;Root1: 
;800000000000000003.00
;Root2: 
;800000000000000005.00
;gescoe@hadoopslave1:~$ 

	  	
	  	

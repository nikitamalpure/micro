;Program Name :- Write X86/64 ALP to switch from real mode to protected mode and  	  
;                display the values of GDTR, LDTR, IDTR, TR and MSW Registers.
;Std :- SE Div :- A
;Roll NO.:- 48
;Batch :- SA-3 

section .data 

	msg db 'Welcome:: ',0Ah 
	len equ $-msg 
	
	msg1 db 'GDT containts are :: ',0Ah 
	len1 equ $-msg1 
	
	msg2 db 'LDT containts are :: ',0Ah 
	len2 equ $-msg2 
	
	msg3 db 'IDT containts are :: ',0Ah 
	len3 equ $-msg3 
	
	nxline db 10 
	
	colmsg db ';' 
	
	msg7 db 'MSW containts are :: ',0Ah 
	len7 equ $-msg7 
	
	msg8 db 'TR containts are :: ',0Ah 
	len8 equ $-msg8 
	
	msg4 db 'Processor in real mode :: ',0Ah 
	len4 equ $-msg4 
	
	msg5 db 'Processor in Protected mode :: ',0Ah 
	len5 equ $-msg5 
	
	msg6 db ' ',0ah 
	len6 equ $-msg6 

	%macro write 2 
		mov edx,%2 
		mov esi,%1 
		mov edi,1 
		mov eax,1 
		syscall 
	%endmacro 
	 
section .bss 

		gdt resd 10 
		idt resd 10 
		ldt resd 10 
		tr  resd 10 
		cr  resd 10 
		msw resd 10 
		dnum_buff resb 04 
	 
section .text 
				global _start 
				       _start: 
							 	 write msg,len 
							 	 smsw eax 
							 	 mov [cr],eax 
							 	 ror eax,1 
							 	 jc prmode 
							 	 write msg4,len4 
							 	 jmp nxt1	 
 	 
					prmode: 
					 	 	write msg5,len5 
					 	 
			 	      nxt1:  sgdt[gdt] 
					 		 sldt[ldt] 
					 		 sidt[idt] 
					 		 str[tr] 
					 		 
					 		 write msg1,len1 
					 		 mov bx,[gdt+4] 
					 		 call display 
					 		 write colmsg,1 
					 		 mov bx,[gdt+2] 
					 		 call display 
					 		 write colmsg,1 
					 		 mov bx,[gdt] 
					 		 call display 
					 		 write msg6,len6 
					 		 
					 		 write msg2,len2 
					 		 mov bx,[idt] 
					 		 call display 
						 	 write msg6,len6 
					 		 
					 		 write msg3,len3 
					 		 mov bx,[idt+4] 
					 		 call display 
					 		 write colmsg,1 
					 		 mov bx,[idt+2] 
					 		 call display 
					 		 write colmsg,1 
					 		 mov bx,[idt] 
					 		 call display 
					 		 write msg6,len6 
					 		 write msg7,len7 
					 		 
					 		 mov bx,[cr] 
					 		 call display 
					 		 write msg6,len6 
					 		 
							 mov rax,60 
					 		 mov rdi,00 
					 		 syscall 
					 		 
					 		 		 
				  display : 
							mov esi,dnum_buff 
							mov ch,04 
							mov cl,04 
						 
						l1: 
							rol bx,cl 
							mov dl,bl 
							and dl,0fh 
							add dl,30h 
							cmp dl,39h 
							jbe l2 
							add dl,07h 
					    
					    l2: 
					 	 	mov [esi],dl 
					 	 	inc esi 
					 	 	dec ch 
					 	 	jnz l1 
					 	 	mov rax,1 
					 	    mov rdi,1 
					 	    mov rsi,dnum_buff 
					 	    mov rdx,4 
					 	 	syscall 
					 	    ret 
					 	 	 
;OUTPUT :-
;gescoe1@hadoopmaster:~$ nasm -f elf64 my1.nasm
;gescoe1@hadoopmaster:~$ ld my1.o -o my1
;gescoe1@hadoopmaster:~$ ./my1
;Welcome:: 
;Processor in Protected mode :: 
;GDT containts are :: 
;1FB8;A000;007F 
;LDT containts are :: 
;0FFF 
;IDT containts are :: 
;FF57;6000;0FFF 
;MSW containts are :: 
;0033 
;gescoe1@hadoopmaster:~$ 

;Aim: Write x86 ALP to find the factorial of a given  integer     number on a command line by using recursion. 
; Explicit stack manipulation is expected in the code.
;Roll No: 48      Div:A 

section .data 
	num db 001h 
	
     msg db "Factorial Is : ",0Ah 
     msglen equ $-msg 
	
     msg1 db "Program to factorial is: ",0Ah 
	     db "Enter the number :" 
	msg1len equ $-msg1 
	 
      zerofact db "00000001" 
	 zerofactlen equ $-zerofact 

	%macro cmn 4 
	mov rdx,%4 
	mov rsi,%3 
	mov rdi,%2 
	mov rax,%1 
	%endmacro 

section .bss 
	dispnum resb 16 
	result resb 4 
	temp resb 3 

section .text 
		global _start 
		       _start:  
				cmn 1,1,msg1,msg1len 
				cmn 0,0,temp,3 
				call convert 
				mov [num],dl 

				cmn 1,1,msg,msglen 
				xor rdx,rdx 
				xor rax,rax 
				mov al,[num] 
				cmp al,01h 
				jbe endfact 
				xor rbx,rbx 
				mov bl,01h 
				call factr 
				call display 
				call exit 

			endfact: 
				cmn 1,1,zerofact,zerofactlen 
				call exit 
				 
			factr: 
				cmp rax,01H 
				je retconl 
				push rax 
				dec rax 
				call factr 
				 
			retcon: 
				pop rbx 
				mul ebx 
				jmp endpr 

			retconl: 
				pop rbx 
				jmp retcon 

			endpr: 
				ret 

		display: 
			mov rsi,dispnum+15 
			xor rcx,rcx 
			mov cl,16 
			 
		cont: 
			xor rdx,rdx 
			xor rbx,rbx 
			mov bl,10h 
			div ebx 
			cmp dl,09h 
			jbe skip 
			add dl,07h 

		skip: 
			add dl,30h 
			mov [rsi],dl 
			dec rsi 
			loop cont 
			cmn 1,1,dispnum,16 
		        ret 

		convert: 
			mov rsi,temp 
			mov cl,02h 
			xor rax,rax 
			xor rdx,rdx 

		contc: 
			rol dl,04h 
			mov al,[rsi] 
			cmp al,39h 
			jbe skipc 
			sub al,07h 

		skipc: 
			sub al,30h 
			add dl,al 
			inc rsi 
			dec cl 
			jnz contc 
			ret 
			 
		exit: 
			mov rax,60 
			mov rdi,0 
			syscall 
			ret

;Output:
;ges@ges-OptiPlex-3020:~/Desktop$ nasm -f elf64 fact.nasm 
;ges@ges-OptiPlex-3020:~/Desktop$ ld fact.o -o fact 
;ges@ges-OptiPlex-3020:~/Desktop$ ./fact
;Program to factorial is: 
;Enter the number :05 
;Factorial Is : 
;0000000000000078
;ges@ges-OptiPlex-3020:~/Desktop$ ./fact 
;Program to factorial is: 
;Enter the number :02 
;Factorial Is : 
;0000000000000002
;ges@ges-OptiPlex-3020:~/Desktop$ ./fact 
;Program to factorial is: 
;Enter the number :03 
;Factorial Is : 
;0000000000000006
;ges@ges-OptiPlex-3020:~/Desktop$ ./fact 
;Program to factorial is: 
;Enter the number :04 
;Factorial Is : 
;0000000000000018

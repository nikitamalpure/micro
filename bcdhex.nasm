section .data	 

msg1 db 'Enter 5 digit BCD Number :',00AH 
len1 equ $-msg1 
		 
msg2 db 'HEX Number Is: ',00AH
len2 equ $-msg2 
		 		
new db "",00AH 
newl equ $-new	 

%macro write 2 
mov edx,%1
mov esi,%2 
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
hex resb 17 
bcd  resb 17
bcdl resb 17 
 
section .text 
global _start 
_start: 
	
		write len1,msg1 
		read bcd,6 
		 
		mov rcx,5 
		mov rdi,bcd 
		mov rbx,0ah 
		mov rdx,0 
		mov rax,0 
	
	l7:	 
		mul rbx 
		mov dl,[rdi] 
		sub dl,30h 
		add rax,rdx 
		inc rdi 
		dec rcx 
		jnz l7 
		 
		mov rbx,rax 
		call disp 
		write len2,msg2
		write 16,bcd 
	 	write newl,new 

 		mov rax,60
 		syscall

accept: 
	mov rbx,0 
	mov rcx,4 
	mov r8,hex 
	 
	L1 : 
		shl bx,4 
		mov al,[r8] 
		cmp al,39h 
		jbe L2 
		sub al,07h 
	L2 : 
		sub al,30h 
		add bx,ax 
		inc r8 
		dec rcx 
		jnz L1 
		ret 
		 
disp : 
	mov rcx,16 
	mov r9,bcd 
	 

l3 : 
	rol rbx,4 
	mov rax,rbx 
	AND rax,000000000000000Fh 
	cmp al,09h
	jbe l4 
	add al,07h 

l4 :	 
	add al,30h 
	mov [r9],al 
	inc r9 
	dec rcx 
	jnz l3 
	 
	ret 
;OUTPUT
;gescoe@gescoe-OptiPlex-3020:~/Desktop$ nasm -f elf64 bcdhex1.nasm
;gescoe@gescoe-OptiPlex-3020:~/Desktop$ ld bcdhex1.o -o bcdhex1
;gescoe@gescoe-OptiPlex-3020:~/Desktop$ ./bcdhex1
;Enter 5 digit BCD Number :
;00010
;HEX Number Is: 
;000000000000000A
;gescoe@gescoe-OptiPlex-3020:~/Desktop$ ./bcdhex1
;Enter 5 digit BCD Number :
;00015
;HEX Number Is: 
;000000000000000F
;gescoe@gescoe-OptiPlex-3020:~/Desktop$ 


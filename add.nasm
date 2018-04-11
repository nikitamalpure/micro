
section .data
msg db 'Addition :=',0AH
len equ $-msg

%macro write 2

	mov edx,%1
	mov esi ,%2
	mov edi,1
	mov eax,1
	syscall
	%endmacro

section .bss
	num1 resb 2

section .text
	global _start
	_start:

mov eax,'3'
sub eax,'0'
mov ebx,'2'
sub ebx,'0'
add eax,ebx
add eax,'0'
mov[num1],eax
write len,msg
write 2,num1
mov rax,60
syscall
	


section .data
msg db 'Addition :='
len equ $-msg
msg2 db  ' ',0AH
len2 equ $-msg2

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

mov eax,'A'
sub eax,'0'
mov ebx,'2'
sub ebx,'0'
add eax,ebx
add eax,'0'
mov[num1],eax
write len,msg
write 2,num1
write len2,msg2
mov rax,60
syscall

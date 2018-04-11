;Problem Statment:80386 ALP Program for NOn-Overlapped block transfer.
;Div:SE A
;Roll no:48 
;Name:-Vaibhav Bhausaheb Aher 


section .data 

srblk db 01h,02h,03h,04h,05h 
dsblk db 00h,00h,00h,00h,00h 

msg1 db 'block before execution',0Ah 
len1 equ $-msg1 

msg2 db 'Source block',0Ah 
len2 equ $-msg2 

msg3 db 'Destination block',0Ah 
len3 equ $-msg3 


msg4 db 'block after execution',0Ah 
len4 equ $-msg4 

cnt equ 5 

%macro write 2 
	mov edx,%1 
	mov esi,%2 
	mov edi,1 
	mov eax,1 
	syscall 
%endmacro 

%macro read 2 
	mov edx,%1 
	mov esi,%2 
	mov edi,0 
	mov eax,0 
	syscall 
%endmacro 

%macro exit 0 
	mov eax,60 
	syscall 
%endmacro 

section .bss 

num2 resb 02 

section .text 
	global _start 
		  _start: 
		  
		 write len1,msg1 
		 write len2,msg2 
		 call sblk 
		 
		 write len3,msg3 
		 call dblk 
		 
		 write len4,msg4 
		 write len2,msg2 
            call sblk
            write len3,msg3 
		 mov r8,sblk 
		 mov r9,dblk
            mov cl,cnt
 
        l6:
            mov al,[r8]
            mov [r9],al
            inc r8
            inc r9
            dec cl
            jnz l6
            call dblk

            mov rax,60
            syscall

sblk: 
	 mov r8,sblk 
	 mov rcx,0 
	 mov rcx,cnt 
	 
	 l5: 
	 	push rcx 
	 	mov bl,[r8] 
	 	call disp 
	 	inc r8 
	 	pop rcx 
	 	loop l5
	 	ret 
dblk: 
	mov r9,dblk 
	xor rcx,rcx 
	mov rcx,cnt 
	 
	l8: 
		push rcx 
		mov bl,[r9] 
		call disp  
		inc r9 
		pop rcx 
		loop l8
		ret 


disp: 
	mov ecx,02 
	mov edi,num2 
	 
	l1: 
		rol bl,4 
		mov al,bl 
		and al,0Fh 
		cmp al,09h 
		jbe l2 
		add al,07h 
	l2: 
		add al,30h 
		mov [edi],al 
		inc edi 
		dec ecx 
		jnz l1 
		write 02,num2 
		ret 
 		 

	 	 
;		 
;vaibh@vaibh-Aspire-4755:~$ nasm -f elf64 nonoverlap.nasm
;vaibh@vaibh-Aspire-4755:~$ ld nonoverlap.o -o nonoverlap
;vaibh@vaibh-Aspire-4755:~$ ./nonoverlap
;block before execution
;Source block
;01  
;02  
;03  
;04  
;05  
;Destination block
;0000000000
;block after execution
;Source block
;01  
;02  
;03  
;04  
;05  
;Destination block  
;01  
;02  
;03  
;04  
;05  
;vaibh@vaibh-Aspire-4755:~

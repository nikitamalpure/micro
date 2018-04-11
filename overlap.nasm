;Problem Statment:80386 APL Program for Overlapped block transfer.
;Div:SE A
;Roll no:48 
;Name:-Vaibhav Bhausaheb Aher 


section .data 
msg1 db 'Source block before execution',0Ah 
len1 equ $-msg1 

msg2 db 'Source block',0Ah 
len2 equ $-msg2 

msg3 db 'Destination block',0Ah 
len3 equ $-msg3 
srblk db 01h,02h,03h,04h,05h 

msg4 db 'Destion block after execution',0Ah 
len4 equ $-msg4 

msg5 db 'Enter overlapp size' 
len5 equ $-msg5 
dsblk db 00h,00h,00h,00h,00h 

msg6 db '  ',0Ah 
len6 equ $-msg6 

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
num1 resb 02 
cnt1 resb 00h 

section .text 
	global _start 
		  _start: 
		  
		 write len1,msg1 
		 write len2,msg2 
		 call sblk 
		 
		 write len3,msg3 
		 call dblk 
		 
		 write len5,msg5 
		 read 2,num1 
		 mov r8,num1 
		 mov bl,[r8] 
		 cmp bl,39h 
		 jbe t1 
		 sub bl,07h 
		 
		t1: 
		sub bl,30h 
		mov [cnt1],bl 
		write len4,msg4 
		write len2,msg2 
		call sblk 
		write len3,msg3 
		mov r8,srblk+4 
		mov r9,r8 
		add r9,[cnt1] 
		mov cl,cnt 

		t2: 
		mov al,[r8] 
		mov [r9],al 
		dec r9 
		dec r8 
		dec cl 
		jnz t2 
		call sblk1 
		exit 

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
 		 
sblk: 
	 mov r8,srblk 
	 xor rcx,rcx 
	 mov rcx,cnt 
	 
	 l7: 
	 	push rcx 
	 	mov bl,[r8] 
	 	call disp 
		write len6,msg6 

	 	inc r8 
	 	pop rcx 
	 	loop l7 
	 	ret 

sblk1: 
	mov r8,srblk 
	xor rcx,rcx 
	mov rcx,cnt 
	add rcx,[cnt1] 
	 
	l3: 
		push rcx 
		mov bl,[r8] 
		call disp 
		write len6,msg6 
		inc r8 
		pop rcx 
		loop l3 
		ret 
	 	 
dblk: 
	mov r9,dsblk 
	xor rcx,rcx 
	mov rcx,cnt 
	 
	l4: 
		push rcx 
		mov bl,[r9] 
		call disp  
		inc r9 
		pop rcx 
		loop l4 
		ret 
;		 
;sakshi@sakshi-Aspire-4755:~$ nasm -f elf64 overlap.nasm
;sakshi@sakshi-Aspire-4755:~$ ld overlap.o -o overlap
;sakshi@sakshi-Aspire-4755:~$ ./overlap
;Source block before execution
;Source block
;01  
;02  
;03  
;04  
;05  
;Destination block
;0000000000Enter overlapp size2
;Destion block after execution
;Source block
;01  
;02  
;03  
;04  
;05  
;Destination block
;01  
;02  
;01  
;02  
;03  
;04  
;05  
;sakshi@sakshi-Aspire-4755:~

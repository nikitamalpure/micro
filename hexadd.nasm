section .data

msg db 'Enter the first number= ',0AH
len equ $-msg
msg1 db 'Enter the second number= ',0AH
len1 equ $-msg1
msg2 db 'addition of two number is= ',0AH
len2 equ $-msg2
msg3 db '  ',0AH
len3 equ $-msg3

%macro read 2
	mov edx,%1
	mov esi,%2
	mov edi,0
	mov eax,0
	syscall
%endmacro

%macro write 2
    mov edx,%1
	mov esi,%2
	mov edi,1
	mov eax,1
	syscall
%endmacro	
	
section .bss
	num1 resb 14
	num2 resb 14
    res resb 12

	m1 resb 14
	m2 resb 12

section .text
  global _start
         _start:
         
         write len,msg
         read 3,num1
         call accept
         mov [m1],bl
         
         write len1,msg1
         read 3,num1
         call accept
         mov [m2],bl
         
         mov eax,[m1]
         mov ebx,[m2]  
         add eax,ebx
         mov [res],eax
        
         call disp 
         write len2,msg2  
         write 2,num2 
         write len3,msg3
            
       mov rax,60
       syscall      
   
  accept:
   		mov bl,0
   		mov ecx,2
   		mov esi,num1
   		 
      l1:		
        shl bl,4
        mov al,[esi]
        cmp al,39h
        jbe l2
        sub al,07h
        
      l2:
        sub al,30h
        add bl,al
        inc esi
        dec ecx
        jnz l1
        ret
      	
    disp:
    	mov bl,[res]
    	mov ecx,2
    	mov edi,num2
    	
     l5:
     	rol bl,4
     	mov al,bl
     	and al,0Fh
     	cmp al,09h
     	jbe l4
     	add al,07h
     	
     l4:
     	add al,30h
     	mov [edi],al
     	inc edi
     	dec ecx
     	jnz l5
     	
     	ret  

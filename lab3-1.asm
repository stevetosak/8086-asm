name lab3-1

data segment
    ; add your data here!
    pkey db "press any key...$"
    A dw 10 dup(0)
    buff dw 10 dup(0)
    terminate db 0
ends

stack segment
    dw   128  dup(0)               
ends

code segment
    
   
    
  
    
    
start:
; set segment registers:
    mov ax, data
    mov ds, ax
    mov es, ax 

    ; add your code here
    mov si, 0
    push si 
    lea bx,buff
    read_input:
    mov ah, 0x1
    int 21h
    
    cmp al, '0'
    jb not_num
    cmp al,'9'
    ja not_num 
    mov ah, 0
    sub al, '0'
    
    mov [bx][si],ax
    jmp incr
    
    
    not_num:
    cmp al,32d
    je check_buff
    cmp al,'.'
    je set_terminate
    
    jmp bad_input
    
    set_terminate:
    mov terminate,1d
    jmp check_buff
    
    
    check_buff:
    cmp si, 0
    je bad_input 
    jmp create_num
    
    incr:
    inc si
    jmp read_input
    
    
    bad_input:
    ;zavrsi programata
    
    create_num:
    mov ax,0d 
    dec si
    push si
    mov di,si
    mov si,0d
    mov cx,0d
    mov ax,[bx][si]
    
    pow:
   
    cmp di, 0d
    je next_digit
    push cx
    mov cl, 10d
    mul cl
    pop cx
    dec di
    
    jmp pow
    
    next_digit:
      
    pop di
    cmp di,0
    je end_pow
    
    inc si 
    dec di
    add cx,ax
    
    cmp di,0
    je end_pow
    
    
    
    push di
    mov ax,[bx][si]
    jmp pow
    
    end_pow: 
    mov ax,0
    add cx,[bx][si]
    pop si
    lea bx,A
    push si
    mov al,2d
    mul si
    mov si,ax
    mov [bx][si],cx
    pop si
    inc si
    push si
    
    cmp si, 10
    je end_prog 
    
    mov si,0
    mov cx,0 
    lea bx,buff
   
    
    mov cl,terminate
    cmp cl, 1
    je end_prog

    jmp read_input
    
    
    end_prog:
    
    lea bx,A
    mov cx,[bx]
    
      
ends

end start ; set entry point and stop the assembler.

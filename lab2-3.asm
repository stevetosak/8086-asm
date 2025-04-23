; multi-segment executable file template.
name "lab2-3"

data segment
    ; add your data here!
    pkey db "press any key...$"
ends

stack segment
    dw   128  dup(0)
    res_buff db 10 dup<?>
ends

code segment
    
    
start:
; set segment registers:
    mov ax, data
    mov ds, ax
    mov es, ax 
    
    
    mov cx,0d
    mov ah,0x1
    int 21h
    sub al,'0'
    mov bx,10d
    mul bx
    mov cl,al
    mov ah,0x1
    int 21h
    sub al, '0'
    add cl,al
    
    mov si,1d
    mov bx,0d ;; vo bx sumata
    
    sum:
    
    cmp si,cx
    ja end_sum
    
    
    mov ax,si
    push bx
    mov bx, 3d
    div bx
    pop bx
    
    cmp dx,1d
    jne incr
    
    add bx,si
    
    
    incr:
    inc si
    jmp sum
    
    
    
    end_sum:
    
    mov si, 0
    
    ext_digits: 
    cmp bx,0
    je end_ext_digits
    
    
    xor dx,dx
    mov ax,bx
    mov cx,10d
    div cx
    push dx
    mov bx,ax
    
    inc si
    jmp ext_digits
    
    
    end_ext_digits:
    
    lea bx,res_buff
    mov di,0
    
    create_num:
    cmp si,0
    je print_num
    
    pop cx
    add cx,'0'
    mov [bx][di],cx
    inc di
    dec si
    jmp create_num
    
    print_num:
    
    mov [bx][di],'$'
    
    mov ah, 0x9
    lea dx, res_buff
    int 21h
    
    
    
    

    
    
    
    
    

    ; add your code here
   
ends

end start ; set entry point and stop the assembler.

; multi-segment executable file template.
name "dop-6"
data segment
    ; add your data here!
    pkey db "press any key...$"
    mtx db 5,5,5,4,4,4,3,3,3,2,2,2
    ROW_SIZE db 3d
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
    
    mov ch,1d
    mov cl,3d
    
    mov di, 0d 
   
    swap:
    
    cmp di,2d ;; col size
    ja end_swap 
     
    mov ax,0d
    mov si, di
    
    lea bx, mtx
           
    mov al,ch ;; row idx
    mul ROW_SIZE ;; * row size
    
    add si,ax ; + col_idx
    mov ax, bx
    add ax, si ; adresata na elementot e vo ax 
    
    push ax
    push [bx][si]

    mov ax,0d
    mov si, di
    
    mov al,cl
    mul ROW_SIZE ;; * row size
    add si,ax ; + col_idx
    
    pop ax ;; vrednosta na prviot element
    push [bx][si] 
    
    mov [bx][si], al ; postavi ja zacuvanata vrednost od vtoriot red vo prviot
    
    pop ax
    pop bx; addr na prviot element
    
    mov [bx],al
    
    
    inc di
    jmp swap
    
    end_swap:
    
    
    
    
    
    
    
    
    
    

    ; add your code here
    
ends

end start ; set entry point and stop the assembler.

stack segment
    dw   128  dup(0)
ends

code segment
start:

    mov ax,11110000b
    push ax
    cmp ax,00001111b
    pushf   
    mov ah, 1
    int 21h
    pop bx
    mov ax, 4c00h
    int 21h   
ends

end start
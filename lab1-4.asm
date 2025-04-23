stack segment
    dw   128  dup(0)
ends

code segment
start:

    mov ax,11110000b
    push ax ; se dodava vrednosta na ax vo stekot
    cmp ax,00001111b
    pushf; se dodava flag registerot vo stekot   
    mov ah, 1
    int 21h ; odnovo se dodava flag registerot kako i adresata na code segmentot i instruction pointer
    ;; koga ke se vnesi cifrata se pravi pop na site ip,cs,i flag register
    pop bx ;  ke se izvadi flag register i ke se postavi vo bx
    mov ax, 4c00h
    int 21h; tuka na kraj vo stekot ke ima flag register, cs, ip   
ends

end start
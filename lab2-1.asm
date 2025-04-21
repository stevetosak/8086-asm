; multi-segment executable file template.
name 'lab1-4'

data segment
    ; add your data here!
    pkey db "press any key...$" 
    a db 10d
    b db 25d
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
    
    
    cmp a, 3d
    jb lt3
    cmp b, 3d
    jbe lt3
    jmp gte3 
    
    lt3:
    mov ah, 0x2
    mov dl, 1
    add dl,'0'
    int 21h
    jmp endcmp
    
    gte3:
    mov ah, a
    mov al, b
    cmp ah,al
    jb a_smaller
    mov ah, 0x2
    mov dl, 2
    add dl,'0'
    int 21h
    jmp endcmp
    
    
    a_smaller:
    mov ah, 0x2
    mov dl, 3
    add dl,'0'
    int 21h
    jmp endcmp
    
    
    endcmp:

    
    ;mov ax, 4c00h ; exit to operating system.
    ;int 21h    
ends

end start ; set entry point and stop the assembler.

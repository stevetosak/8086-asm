; multi-segment executable file template.

data segment
    ; add your data here!
    pkey db "press any key...$"     
    broj dw 0d
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
     ;;idejata e da se sostavi brojot po cifri: primer za 234 = 200 + 30 + 4 
     ;;kodot go pravi ova: (2 * 100) + (3*10) + (4 * 1) 
                   
    
    mov bx, 100d
    
    read:
    
    mov ah,0x1
    int 21h
    mov ah,0
    
    sub al,'0' ; se dobiva vrednosta na brojot bidejki tuka e kako ascii karakter vnesen
    mul bx   ;; 
   
    add broj,ax
    
    mov ax, bx
    mov cx, 10
    div cx        ; se deli bx so 10 dodeka ne e nula
    mov bx, ax 
    
    mov ah,0
    mov bx,ax
    mov ax, 0
    cmp bx, 0
    jne read
    
    
    mov ah,0x2
    mov dx, broj
    int 21h    
    
    
    mov ax, 4c00h ; exit to operating system.
    int 21h    
ends

end start ; set entry point and stop the assembler.

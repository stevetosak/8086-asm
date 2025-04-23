; multi-segment executable file template.

data segment
    ; add your data here!
    pkey db "press any key...$"
    o1 dw 3d
    o2 dw 4d
    o3 dw 5d
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
    
    mov ax, o1
    add ax, o2
    add ax, o3
   
    mov cx, 3
    div cx
    
    mov dl,al
    add dl,'0'
    
    mov ah,02h
    int 21h
    
      
    
    mov ax, 4c00h ; exit to operating system.
    int 21h    
ends

end start ; set entry point and stop the assembler.

; multi-segment executable file template.

data segment
    ; add your data here!
    pkey db "press any key...$"
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
    
                
    mov ah, 01h
    int 21h
    mov bx, 100h
    mov [BX], al ; registerski-indirekten rezim
    
    mov si, 1h
    add al, 1h
    
    mov [BX][SI], al ; bazen i indeksen rezim
    add al,1h
    
    mov DS:[102h], al ; direkten adresen rezim 
    add al, 1h
    
    mov [bx + si + 2h],al ; bazen i indeksen rezim so pomestuvanje
       
    
    ;;;;;;;;;;;;;
   
            
    lea dx, pkey
    mov ah, 9
    int 21h        ; output string at ds:dx
    
    ; wait for any key....    
    mov ah, 1
    int 21h
    
    mov ax, 4c00h ; exit to operating system.
    int 21h    
ends

end start ; set entry point and stop the assembler.

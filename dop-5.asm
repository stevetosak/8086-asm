include 'emu8086.inc'
name "dop-5"
data segment
    ; add your data here!                    
    pkey db "press any key...$"
    mtx dw 1,3,4,2,5,7,8,4,3,12,19,6 ;; 74
    S dw 50 dup(0)
    
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
    
    mov si,0d ; row idx
    mov di,0d ; col idx 
    mov cx,0d  ; sum
                  
    
    
    sum_rows:
    cmp si,3d
    ja end_sum_rows 
    
    lea bx,mtx
    push di
    mov di,0d
    cols:
    mov ax,3d
    mul si ; row_size(3) * row_idx
    
    
    push di
    add di,ax
    shl di,1 ; * elem_size(2)
    
    add cx,[bx][di]
    pop di
    inc di
    cmp di,3
    jb cols
    
    inc si
    pop di
    lea bx,S
    push di
    shl di,1
    mov [bx + di],cx
    pop di
    inc di
    mov cx,0d
    jmp sum_rows
    
     
    end_sum_rows:
    
    mov si,0d
    lea bx,S
    
    print_sums:
    cmp si,3
    ja end_print_nums
    
    push si
    shl si,1
    mov ax,[bx][si]
    pop si
    call PRINT_NUM
    printn
    inc si
    jmp print_sums 
    
    
    
    end_print_nums:
   
    
    
    
    DEFINE_SCAN_NUM
    DEFINE_PRINT_STRING
    DEFINE_PRINT_NUM
    DEFINE_PRINT_NUM_UNS  ; required for print_num.
    DEFINE_PTHIS
    
     
   
ends

end start ; set entry point and stop the assembler.

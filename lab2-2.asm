; multi-segment executable file template.

data segment
; add your data here!
arr db 20 dup(?)
tr_arr db 20 dup(?)
tr_idx dw 0d
ends

stack segment
dw   128  dup(0)
ends

code segment

;; proveruva dali karakterot smesten vo ah e broj ili bukva, i vo istiot (ah) go postavuva rezultatot.
;; 1 ako e broj, 0 ako e bukva i 2 ako ne e nitu broj ni bukva.
is_alphanumeric PROC
    cmp ah,'0' ;
    jb not_num
    cmp ah, '9'
    ja not_num


    mov ah, 1
    ret


    not_num:
    ;; proveri dali e bukva
    cmp ah, 'A'
    jb false

    cmp ah, 'Z'
    jbe true

    cmp ah,'a'
    jb false

    cmp ah,'z'
    jbe true

    jmp false

    false:
    mov ah,2
    ret


    true:
    mov ah,0
    ret



is_alphanumeric ENDP



start:
; set segment registers:
    mov ax, data
    mov ds, ax
    mov es, ax

    lea bx,arr
    mov si,0d
    
    read_input:
    cmp si, 20d
    jae end_read
    
    mov ah, 1h
    int 21h
    
    cmp al, '.'
    je end_read
    
    
    ; vo al e karakterot
    mov [bx][si],al
    inc si
    jmp read_input
    
    
    end_read:
    
    mov si,0d
    
    transform_arr:
    
    
    ;; if (si>= 20 or al == '.') then: go to end
    cmp si,20d
    jae end_transform_arr
    mov al, [bx][si]
    cmp al, '.'
    je end_transform_arr
    
    ;; postavi go argumentot vo ah za procedurata
    mov ah,al
    call is_alphanumeric
    
    cmp ah, 1
    je num
    cmp ah,0
    je char
    mov cl,2 ;; ako ne e broj ili bukva, ne pravi nisto
    jmp incr
    
    ;; ako e broj, klaj go cl 1 i prodolzi odnovo so izminuvanje
    num:
    mov cl, 1
    jmp incr
    
    char: ;;ako e karakter proveri dali prethodniot bil broj, odnosno dali cl == 1
    
    cmp cl,1
    jne incr
    
    ;; ako prethodniot element bil broj,zacuvaj go karakterot vo novata niza i postavi go cl na 0
    
    ;; bidejki bx i si gi koristevme za nizata sto ja vcitavme,
    ;; privremeno gi postavuvame na stek za da ja vcitame novata niza, potoa
    ;; pravime pop za da gi vratime originalnite vrednosti.
    
    push bx
    push si
    
    mov si, [tr_idx]
    lea bx,tr_arr
    mov [bx][si], al
    
    pop si
    pop bx
    inc tr_idx ; promenlivata tr_idx ja koristime za izminuvanje na transformiranata niza.
    mov cl,0
    
    incr:
    inc si
    jmp transform_arr
    
    
    end_transform_arr:
    ;; pecatenje string, na poslednata pozicija od tr_arr,postavuvame terminator '$'
    mov ah,0x9
    lea bx,tr_arr
    mov si,[tr_idx] ;; tr_index se inkrementira i posledniot pat koga se zacuvuva karakter,
    ;; sto znaci deka tuka negovata vrednost ke e ednakva na
    ;; pozicijata posle posledniot znak vo nizata (prazen element>
    mov [bx][si], '$'
    mov dx,bx
    int 21h
    
    ends
    
end start ; set entry point and stop the assembler.




; [SOURCE]: C:\emu8086\MySource\lab2-2.asm
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           
;внешняя процедура вывода двоичного числа
;которое находится в регистре AX на экран
public disp
Dseg segment para public 'data'
tab db 6 dup(?)
Dseg ends
Code segment para public 'code'
        assume cs:code,ds:dseg
Disp    proc near
        push bx
        push si
        push cx
        push ax
Maska equ 00110000B
        mov si,0
        mov bx,10
        mov cx,0
        cmp ax,0
        jge metka
        mov tab[si],'-'
        inc si
        neg ax
metka:  cwd
        div bx
        or dl,maska
        mov tab[si],dl
        inc cx
        inc si
        cmp ax,0
        jne metka
        dec si
        pop ax
        cmp ax,0
        jge metka1
        mov dl,tab
        mov ax,200h
        int 21h
metka1: mov dl,tab[si]
        mov ax,200h
        int 21h
        dec si
        loop metka1
        pop cx
        pop si
        pop bx
        ret
disp endp
Code ends
end

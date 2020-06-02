      public vvod
dseg  segment para public 'data'
mes   db 'Переполнение'
mes1  db '',10,13,'$'
mes2  db 'Ошибка ввода',10,13,'$'
dseg  ends
cseg  segment para public 'code'
      assume cs:cseg,ds:dseg
vvod  proc near
      mov ax,dseg
      mov ds,ax
      push ax
      push cx
      push dx
      push si
      push di
      push bp
      maska=00001111b
      mov bx,0
      mov cx,10
      mov si,0
      mov di,1
      mov bp,1
met4: mov ax,0800h
      int 21h
      cmp al,0dh
      je met1
      cmp si,0
      jne met2
      cmp al,2dh
      jne met3
      mov dl,2dh
      mov di,0
met6: mov ax,0200h
      int 21h
      mov si,1
      mov bp,0
      jmp met4
met3: cmp al,2bh
      jne met2
      mov dl,2bh
      jmp met6
met2: cmp al,30h
      jae met5
met7: mov dl,07h
      mov ax,0200h
      int 21h
      jmp met4
met5: cmp al,39h
      ja met7
      mov dl,al
      mov ax,0200h
      int 21h
      mov bp,1
      mov si,1
      and al,maska
      cbw
      push ax
      mov ax,bx
      cwd
      imul cx
      jo met11
      mov bx,ax
      pop ax
      cmp di,1
      je met9
      neg ax
met9: add bx,ax
      jno met4
met11:lea dx,mes1
      mov ax,0900h
      int 21h
      lea dx,mes
      mov ax,0900h
      int 21h
      jmp stop
met1: cmp bp,1
      je met10
      lea dx,mes1
      mov ax,0900h
      int 21h
      lea dx,mes2
      mov ax,0900h
      int 21h
      jmp stop
met10:lea dx,mes1
      mov ax,0900h
      int 21h
stop: pop bp
      pop di
      pop si
      pop dx
      pop cx
      pop ax
      ret
vvod  endp
cseg  ends
      end






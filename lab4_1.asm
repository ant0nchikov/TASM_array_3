extrn vvod:near,disp:near 
Dseg segment para public 'data'    
mas db 10 dup (?)    
count db ?     
mes1 db 'Enter the dimension of the array: $'    
mes2 db 'mas[$'    
mes3 db ']=$'    
mes4 db 'First vector: $'    
mes5 db 10,13,'$'   
mes6 db ' $'        
mes7 db 'Received Vector: $'    
n dw ? 
Dseg ends 
Sseg segment  para stack 'stack'    
db 30 dup(0) 
Sseg ends 
Cseg segment para public 'code' 
osn proc near    
assume cs:cseg,ds:dseg,ss:sseg    
mov ax,dseg    
mov ds,ax
mov ax,0002h    
int 10h    
lea dx,mes1    
mov ax,0900h    
int 21h    
call vvod    
mov n,bx    
mov cx,n         
mov si,0 

zikl1:lea dx,mes2   
mov ax,0900h    
int 21h    
mov ax,si    
call disp    
lea dx,mes3    
mov ax,0900h    
int 21h    
call vvod    
mov mas[si],bl     
inc si    
loop zikl1
  
lea dx,mes4   
mov ax,0900h    
int 21h    
lea dx,mes5  
mov ax,0900h    
int 21h    
mov cx,n    
mov si,0 
zikl2:mov al, mas[si]    
cbw    
call disp    
lea dx,mes6    
mov ax,0900h    
int 21h    
inc si    
loop zikl2 
mov cx,n
mov si,0    
mov al,mas    
mov di,0
mov bl,0
	

start:    
	mov al,mas[di]
	cmp al,3
    jl met            
	cmp al,7      
	jg met        
	add bl,1   
met:inc di
	loop start 

mov count,bl
	
cmp count,3
jge met2
jmp exit

met2:
 mov cx,n 
 Cikl2: push cx    
 mov cx, n    
 dec cx
 mov di,0
 mov si,0   ;si=j 
 cikl1: mov di,si    
 inc di   ;di=j+1    
 mov al, mas[si]    
 mov bl, mas[di]    
 cmp al,bl    
 jle met1    
 mov mas[si],bl    
 mov mas[di],al 
 met1: 
 inc si    
 loop cikl1    
 pop cx    
 loop cikl2
 jmp exit

exit:  
lea dx,mes5  
mov ax,0900h    
int 21h    
mov cx,n    
mov si,0 
zikl4:      
mov al, mas[si]    
cbw    
call disp    
lea dx,mes6  
mov ax,0900h    
int 21h    
inc si    
loop zikl4
cbw    
mov ax,4c00h    
int 21h 
osn endp 
Cseg ends 
end  osn 
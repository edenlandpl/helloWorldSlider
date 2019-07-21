format MZ
stack stk: 256
entry text: main

segment stk use16
        db 256 dup (?)

segment data_16 use16
x       db 'Hello World!'
dlugosc=$-x                             ; wartosc dlogosc ustawiana na aktualny offset, czyli po !
wart=0
p       db '????? ??????',0dh,0ah,'$'

segment text use16
main:
        mov ax, data_16                 ;
        mov ds,ax
        
        mov bx,x                        ; przesun wartosc offsetu zmiennej x do bx
        mov bp, p                       ; to samo dla p

        mov cx, wart                    ; wielkosc zmiennej wart okresla ilosc iteracji petli petla1, jak cx=0 to koniec petli
petla1: push cx                         ; zapamietaj wartosc cx dla petli petla1
                


        mov cx,dlugosc                  ; nadaj wielkosc petli / ilosc iteracji dla petli petla
                                        ; petla kopiujaca tekst Hello world! do p w miejsce ???
petla:  mov al,[ds:bx]                  ; przesun wartosc z adresu bx czyli x do al
        mov [ds:bp],al                  ; przesun wartosc z adresu al do bp, w dwoch krokach, poniewaz nie mozna bezposrednio z bx do bp
        inc bx                          ; inkrementacja bx
        inc bp                          ; inkrementacja bp
        loop petla                      ; wykonuj petle dopoki cx rozne od 0



        pop cx                          ; oddaj wartosc cx ze stosu, polozona wczesniej push'em
        loop petla1p                    ; wykonuj petle dopoki cx rozne od 0
        jmp opu1                         ; skocz do opu, zabezpieczenie loop przed dlugimi skokami powyzej -127/ 128

petla1p:jmp petla1                      ; cd zabezpieczenia
opu1:                                   ; cd zabezpieczenia

        ;mov al,[ds:bx]
        ;mov [ds:bp],al
        ;inc bx
        ;inc bp 

        
        
        mov ax,900h                     ; wyswietlanie na ekranie
        mov dx,x
        int 21h

        mov ax, 4c00h
        int 21h
        ret
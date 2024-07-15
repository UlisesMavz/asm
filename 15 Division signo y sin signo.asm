    .model    small                ; Define el modelo de memoria como 'small'
    .stack    ; Define el tamaño del segmento de pila

    .data     ; Comienza el segmento de datos
    byte1     db 80h            ; Define un byte 'byte1' con valor 80h
    byte2     db 16h            ; Define un byte 'byte2' con valor 16h
    word1     dw 2000h          ; Define una palabra 'word1' con valor 2000h
    word2     dw 0010h          ; Define una palabra 'word2' con valor 0010h
    word3     dw 1000h          ; Define una palabra 'word3' con valor 1000h

    .code     ; Comienza el segmento de código
    begin:
    ;         Etiqueta que marca el inicio del programa
    mov       ax,@data            ; Mueve la dirección del segmento de datos a AX
    mov       ds,ax               ; Asigna la dirección del segmento de datos a DS

    call      ddiv               ; Llama a la subrutina ddiv para realizar divisiones
    call      iidiv              ; Llama a la subrutina iidiv para realizar divisiones

    mov       ax,4c00h            ; Prepara la función DOS 4Ch para terminar el programa
    int       21h                 ; Llama a la interrupción DOS para finalizar el programa

    ;         Subrutina ddiv: Ejemplos de divisiones

    ddiv      proc                   ; Inicio de la subrutina ddiv
    mov       ax,word1            ; Carga word1 en AX
    div       byte1               ; Divide AX entre byte1

    mov       al,byte1            ; Carga byte1 en AL
    sub       ah,ah               ; Limpia AH (ah = 0)
    div       byte2               ; Divide AX (considerando AL) entre byte2

    mov       dx,word2            ; Carga word2 en DX
    mov       ax,word3            ; Carga word3 en AX
    div       word1               ; Divide DX:AX entre word1

    mov       ax,word1            ; Carga word1 en AX
    sub       dx,dx               ; Limpia DX (dx = 0)
    div       word3               ; Divide DX:AX entre word3 (residuo en DX, cociente en AX)

    ret       ; Retorna de la subrutina ddiv
    ddiv      endp                   ; Fin de la subrutina ddiv

    ;         Subrutina iidiv: Ejemplos de divisiones con signo

    iidiv     proc                  ; Inicio de la subrutina iidiv
    mov       ax,word1            ; Carga word1 en AX
    idiv      byte1              ; Divide AX entre byte1 (considerando signo)

    mov       al,byte1            ; Carga byte1 en AL
    cbw       ; Convierte byte a palabra en AX (para considerar signo)
    idiv      byte2              ; Divide AX (considerando signo) entre byte2

    mov       dx,word2            ; Carga word2 en DX
    mov       ax,word3            ; Carga word3 en AX
    idiv      word1              ; Divide DX:AX entre word1 (considerando signo)

    mov       ax,word1            ; Carga word1 en AX
    cwd       ; Convierte word a doble palabra en DX:AX (para considerar signo)
    idiv      word3              ; Divide DX:AX entre word3 (considerando signo)

    ret       ; Retorna de la subrutina iidiv
    iidiv     endp                  ; Fin de la subrutina iidiv

    end       begin                   ; Fin del programa

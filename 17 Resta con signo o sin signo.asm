    .model    small               ; Define el modelo de memoria como 'small'
    .stack    ; Define el tamaño del segmento de pila

    .data     ; Comienza el segmento de datos
    byte1     db 80h           ; Define un byte 'byte1' con valor 80h
    byte2     db 16h           ; Define un byte 'byte2' con valor 16h
    word1     dw 2000h         ; Define una palabra 'word1' con valor 2000h
    word2     dw 0010h         ; Define una palabra 'word2' con valor 0010h
    word3     dw 1000h         ; Define una palabra 'word3' con valor 1000h

    .code     ; Comienza el segmento de código
    begin:
    ;         Etiqueta que marca el inicio del programa
    mov       ax, @data          ; Mueve la dirección del segmento de datos a AX
    mov       ds, ax             ; Asigna la dirección del segmento de datos a DS

    ;         Llama a las subrutinas para realizar las operaciones de resta
    call      restaSinSigno
    call      restaConSigno

    mov       ax, 4c00h          ; Prepara la función DOS 4Ch para terminar el programa
    int       21h                ; Llama a la interrupción DOS para finalizar el programa

    ;         Subrutina para restar sin signo
    restaSinSigno proc          ; Inicio de la subrutina restaSinSigno
    mov       ax, word1          ; Carga word1 en AX
    sub       ax, word2          ; Resta word2 de AX (sin considerar el signo)

    mov       dx, word2          ; Carga word2 en DX
    sub       ax, dx             ; Resta DX de AX (sin considerar el signo)

    mov       ax, word3          ; Carga word3 en AX
    sub       ax, word1          ; Resta word1 de AX (sin considerar el signo)

    ret       ; Retorna de la subrutina restaSinSigno
    restaSinSigno endp          ; Fin de la subrutina restaSinSigno

    ;         Subrutina para restar con signo
    restaConSigno proc          ; Inicio de la subrutina restaConSigno
    mov       ax, word1          ; Carga word1 en AX
    sub       ax, byte1          ; Resta byte1 de AX (considerando el signo)

    mov       al, byte1          ; Carga byte1 en AL
    cbw       ; Convierte byte a palabra en AX (para considerar signo)
    sub       ax, byte2          ; Resta byte2 de AX (considerando el signo)

    mov       ax, word2          ; Carga word2 en AX
    sub       ax, word3          ; Resta word3 de AX (considerando el signo)

    cwd       ; Convierte word a doble palabra en DX:AX (para considerar signo)
    sub       ax, word1          ; Resta word1 de AX (considerando el signo)

    ret       ; Retorna de la subrutina restaConSigno
    restaConSigno endp          ; Fin de la subrutina restaConSigno

    end       begin                 ; Fin del programa

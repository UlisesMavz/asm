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

    ;         Llama a las subrutinas para realizar las operaciones de multiplicación
    call      multiplicaSinSigno
    call      multiplicaConSigno

    mov       ax, 4c00h          ; Prepara la función DOS 4Ch para terminar el programa
    int       21h                ; Llama a la interrupción DOS para finalizar el programa

    ;         Subrutina para multiplicar sin signo
    multiplicaSinSigno proc     ; Inicio de la subrutina multiplicaSinSigno
    mov       ax, word1          ; Carga word1 en AX
    imul      ax, byte1         ; Multiplica AX por byte1 (sin considerar el signo)

    mov       ax, word2          ; Carga word2 en AX
    imul      ax, word3         ; Multiplica AX por word3 (sin considerar el signo)

    ret       ; Retorna de la subrutina multiplicaSinSigno
    multiplicaSinSigno endp     ; Fin de la subrutina multiplicaSinSigno

    ;         Subrutina para multiplicar con signo
    multiplicaConSigno proc     ; Inicio de la subrutina multiplicaConSigno
    mov       ax, word1          ; Carga word1 en AX
    imul      ax, byte1         ; Multiplica AX por byte1 (considerando el signo)

    mov       ax, word2          ; Carga word2 en AX
    imul      ax, word3         ; Multiplica AX por word3 (considerando el signo)

    ret       ; Retorna de la subrutina multiplicaConSigno
    multiplicaConSigno endp     ; Fin de la subrutina multiplicaConSigno

    end       begin                 ; Fin del programa

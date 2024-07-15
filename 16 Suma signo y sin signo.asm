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

    ;         Llama a las subrutinas para realizar las operaciones de suma
    call      sumaSinSigno
    call      sumaConSigno

    mov       ax, 4c00h          ; Prepara la función DOS 4Ch para terminar el programa
    int       21h                ; Llama a la interrupción DOS para finalizar el programa

    ;         Subrutina para sumar sin signo
    sumaSinSigno proc          ; Inicio de la subrutina sumaSinSigno
    mov       ax, word1          ; Carga word1 en AX
    add       ax, word2          ; Suma word2 a AX (sin considerar el signo)

    mov       dx, word2          ; Carga word2 en DX
    add       ax, dx             ; Suma DX a AX (sin considerar el signo)

    mov       ax, word3          ; Carga word3 en AX
    add       ax, word1          ; Suma word1 a AX (sin considerar el signo)

    ret       ; Retorna de la subrutina sumaSinSigno
    sumaSinSigno endp          ; Fin de la subrutina sumaSinSigno

    ;         Subrutina para sumar con signo
    sumaConSigno proc          ; Inicio de la subrutina sumaConSigno
    mov       ax, word1          ; Carga word1 en AX
    add       ax, byte1          ; Suma byte1 a AX (considerando el signo)

    mov       al, byte1          ; Carga byte1 en AL
    cbw       ; Convierte byte a palabra en AX (para considerar signo)
    add       ax, byte2          ; Suma byte2 a AX (considerando el signo)

    mov       ax, word2          ; Carga word2 en AX
    add       ax, word3          ; Suma word3 a AX (considerando el signo)

    cwd       ; Convierte word a doble palabra en DX:AX (para considerar signo)
    add       ax, word1          ; Suma word1 a AX (considerando el signo)

    ret       ; Retorna de la subrutina sumaConSigno
    sumaConSigno endp          ; Fin de la subrutina sumaConSigno

    end       begin                 ; Fin del programa

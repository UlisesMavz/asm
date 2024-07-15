    mi        MACRO                  ; Define una macro llamada 'mi'
    mov       ax,data           ; Mueve la dirección de inicio del segmento de datos al registro AX
    mov       ds,ax             ; Mueve la dirección del segmento de datos (desde AX) al registro DS
    ENDM      ; Fin de la definición de la macro

    .model    small              ; Define el modelo de memoria como 'small'
    .stack    ; Define el segmento de pila

    .data     ; Comienza el segmento de datos
    mensaje   db 'Probando una macro $' ; Define una cadena de texto con el mensaje

    .code     ; Comienza el segmento de código
    begin:
    ;         Punto de entrada del programa
    mi        ; Llama a la macro 'mi' que inicializa el segmento de datos

    mov       dx,offset mensaje ; Mueve la dirección del mensaje al registro DX
    mov       ah,09             ; Función DOS 09h para imprimir una cadena de caracteres
    int       21h               ; Llama a la interrupción DOS para imprimir la cadena

    mov       ah,4ch            ; Función DOS 4Ch para terminar el programa
    int       21h               ; Llama a la interrupción DOS para finalizar el programa
    end       begin                 ; Marca el final del programa



    ;-----------------------------------------------------------


    limpiant  MACRO            ; Define una macro llamada 'limpiant'
    mov       ah,0fh            ; Mueve 0fh al registro AH para obtener el modo de video actual
    int       10h               ; Llama a la interrupción BIOS 10h para obtener el modo de video actual

    mov       ah,0              ; Mueve 0 al registro AH para establecer el modo de video
    int       10h               ; Llama a la interrupción BIOS 10h para establecer el modo de video
    ENDM      ; Fin de la definición de la macro

    mi        MACRO                  ; Define una macro llamada 'mi'
    mov       ax,data           ; Mueve la dirección de inicio del segmento de datos al registro AX
    mov       ds,ax             ; Mueve la dirección del segmento de datos (desde AX) al registro DS
    ENDM      ; Fin de la definición de la macro

    dv        MACRO                  ; Define una macro llamada 'dv'
    mov       ah,4ch            ; Mueve 4ch al registro AH para terminar el programa
    int       21h               ; Llama a la interrupción DOS 21h para finalizar el programa
    ENDM      ; Fin de la definición de la macro

    .model    small              ; Define el modelo de memoria como 'small'
    .stack    ; Define el segmento de pila

    .data     ; Comienza el segmento de datos
    mensaje   db 'Probando una macro $' ; Define una cadena de texto con el mensaje

    .code     ; Comienza el segmento de código
    begin:
    ;         Punto de entrada del programa
    mi        ; Llama a la macro 'mi' que inicializa el segmento de datos

    mov       dx,offset mensaje ; Mueve la dirección del mensaje al registro DX
    mov       ah,09             ; Función DOS 09h para imprimir una cadena de caracteres
    int       21h               ; Llama a la interrupción DOS para imprimir la cadena

    limpiant  ; Llama a la macro 'limpiant' que establece el modo de video

    dv        ; Llama a la macro 'dv' que termina el programa
    end       begin                 ; Marca el final del programa


    ;------------------------------------------------------

    .model    small              ; Define el modelo de memoria como 'small' (modelo de memoria)
    .stack    ; Define el tamaño del segmento de pila (modelo de pila)

    .data     ; Comienza el segmento de datos
    mensaje   db 'Mi nombre es:Ulises',13,10 ; Define una cadena de texto con salto de línea
    db        'y al reves es: $'       ; Termina la cadena con salto de línea y fin de cadena
    tabla     db 'ulises'                    ; Define una tabla de caracteres 'ulises'

    .code     ; Comienza el segmento de código
    begin:
    ;         Etiqueta que marca el inicio del programa

    mov       ax,data           ; Mueve la dirección de inicio del segmento de datos al registro AX
    mov       ds,ax             ; Mueve la dirección del segmento de datos (desde AX) al registro DS

    mov       dx,offset mensaje ; Mueve la dirección de la cadena 'mensaje' al registro DX
    mov       ah,9              ; Función DOS 09h para imprimir una cadena de caracteres
    int       21h               ; Llama a la interrupción DOS para imprimir la cadena

    mov       bx,offset tabla-1 ; Mueve la dirección de la tabla 'tabla' menos 1 al registro BX
    ;         (para ajustar el índice inicial a 0)
    mov       cx,6             ; Inicializa CX con 6(número de caracteres a imprimir)

    print:
    ;         Etiqueta del inicio del bucle 'print'
    mov       al,cl             ; Mueve el valor de CL (0-3) al registro AL
    XLAT      ; Traduce el valor en AL utilizando la tabla de caracteres 'tabla'

    mov       dl,al             ; Mueve el carácter traducido a DL
    mov       ah,02h            ; Función DOS 02h para imprimir un carácter en pantalla
    int       21h               ; Llama a la interrupción DOS para imprimir el carácter

    loop      print            ; Salta de nuevo a 'print' mientras CX no sea cero

    mov       ax,4c00h          ; Prepara la función DOS 4Ch para terminar el programa
    int       21h               ; Llama a la interrupción DOS para finalizar el programa

    end       begin                ; Marca el final del programa

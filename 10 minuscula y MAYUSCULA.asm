    .model    small             ; Define el modelo de memoria como 'small'
    .stack    ; Define el segmento de pila

    .data     ; Comienza el segmento de datos
    NOMBRE    db ,13,10,'Mi nombre en minusculas es:$'  ; Define una cadena de texto con salto de línea
    Mayus1    db 'ULISES'                                 ; Define una cadena de texto 'ULISES'
    NOMBRE2   db ,13,10,'Mi nombre en mayusculas es: $' ; Define una cadena de texto con salto de línea
    Minus1    db 'ulises$'                                ; Define una cadena de texto 'ulises$'
    MAYUS     db 'ulises'                                 ; Define una cadena de texto 'ulises'
    MINUS     db 'ULISES'                                 ; Define una cadena de texto 'ULISES'

    .code     ; Comienza el segmento de código
    inicio    proc far          ; Define el procedimiento 'inicio' como un procedimiento 'far'

    mov       ax,@data        ; Mueve la dirección de inicio del segmento de datos al registro AX
    mov       ds,ax           ; Mueve la dirección del segmento de datos (desde AX) al registro DS

    mov       dx,offset NOMBRE ; Mueve la dirección de la cadena 'NOMBRE' al registro DX
    mov       ah,9            ; Función DOS 09h para imprimir una cadena de caracteres
    int       21h             ; Llama a la interrupción DOS para imprimir la cadena

    mov       dx,offset Minus1 ; Mueve la dirección de la cadena 'Minus1' al registro DX
    mov       ah,9            ; Función DOS 09h para imprimir una cadena de caracteres
    int       21h             ; Llama a la interrupción DOS para imprimir la cadena

    mov       dx,offset NOMBRE2 ; Mueve la dirección de la cadena 'NOMBRE2' al registro DX
    mov       ah,9            ; Función DOS 09h para imprimir una cadena de caracteres
    int       21h             ; Llama a la interrupción DOS para imprimir la cadena

    lea       bx,MAYUS        ; Carga la dirección de 'MAYUS' en el registro BX
    mov       cx,6            ; Inicializa el contador del bucle CX con 6
    repite:
    ;         Etiqueta del inicio del bucle
    mov       ah,[bx]         ; Mueve el carácter apuntado por BX al registro AH
    and       ah,11011111b    ; Convierte el carácter en mayúscula (AND con 0xDF)

    mov       dl,ah           ; Mueve el carácter convertido al registro DL
    mov       ah,02h          ; Función DOS 02h para imprimir el carácter en DL
    int       21h             ; Llama a la interrupción DOS para imprimir el carácter

    inc       bx              ; Incrementa BX para apuntar al siguiente carácter
    loop      repite              ; Decrementa CX y si no es cero, salta a la etiqueta 'repite'

    mov       dx,offset NOMBRE2 ; Mueve la dirección de la cadena 'NOMBRE2' al registro DX
    mov       ah,9            ; Función DOS 09h para imprimir una cadena de caracteres
    int       21h             ; Llama a la interrupción DOS para imprimir la cadena

    mov       dx,offset Mayus1 ; Mueve la dirección de la cadena 'Mayus1' al registro DX
    mov       ah,9            ; Función DOS 09h para imprimir una cadena de caracteres
    int       21h             ; Llama a la interrupción DOS para imprimir la cadena

    lea       bx,MINUS        ; Carga la dirección de 'MINUS' en el registro BX
    mov       cx,6            ; Inicializa el contador del bucle CX con 6
    repite2:
    ;         Etiqueta del inicio del bucle
    mov       ah,[bx]         ; Mueve el carácter apuntado por BX al registro AH
    or        ah,00100000b     ; Convierte el carácter en minúscula (OR con 0x20)

    mov       dl,ah           ; Mueve el carácter convertido al registro DL
    mov       ah,02h          ; Función DOS 02h para imprimir el carácter en DL
    int       21h             ; Llama a la interrupción DOS para imprimir el carácter

    inc       bx              ; Incrementa BX para apuntar al siguiente carácter
    loop      repite2             ; Decrementa CX y si no es cero, salta a la etiqueta 'repite2'

    mov       ah,4ch          ; Función DOS 4Ch para terminar el programa
    int       21h             ; Llama a la interrupción DOS para finalizar el programa
    end       inicio               ; Marca el final del procedimiento 'inicio'





    .model    small             ; Define el modelo de memoria como 'small'
    .stack    ; Define el segmento de pila

    .data     ; Comienza el segmento de datos
    NOMBRE    db ,13,10,'Mi nombre en minusculas es ulises y en mayusculas es: $' ; Define una cadena de texto con salto de línea
    NOMBRE2   db ,13,10,'Mi nombre en mayusculas es JOAN y en minusculas es: $' ; Define una cadena de texto con salto de línea
    MAYUS     db 'ulises'   ; Define una cadena de texto 'ulises'
    MINUS     db 'ULISES'   ; Define una cadena de texto 'ULISES'

    .code     ; Comienza el segmento de código
    inicio    proc far          ; Define el procedimiento 'inicio' como un procedimiento 'far'

    mov       ax,@data        ; Mueve la dirección de inicio del segmento de datos al registro AX
    mov       ds,ax           ; Mueve la dirección del segmento de datos (desde AX) al registro DS

    mov       dx,offset NOMBRE ; Mueve la dirección de la cadena 'NOMBRE' al registro DX
    mov       ah,9            ; Función DOS 09h para imprimir una cadena de caracteres
    int       21h             ; Llama a la interrupción DOS para imprimir la cadena

    lea       bx,MAYUS        ; Carga la dirección de 'MAYUS' en el registro BX
    mov       cx,6            ; Inicializa el contador del bucle CX con 6
    repite:
    ;         Etiqueta del inicio del bucle
    mov       ah,[bx]         ; Mueve el carácter apuntado por BX al registro AH
    ;and      ah,11011111    ; Convierte el carácter en mayúscula (AND con 0xDF) (comentado)
    sub       ah,32d          ; Convierte el carácter en mayúscula (resta 32 en decimal)

    mov       dl,ah           ; Mueve el carácter convertido al registro DL
    mov       ah,02h          ; Función DOS 02h para imprimir el carácter en DL
    int       21h             ; Llama a la interrupción DOS para imprimir el carácter

    inc       bx              ; Incrementa BX para apuntar al siguiente carácter
    loop      repite              ; Decrementa CX y si no es cero, salta a la etiqueta 'repite'

    mov       ah,02h          ; Función DOS 02h para posicionar el cursor
    mov       dh,02           ; Establece la fila del cursor
    mov       dl,01           ; Establece la columna del cursor
    mov       bh,0            ; Selecciona la página de la pantalla
    int       21h             ; Llama a la interrupción DOS para posicionar el cursor

    mov       dx,offset NOMBRE2 ; Mueve la dirección de la cadena 'NOMBRE2' al registro DX
    mov       ah,9            ; Función DOS 09h para imprimir una cadena de caracteres
    int       21h             ; Llama a la interrupción DOS para imprimir la cadena

    lea       bx,MINUS        ; Carga la dirección de 'MINUS' en el registro BX
    mov       cx,6            ; Inicializa el contador del bucle CX con 6
    repite2:
    ;         Etiqueta del inicio del bucle
    mov       ah,[bx]         ; Mueve el carácter apuntado por BX al registro AH
    add       ah,32d          ; Convierte el carácter en minúscula (suma 32 en decimal)
    ;or       ah,00100000b    ; Convierte el carácter en minúscula (OR con 0x20) (comentado)

    mov       dl,ah           ; Mueve el carácter convertido al registro DL
    mov       ah,02h          ; Función DOS 02h para imprimir el carácter en DL
    int       21h             ; Llama a la interrupción DOS para imprimir el carácter

    inc       bx              ; Incrementa BX para apuntar al siguiente carácter
    loop      repite2             ; Decrementa CX y si no es cero, salta a la etiqueta 'repite2'

    mov       ah,4ch          ; Función DOS 4Ch para terminar el programa
    int       21h             ; Llama a la interrupción DOS para finalizar el programa
    end       inicio               ; Marca el final del procedimiento 'inicio'

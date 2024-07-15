    .model    small             ; Define el modelo de memoria como 'small'
    .stack    ; Define el segmento de pila

    .data     ; Comienza el segmento de datos
    mensaje   db 'La suma de 25 y 47 es:$' ; Define una cadena de texto terminada en '$' para imprimir con la función DOS 09h
    va        equ 25            ; Define la constante 'va' con el valor 25
    vb        equ 47            ; Define la constante 'vb' con el valor 47

    .code     ; Comienza el segmento de código
    begin     proc far           ; Define el procedimiento 'begin' como un procedimiento 'far'
    mov       ax, @data    ; Mueve la dirección de inicio del segmento de datos al registro AX
    mov       ds, ax       ; Mueve la dirección del segmento de datos (desde AX) al registro DS

    mov       dx, offset mensaje ; Mueve la dirección de la cadena 'mensaje' al registro DX
    mov       ah, 9        ; Función DOS 09h para imprimir una cadena de caracteres
    int       21h          ; Llama a la interrupción DOS para imprimir la cadena

    mov       al, va       ; Mueve el valor de 'va' (25) al registro AL
    add       al, vb       ; Suma el valor de 'vb' (47) al contenido del registro AL
    mov       ah, 0        ; Limpia el registro AH (lo pone a 0)
    aam       ; Ajusta AL y AH para representar el valor en AL en formato decimal ASCII
    add       ax, 3030h    ; Convierte los dígitos decimales en sus valores ASCII

    mov       dl, ah       ; Mueve el contenido de AH al registro DL (preparando para la salida)
    mov       ah, 2        ; Función DOS 02h para imprimir el carácter en DL
    push      ax          ; Guarda AX en la pila
    int       21h          ; Llama a la interrupción DOS para imprimir el carácter

    pop       ax           ; Recupera AX de la pila
    mov       dl, al       ; Mueve el contenido de AL (el dígito menos significativo) a DL
    int       21h          ; Llama a la interrupción DOS para imprimir el carácter

    mov       ah, 4ch      ; Función DOS 4Ch para terminar el programa
    int       21h          ; Llama a la interrupción DOS para finalizar el programa
    end       begin                ; Marca el final del procedimiento 'begin'

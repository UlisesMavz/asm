    pila      segment para stack 'stack'    ; Define el segmento 'pila' para la pila
    db        dup 32 (0)                  ; Reserva 32 bytes para la pila, inicializados a 0
    pila      ends                          ; Marca el final del segmento 'pila'

    datos     segment para 'data'          ; Define el segmento 'datos' para los datos
    va        equ 25                      ; Define la constante 'va' con el valor 25
    vb        equ 47                      ; Define la constante 'vb' con el valor 47
    datos     ends                         ; Marca el final del segmento 'datos'

    codigo    segment para 'code'         ; Define el segmento 'codigo' para el código
    begin     proc far
    assume    cs:codigo, ds:datos, ss:pila ; Asocia los segmentos 'codigo', 'datos' y 'pila' con CS, DS y SS respectivamente

    mov       ax, datos             ; Mueve la dirección de inicio del segmento 'datos' al registro AX
    mov       ds, ax                ; Mueve la dirección del segmento de datos (desde AX) al registro DS

    mov       al, va                ; Mueve el valor de 'va' (25) al registro AL
    add       al, vb                ; Suma el valor de 'vb' (47) al contenido del registro AL
    mov       ah, 0                 ; Limpia el registro AH (lo pone a 0)
    aam       ; Ajusta AL y AH para representar el valor en AL en formato decimal ASCII
    add       ax, 3030h             ; Convierte los dígitos decimales en sus valores ASCII

    mov       dl, ah                ; Mueve el contenido de AH al registro DL (preparando para la salida)
    mov       ah, 2                 ; Función DOS 02h para imprimir el carácter en DL
    push      ax                   ; Guarda AX en la pila
    int       21h                   ; Llama a la interrupción DOS para imprimir el carácter

    pop       ax                    ; Recupera AX de la pila
    mov       dl, al                ; Mueve el contenido de AL (el dígito menos significativo) a DL
    int       21h                   ; Llama a la interrupción DOS para imprimir el carácter

    mov       ah, 4ch               ; Función DOS 4Ch para terminar el programa
    int       21h                   ; Llama a la interrupción DOS para finalizar el programa
    begin     endp                    ; Marca el final del procedimiento 'begin'
    end       begin                         ; Marca el final del programa

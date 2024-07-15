    pila      segment para stack 'stack'  ; Define el segmento de pila llamado 'stack'
    db        dup 64 (0)               ; Reserva 64 bytes para la pila, inicializados en 0
    pila      ends                       ; Finaliza el segmento de pila

    datos     segment para 'data'       ; Define el segmento de datos llamado 'data'
    name1     db 'ABCDEFGHI'        ; Define una cadena de caracteres 'name1' con contenido 'ABCDEFGHI'
    name2     db 'JKLMNOPQR',13,10,'se cambia a',13,10,'$'  ; Define una cadena de caracteres 'name2' con múltiples líneas
    datos     ends                      ; Finaliza el segmento de datos

    codigo    segment para 'code'     ; Define el segmento de código llamado 'code'
    begin     proc far             ; Inicia el procedimiento 'begin' como far (segmento de código)

    assume    cs:codigo,ds:datos,ss:pila  ; Asigna los registros de segmento

    mov       ax,datos            ; Carga la dirección base del segmento de datos en AX
    mov       ds,ax               ; Asigna la dirección base del segmento de datos desde AX a DS

    LEA       SI,name1            ; Carga la dirección de memoria de 'name1' en SI
    LEA       DI,name2            ; Carga la dirección de memoria de 'name2' en DI
    mov       cx,9                ; Inicializa CX con 9 (número de caracteres a copiar)

    mov       dx,offset name2     ; Carga la dirección de 'name2' en DX para mostrar el mensaje
    mov       ah,9                ; Función DOS 09h para imprimir una cadena de caracteres
    int       21h                 ; Llama a la interrupción DOS para imprimir el mensaje

    inicia:
    ;         Etiqueta 'inicia' para copiar caracteres de name1 a name2
    mov       al,[SI]            ; Mueve el byte apuntado por SI (de name1) a AL
    mov       [DI],al            ; Mueve el contenido de AL a la posición apuntada por DI (en name2)

    mov       dl,[DI]            ; Mueve el contenido de la posición apuntada por DI (en name2) a DL

    mov       ah,02               ; Función DOS 02h para imprimir un carácter en pantalla
    int       21h                ; Llama a la interrupción DOS para imprimir el carácter

    inc       si                 ; Incrementa SI para apuntar al siguiente carácter de name1
    inc       di                 ; Incrementa DI para apuntar al siguiente carácter de name2
    dec       cx                 ; Decrementa CX para contar los caracteres copiados, salta si no es cero
    jnz       inicia             ; Salta a 'inicia' si CX no es cero

    mov       ah,4ch              ; Función DOS 4Ch para terminar el programa
    int       21h                ; Llama a la interrupción DOS para finalizar el programa

    begin     endp             ; Finaliza el procedimiento 'begin'
    codigo    ends                ; Finaliza el segmento de código 'code'
    end       begin                     ; Fin del programa


    ;--------------------

    .model    small               ; Define el modelo de memoria como 'small'
    .stack    ; Define el tamaño del segmento de pila

    .data     ; Comienza el segmento de datos
    name1     db 'maria'       ; Define una cadena de caracteres 'name1' con contenido 'maria'
    name2     db 'laura',13,10,'se cambia a',13,10,'$'  ; Define una cadena de caracteres 'name2' con múltiples líneas
    ;         incluyendo saltos de línea y fin de cadena ('$')

    .code     ; Comienza el segmento de código
    begin:
    ;         Etiqueta que marca el inicio del programa
    mov       ax,@data           ; Carga la dirección base del segmento de datos en AX
    mov       ds,ax              ; Asigna la dirección base del segmento de datos desde AX a DS

    LEA       SI,name1           ; Carga la dirección de memoria de 'name1' en SI
    LEA       DI,name2           ; Carga la dirección de memoria de 'name2' en DI
    mov       cx,5               ; Inicializa CX con 5 (número de caracteres a copiar)

    mov       dx,offset name2    ; Carga la dirección de 'name2' en DX para mostrar el mensaje
    mov       ah,9               ; Función DOS 09h para imprimir una cadena de caracteres
    int       21h                ; Llama a la interrupción DOS para imprimir el mensaje

    inicia:
    ;         Etiqueta 'inicia' para copiar caracteres de name1 a name2
    mov       al,[SI]            ; Mueve el byte apuntado por SI (de name1) a AL
    mov       [DI],al            ; Mueve el contenido de AL a la posición apuntada por DI (en name2)

    mov       dl,[DI]            ; Mueve el contenido de la posición apuntada por DI (en name2) a DL

    mov       ah,02              ; Función DOS 02h para imprimir un carácter en pantalla
    int       21h                ; Llama a la interrupción DOS para imprimir el carácter

    inc       si                 ; Incrementa SI para apuntar al siguiente carácter de name1
    inc       di                 ; Incrementa DI para apuntar al siguiente carácter de name2
    dec       cx                 ; Decrementa CX para contar los caracteres copiados, salta si no es cero
    jnz       inicia             ; Salta a 'inicia' si CX no es cero

    mov       ah,4ch              ; Función DOS 4Ch para terminar el programa
    int       21h                ; Llama a la interrupción DOS para finalizar el programa

    end       begin                 ; Fin del programa

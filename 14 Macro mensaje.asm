    ;subrutina

    INI       MACRO                    ; Macro que inicializa el segmento de datos
    mov       ax,data              ; Mueve la dirección del segmento de datos a AX
    mov       ds,ax                ; Asigna la dirección del segmento de datos desde AX a DS
    ENDM      ; Fin de la macro

    inicia    MACRO mensaje         ; Macro para mostrar un mensaje en pantalla
    lea       dx,mensaje           ; Carga la dirección del mensaje en DX
    mov       ah,09                ; Función DOS 09h para imprimir una cadena de caracteres
    int       21h                  ; Llama a la interrupción DOS para imprimir el mensaje
    ENDM      ; Fin de la macro

    .model    small                 ; Define el modelo de memoria como 'small'
    .stack    ; Define el tamaño del segmento de pila

    .data     ; Comienza el segmento de datos
    mensaje1  db 'Luis','$'        ; Define una cadena de texto 'Luis' terminada en '$'
    mensaje2  db 'Valles','$'      ; Define una cadena de texto 'Valles' terminada en '$'

    .code     ; Comienza el segmento de código
    begin:
    ;         Etiqueta que marca el inicio del programa

    INI       ; Llama a la macro INI para inicializar el segmento de datos
    inicia    mensaje1              ; Llama a la macro inicia para mostrar el mensaje1 en pantalla
    inicia    mensaje2              ; Llama a la macro inicia para mostrar el mensaje2 en pantalla

    mov       ax,4c00h             ; Prepara la función DOS 4Ch para terminar el programa
    int       21h                  ; Llama a la interrupción DOS para finalizar el programa

    end       begin                    ; Marca el final del programa

    ;-------------------

    ;subrutina

    INI       MACRO                    ; Macro que inicializa el segmento de datos
    mov       ax,data              ; Mueve la dirección del segmento de datos a AX
    mov       ds,ax                ; Asigna la dirección del segmento de datos desde AX a DS
    ENDM      ; Fin de la macro

    inicia    MACRO mensaje         ; Macro para mostrar un mensaje en pantalla
    lea       dx,mensaje           ; Carga la dirección del mensaje en DX
    mov       ah,09                ; Función DOS 09h para imprimir una cadena de caracteres
    int       21h                  ; Llama a la interrupción DOS para imprimir el mensaje
    ENDM      ; Fin de la macro

    .model    small                 ; Define el modelo de memoria como 'small' (modelo de memoria)
    .stack    ; Define el tamaño del segmento de pila (modelo de pila)
    .data     ; Comienza el segmento de datos (modelo de datos)

    mensaje1  db 'Como estas?',10,13,'$'        ; Define una cadena de texto con salto de línea y fin de cadena
    mensaje2  db 'Mi nombre es Ulises',10,13,'$'  ; Define una cadena de texto con salto de línea y fin de cadena
    mensaje3  db 'Que tengas un lindo dia',10,13,'$' ; Define una cadena de texto con salto de línea y fin de cadena
    mensaje4  db 'Toma agua',10,13,'$'          ; Define una cadena de texto con salto de línea y fin de cadena

    .code     ; Comienza el segmento de código
    begin:
    ;         Etiqueta que marca el inicio del programa

    INI       ; Llama a la macro INI para inicializar el segmento de datos
    inicia    mensaje1              ; Llama a la macro inicia para mostrar el mensaje1 en pantalla
    inicia    mensaje2              ; Llama a la macro inicia para mostrar el mensaje2 en pantalla
    inicia    mensaje3              ; Llama a la macro inicia para mostrar el mensaje3 en pantalla
    inicia    mensaje4              ; Llama a la macro inicia para mostrar el mensaje4 en pantalla

    mov       ax,4c00h             ; Prepara la función DOS 4Ch para terminar el programa
    int       21h                  ; Llama a la interrupción DOS para finalizar el programa

    end       begin                    ; Marca el final del programa

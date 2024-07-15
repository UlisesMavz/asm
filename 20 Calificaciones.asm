    org       100h               ; Indica que el origen del código es 100h, necesario para programas .COM
    .model    small           ; Define el modelo de memoria "small"
    .data     ; Segmento de datos
    num1_decenas db ?      ; Reserva un byte para las decenas del número 1
    num1_unidades db ?     ; Reserva un byte para las unidades del número 1
    num1      db ?              ; Reserva un byte para el número 1 completo
    num2_decenas db ?      ; Reserva un byte para las decenas del número 2
    num2_unidades db ?     ; Reserva un byte para las unidades del número 2
    num2      db ?              ; Reserva un byte para el número 2 completo
    suma      db ?              ; Reserva un byte para la suma de num1 y num2
    result_multi db ?      ; Reserva un byte para el resultado de la multiplicación de num1 y num2
    mensaje2  db 'Ingresa la calificacion del alumno:',10, 13, 10, 13, '$'
    mensaje3  db 'Ingresa el segundo numero:',10,13, '$'
    mensaje4  db 'Alumno reprobado',10,13, '$'
    mensaje5  db 'Alumno aprobado',10,13, '$'
    mensaje_error db 'Numero fuera de rango,favor de ingresar un numero del cero al diez.',10,13, '$'

    .code     ; Segmento de código

    mov       ax,@data
    mov       ds,ax

    do_while:
    mov       ah,02
    mov       dl,0ah
    int       21h
    mov       ah,02
    mov       dl,0dh
    int       21h
    ;         Mostrar el mensaje para ingresar la calificación
    mov       dx, offset mensaje2
    mov       ah,09
    int       21h

    ;         Lee el primer dígito de num1
    mov       ah,01              ; Servicio 01h de INT 21h: lee un carácter del teclado con eco
    int       21h                ; Llama a la interrupción 21h
    sub       al, 30h            ; Convertir carácter a número (ASCII a decimal)
    mov       num1_decenas,al    ; Almacena el valor en num1_decenas

    ;         Lee el segundo dígito de num1
    mov       ah,01              ; Servicio 01h de INT 21h: lee un carácter del teclado con eco
    int       21h                ; Llama a la interrupción 21h
    sub       al, 30h            ; Convertir carácter a número (ASCII a decimal)
    mov       num1_unidades,al   ; Almacena el valor en num1_unidades

    ;         Convierte los dígitos decenas y unidades a un número decimal
    xor       ah,ah              ; Limpia AH para la multiplicación
    mov       al,10d             ; AL = 10
    mul       num1_decenas       ; Multiplica num1_decenas por 10 (resultado en AX)
    mov       num1_decenas,al    ; Almacena el resultado en num1_decenas
    add       al,num1_unidades   ; Suma num1_unidades a AL (AL contiene ahora el número completo)
    mov       cl, al             ; Almacena el número completo en num1

    ;         Verifica si el número está entre 0 y 10
    cmp       cl, 0
    jl        fuera_de_rango
    cmp       cl, 10
    jg        fuera_de_rango
    jmp       continuar

    fuera_de_rango:
    mov       ah,02
    mov       dl,0ah
    int       21h
    mov       ah,02
    mov       dl,0dh
    int       21h

    mov       dx, offset mensaje_error
    mov       ah,09
    int       21h
    jmp       do_while

    continuar:
    ;         Desplazar el valor en CL dos posiciones a la derecha
    shr       cl, 1

    mov       bl, 2

    cmp       cl, bl        ;cmp es la comparacion

    je        igual
    jg        mayor
    jl        menor

    igual:
    mov       ah,02
    mov       dl,0ah
    int       21h
    mov       ah,02
    mov       dl,0dh
    int       21h

    mov       ax,@data
    mov       ds,ax
    mov       dx, offset mensaje4
    mov       ah,09
    int       21h
    jmp       fin

    menor:
    mov       ah,02
    mov       dl,0ah
    int       21h
    mov       ah,02
    mov       dl,0dh
    int       21h

    mov       ax,@data
    mov       ds,ax
    mov       dx, offset mensaje4
    mov       ah,09
    int       21h
    jmp       fin

    mayor:
    mov       ah,02
    mov       dl,0ah
    int       21h
    mov       ah,02
    mov       dl,0dh
    int       21h

    mov       ax,@data
    mov       ds,ax
    mov       dx, offset mensaje5
    mov       ah,09
    int       21h

    fin:
    mov       ah,4Ch
    int       21h

    end


    ;-------------

    org       100h                  ; Indica que el origen del código es 100h, necesario para programas .COM
    .model    small              ; Define el modelo de memoria "small"
    .data     ; Segmento de datos
    num1_decenas db ?      ; Reserva un byte para las decenas del número 1
    num1_unidades db ?     ; Reserva un byte para las unidades del número 1
    num1      db ?              ; Reserva un byte para el número 1 completo
    num2_decenas db ?      ; Reserva un byte para las decenas del número 2
    num2_unidades db ?     ; Reserva un byte para las unidades del número 2
    num2      db ?              ; Reserva un byte para el número 2 completo
    suma      db ?              ; Reserva un byte para la suma de num1 y num2
    result_multi db ?      ; Reserva un byte para el resultado de la multiplicación de num1 y num2
    mensaje2  db 'Ingresa la calificacion del alumno:',10, 13, 10, 13, '$'
    mensaje3  db 'Ingresa el segundo numero:',10,13, '$'
    mensaje4  db 'Alumno reprobado',10,13, '$'
    mensaje5  db 'Alumno aprobado',10,13, '$'
    mensaje_error db 'Numero fuera de rango,favor de ingresar un numero del cero al diez.',10,13, '$'

    .code     ; Segmento de código

    mov       ax, @data              ; Mueve la dirección del segmento de datos a AX
    mov       ds, ax                 ; Asigna la dirección del segmento de datos a DS

    do_while:
    mov       ah,02                  ; Servicio DOS: muestra un carácter en pantalla
    mov       dl,0ah                 ; DL = 0ah (salto de línea)
    int       21h                    ; Llama a la interrupción 21h
    mov       ah,02
    mov       dl,0dh                 ; DL = 0dh (retorno de carro)
    int       21h                    ; Llama a la interrupción 21h

    ;         Mostrar el mensaje para ingresar la calificación
    mov       dx, offset mensaje2    ; Carga la dirección de memoria del mensaje2 en DX
    mov       ah,09                  ; Función DOS: muestra una cadena de caracteres
    int       21h                    ; Llama a la interrupción 21h

    ;         Lee el primer dígito de num1
    mov       ah,01                  ; Servicio DOS: lee un carácter del teclado con eco
    int       21h                    ; Llama a la interrupción 21h
    sub       al, 30h                ; Convierte el carácter a número (ASCII a decimal)
    mov       num1_decenas, al       ; Almacena el valor en num1_decenas

    ;         Lee el segundo dígito de num1
    mov       ah,01                  ; Servicio DOS: lee un carácter del teclado con eco
    int       21h                    ; Llama a la interrupción 21h
    sub       al, 30h                ; Convierte el carácter a número (ASCII a decimal)
    mov       num1_unidades, al      ; Almacena el valor en num1_unidades

    ;         Convierte los dígitos decenas y unidades a un número decimal
    xor       ah,ah                  ; Limpia AH para la multiplicación
    mov       al,10d                 ; AL = 10
    mul       num1_decenas           ; Multiplica num1_decenas por 10 (resultado en AX)
    mov       num1_decenas, al       ; Almacena el resultado en num1_decenas
    add       al, num1_unidades      ; Suma num1_unidades a AL (AL contiene ahora el número completo)
    mov       num1, al               ; Almacena el número completo en num1

    ;         Verifica si el número está entre 0 y 10
    cmp       num1, 0
    jl        fuera_de_rango         ; Salta si num1 < 0
    cmp       num1, 10
    jg        fuera_de_rango         ; Salta si num1 > 10
    jmp       continuar

    fuera_de_rango:
    mov       ah,02                  ; Servicio DOS: muestra un carácter en pantalla
    mov       dl,0ah                 ; DL = 0ah (salto de línea)
    int       21h                    ; Llama a la interrupción 21h
    mov       ah,02
    mov       dl,0dh                 ; DL = 0dh (retorno de carro)
    int       21h                    ; Llama a la interrupción 21h

    mov       dx, offset mensaje_error ; Carga la dirección de memoria del mensaje_error en DX
    mov       ah,09                  ; Función DOS: muestra una cadena de caracteres
    int       21h                    ; Llama a la interrupción 21h
    jmp       do_while               ; Salta al inicio del ciclo "do_while"

    continuar:
    ;         Desplazar el valor en CL dos posiciones a la derecha
    shr       num1, 1

    mov       bl, 2

    cmp       num1, bl               ; Compara num1 con bl

    je        igual                   ; Salta si son iguales
    jg        mayor                   ; Salta si num1 > bl
    jl        menor                   ; Salta si num1 < bl

    igual:
    mov       ah,02                  ; Servicio DOS: muestra un carácter en pantalla
    mov       dl,0ah                 ; DL = 0ah (salto de línea)
    int       21h                    ; Llama a la interrupción 21h
    mov       ah,02
    mov       dl,0dh                 ; DL = 0dh (retorno de carro)
    int       21h                    ; Llama a la interrupción 21h

    mov       ax, @data              ; Restaura DS
    mov       ds, ax

    mov       dx, offset mensaje4    ; Carga la dirección de memoria del mensaje4 en DX
    mov       ah,09                  ; Función DOS: muestra una cadena de caracteres
    int       21h                    ; Llama a la interrupción 21h
    jmp       fin

    menor:
    mov       ah,02                  ; Servicio DOS: muestra un carácter en pantalla
    mov       dl,0ah                 ; DL = 0ah (salto de línea)
    int       21h                    ; Llama a la interrupción 21h
    mov       ah,02
    mov       dl,0dh                 ; DL = 0dh (retorno de carro)
    int       21h                    ; Llama a la interrupción 21h

    mov       ax, @data              ; Restaura DS
    mov       ds, ax

    mov       dx, offset mensaje4    ; Carga la dirección de memoria del mensaje4 en DX
    mov       ah,09                  ; Función DOS: muestra una cadena de caracteres
    int       21h                    ; Llama a la interrupción 21h
    jmp       fin

    mayor:
    mov       ah,02                  ; Servicio DOS: muestra un carácter en pantalla
    mov       dl,0ah                 ; DL = 0ah (salto de línea)
    int       21h                    ; Llama a la interrupción 21h
    mov       ah,02
    mov       dl,0dh                 ; DL = 0dh (retorno de carro)
    int       21h                    ; Llama a la interrupción 21h

    mov       ax, @data              ; Restaura DS
    mov       ds, ax

    mov       dx, offset mensaje5    ; Carga la dirección de memoria del mensaje5 en DX
    mov       ah,09                  ; Función DOS: muestra una cadena de caracteres
    int       21h                    ; Llama a la interrupción 21h

    fin:
    mov       ah,4Ch                  ; Función DOS: termina el programa
    int       21h                     ; Llama a la interrupción 21h

    end       ; Fin del programa

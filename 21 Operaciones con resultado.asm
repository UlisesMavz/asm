    org       100h               ; Indica que el origen del código es 100h, necesario para programas .COM
    .model    small           ; Define el modelo de memoria "small"
    .data     ; Segmento de datos
    num1_decenas db ?      ; Reserva un byte para las decenas del número 1
    num1_unidades db ?     ; Reserva un byte para las unidades del número 1
    num1      db ?
    ;         Reserva un byte para el número 1 completo
    num2_decenas db ?      ; Reserva un byte para las decenas del número 2
    num2_unidades db ?     ; Reserva un byte para las unidades del número 2
    num2      db ?              ; Reserva un byte para el número 2 completo


    num3_decenas db ?      ; Reserva un byte para las decenas del número 2
    num3_unidades db ?     ; Reserva un byte para las unidades del número 2
    num3      db ?


    num4_decenas db ?      ; Reserva un byte para las decenas del número 2
    num4_unidades db ?     ; Reserva un byte para las unidades del número 2
    num4      db ?

    num5_decenas db ?      ; Reserva un byte para las decenas del número 2
    num5_unidades db ?     ; Reserva un byte para las unidades del número 2
    num5      db ?

    num6_decenas db ?      ; Reserva un byte para las decenas del número 2
    num6_unidades db ?     ; Reserva un byte para las unidades del número 2
    num6      db ?



    resmul    db ?       ; Reserva un byte para el resultado de la multiplicación de num1 y num2
    resdiv    db ?
    resdiv2   db ?
    residuodiv db ?
    residuodiv2 db ?
    ressum    db ?

    mensaje2  db 'Ingresa el primer numero de la multiplicacion:',10, 13, 10, 13, '$'
    mensaje3  db 'Ingresa el segundo numero de la multiplicacion:',10,13, '$'
    mensaje4  db 'Resultado de la multiplicacion',10,13, '$'
    mensaje5  db 'Ingresa el primer numero de la division:',10,13, '$'
    mensaje6  db 'Ingresa el segundo numero de la division:',10,13, '$'
    mensaje7  db 'Resultado de la division.',10,13, '$'
    mensaje8  db 'Ingresa el primer numero de la suma:',10,13, '$'
    mensaje9  db 'Ingresa el segundo numero de la suma:',10,13, '$'
    mensaje10 db 'Resultado de la suma.',10,13, '$'

    .code     ; Segmento de código

    mov       ax,@data
    mov       ds,ax


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
    mov       num1, al             ; Almacena el número completo en num1

    mov       ah,02
    mov       dl,0ah
    int       21h
    mov       ah,02
    mov       dl,0dh
    int       21h
    ;         Mostrar el mensaje para ingresar la calificación
    mov       dx, offset mensaje3
    mov       ah,09
    int       21h

    ;         Lee el primer dígito de num1
    mov       ah,01              ; Servicio 01h de INT 21h: lee un carácter del teclado con eco
    int       21h                ; Llama a la interrupción 21h
    sub       al, 30h            ; Convertir carácter a número (ASCII a decimal)
    mov       num2_decenas,al    ; Almacena el valor en num1_decenas

    ;         Lee el segundo dígito de num1
    mov       ah,01              ; Servicio 01h de INT 21h: lee un carácter del teclado con eco
    int       21h                ; Llama a la interrupción 21h
    sub       al, 30h            ; Convertir carácter a número (ASCII a decimal)
    mov       num2_unidades,al   ; Almacena el valor en num1_unidades

    ;         Convierte los dígitos decenas y unidades a un número decimal
    xor       ah,ah              ; Limpia AH para la multiplicación
    mov       al,10d             ; AL = 10
    mul       num2_decenas       ; Multiplica num1_decenas por 10 (resultado en AX)
    mov       num2_decenas,al    ; Almacena el resultado en num1_decenas
    add       al,num2_unidades   ; Suma num1_unidades a AL (AL contiene ahora el número completo)
    mov       num2, al             ; Almacena el número completo en num1

    mov       ah,02
    mov       dl,0ah
    int       21h
    mov       ah,02
    mov       dl,0dh
    int       21h

    mov       ah,02
    mov       dl,0ah
    int       21h
    mov       ah,02
    mov       dl,0dh
    int       21h
    ;         Mostrar el mensaje para ingresar la calificación
    mov       dx, offset mensaje5
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
    mov       num3, al             ; Almacena el número completo en num1

    mov       ah,02
    mov       dl,0ah
    int       21h
    mov       ah,02
    mov       dl,0dh
    int       21h
    ;         Mostrar el mensaje para ingresar la calificación
    mov       dx, offset mensaje6
    mov       ah,09
    int       21h

    ;         Lee el primer dígito de num1
    mov       ah,01              ; Servicio 01h de INT 21h: lee un carácter del teclado con eco
    int       21h                ; Llama a la interrupción 21h
    sub       al, 30h            ; Convertir carácter a número (ASCII a decimal)
    mov       num2_decenas,al    ; Almacena el valor en num1_decenas

    ;         Lee el segundo dígito de num1
    mov       ah,01              ; Servicio 01h de INT 21h: lee un carácter del teclado con eco
    int       21h                ; Llama a la interrupción 21h
    sub       al, 30h            ; Convertir carácter a número (ASCII a decimal)
    mov       num2_unidades,al   ; Almacena el valor en num1_unidades

    ;         Convierte los dígitos decenas y unidades a un número decimal
    xor       ah,ah              ; Limpia AH para la multiplicación
    mov       al,10d             ; AL = 10
    mul       num2_decenas       ; Multiplica num1_decenas por 10 (resultado en AX)
    mov       num2_decenas,al    ; Almacena el resultado en num1_decenas
    add       al,num2_unidades   ; Suma num1_unidades a AL (AL contiene ahora el número completo)
    mov       num4, al             ; Almacena el número completo en num1

    mov       ah,02
    mov       dl,0ah
    int       21h
    mov       ah,02
    mov       dl,0dh
    int       21h
    ;         Mostrar el mensaje para ingresar la calificación
    mov       dx, offset mensaje8
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
    mov       num5, al

    mov       ah,02
    mov       dl,0ah
    int       21h
    mov       ah,02
    mov       dl,0dh
    int       21h
    ;         Mostrar el mensaje para ingresar la calificación
    mov       dx, offset mensaje9
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
    mov       num6, al



    mov       ah,02
    mov       dl,0ah
    int       21h
    mov       ah,02
    mov       dl,0dh
    int       21h
    ;         Mostrar el mensaje para ingresar la calificación
    mov       dx, offset mensaje4
    mov       ah,09
    int       21h

    mov       al,num1
    mov       bl,num2
    mul       bl

    mov       resmul,al

    mov       al, num5
    mov       bl, num6
    sub       al,bl
    mov       ressum,al



    mov       al,num3
    mov       bl,num4
    div       bl

    mov       resdiv,al
    mov       residuodiv,ah

    mov       al,0ah
    mul       residuodiv
    div       num4
    mov       resdiv2,al
    mov       residuodiv2,ah

    mov       al, resmul
    aam

    mov       bx,ax ;mueve el 135 separado a dx
    mov       dh,bl ;muve el 5 a dh

    mov       al,bh   ;mueve el trese a al
    aam       ;separa el 13 en 1 y 3
    mov       bx,ax
    add       bx,3030h
    add       dh,30h



    mov       ah,02
    mov       dl,bh   ;imprime el 1
    int       21h

    mov       ah,02
    mov       dl,bl    ;imprime el 3
    int       21h

    mov       ah,02
    mov       dl,dh    ;imprime el 5
    int       21h

    mov       ah,02
    mov       dl,0ah
    int       21h
    mov       ah,02
    mov       dl,0dh
    int       21h
    ;         Mostrar el mensaje para ingresar la calificación
    mov       dx, offset mensaje7
    mov       ah,09
    int       21h

    mov       al,resdiv
    aam

    mov       bx,ax
    add       bx,3030h
    mov       ah,02
    mov       dl,bh
    int       21h

    mov       ah,02
    mov       dl,bl
    int       21h

    mov       ah,02
    mov       dl,2eh
    int       21h

    add       resdiv2,30h
    mov       ah,02
    mov       dl,resdiv2
    int       21h

    mov       ah,02
    mov       dl,0ah
    int       21h
    mov       ah,02
    mov       dl,0dh
    int       21h
    ;         Mostrar el mensaje para ingresar la calificación
    mov       dx, offset mensaje10
    mov       ah,09
    int       21h


    mov       al, ressum
    aam

    mov       bx,ax ;mueve el 135 separado a dx
    mov       dh,bl ;muve el 5 a dh

    mov       al,bh   ;mueve el trese a al
    aam       ;separa el 13 en 1 y 3
    mov       bx,ax
    add       bx,3030h
    add       dh,30h



    mov       ah,02
    mov       dl,bh   ;imprime el 1
    int       21h

    mov       ah,02
    mov       dl,bl    ;imprime el 3
    int       21h

    mov       ah,02
    mov       dl,dh    ;imprime el 5
    int       21h

    mov       ah,02
    mov       dl,0ah
    int       21h
    mov       ah,02
    mov       dl,0dh
    int       21h


    jmp       fin

    fin:
    mov       ah,4Ch
    int       21h

    end

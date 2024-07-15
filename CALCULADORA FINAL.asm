    COMMENT   * Realiza una calculadora *

    .MODEL    small                                 ;modelo de memoria
    .STACK    ;area de pila

    .DATA     ;area de datos

    bienvenido db "Bienvenido >> $"                 ;define el mensaje de bienvenida del menu
    ingresarNombre db "Ingresa tu nombre >> $"      ;define el mensaje para ingresar nombre del usuario
    string    db 100,?,10 DUP(" ")                  ;espacio para almacenar una cadena de hasta 100 caracteres.

    menu      db "Menu de la calculadora$"          ;titulo del menu
    ;opciones del menu
    msuma     db "1. SUMA$"
    mresta    db "2. RESTA$"
    mmultiplicacion db "3. MULTIPLICACION$"
    mdivision db "4. DIVISION$"
    msalir    db "5. SALIR$"
    melige    db "INGRESA TU OPCION >>> $"
    opcion    dw ?                                  ;variable para almacenar la opción seleccionada (palabra)

    numero1   db "Ingresa el primer numero >> $"    ;primer numero solicitado
    numero2   db "Ingresa el segundo numero >> $"   ;segundo numero solicitado

    despedida db " GRACIAS :) $"                    ;mensaje de despedida

    opcSuma   db "<< Opcion Suma >> $"
    opcResta  db "<< Opcion Resta >> $"
    opcMultiplicacion db "<< Opcion Multiplicacion >> $"
    opcDivision db "<< Opcion Division >> $"

    verResultado db "El resultado es  >>$"             ;mensaje para mostrar el resultado de la operacion
    errorDiv0 db "Ingresa un numero diferente de cero.$"  ;mensaje de error para division por cero

    z1        dw 0                                  ; Variable temporal (palabra)
    n2        dd 0                                  ; Segundo número (doble palabra)
    n3        dd 0                                  ; Tercer número (doble palabra)
    n4        dw 0                                  ; Cuarto número (palabra).
    n5        dw 0                                  ; Quinto número (palabra)
    n6        dw 0                                  ; Sexto número (palabra)

    NC        dw 0                                  ; Variable de control (palabra)
    NCD       db 0                                  ; Variable de control (byte)

    resultado dw 0                                  ; Variable para almacenar el resultado de la operación (palabra)
    z2        db 0                                  ; Variable temporal (byte)
    z3        db 0                                  ; Variable temporal (byte)
    z4        db 0                                  ; Variable temporal (byte)
    z5        db 0                                  ; Variable temporal (byte)
    z6        db 0                                  ; Variable temporal (byte)

    mc        db "Pulsa cualquier tecla para continuar...$"     ; Mensaje para continuar
    mreturn   db "¿Deseas volver al menu? $"                    ; Pregunta si se desea volver al menu
    yes       db "1. SI$"                                       ; Opción de respuesta afirmativa
    no        db "2. NO$"                                       ; Opción de respuesta negativa
    xp        db 05H                                            ; Coordenada X horizontal para imprimir mensajes en pantalla
    yp        db 14H                                            ; Coordenada Y vertitcal para imprimir mensajes en pantalla


    .CODE     ;area de codigo

    MAIN      PROC                      ;INICIO DEL PROCESO PRINCIPAL

    mov       AX, @DATA                 ;asigna la direccion de datos a AX
    mov       DS, AX                    ;a traves de AX a DS

    CALL      STYLE                     ;llama a la función STYLE para establecer el estilo de la interfaz
    CALL      POINTPOSITION             ;llama a la función POINTPOSITION para posicionar el cursor en pantalla

    LEA       DX, ingresarNombre        ;carga en DX la dirección del mensaje ingresarNombre para imprimirlo
    mov       AH, 09H                   ;carga la función de servicio 09Hdel BIOS (imprimir cadena)
    INT       21H                       ;llama al servicio de interrupción 21H para imprimir el mensaje

    mov       DX, offset string         ;carga en DX la dirección de memoria de la variable string (para capturar entrada)
    mov       AH, 0AH                   ;carga la función de servicio 0AH del BIOS (capturar cadena)
    INT       21H                       ;llama al servicio de interrupción 21H para capturar la entrada del usuario


    ;---      [MENU]

    verMENU:
    mov       opcion, 0                 ;inicializa la variable opcion a 0 (opción seleccionada por el usuario)
    mov       resultado, 0              ;inicializa la variable resultado a 0 (resultado de operaciones)

    CALL      CLEARSCREEN               ;llama a la función CLEARSCREEN para limpiar la pantalla
    ADD       xp, 02H                   ; Añade 2 a la posición X en la pantalla
    CALL      POINTPOSITION             ; Llama a POINTPOSITION para posicionar el cursor en pantalla

    LEA       DX, bienvenido            ; Carga en DX la dirección del mensaje bienvenido para imprimirlo
    mov       AH, 09H                   ; Carga la función de servicio 09H del BIOS (imprimir cadena)
    INT       21H                       ; Llama al servicio de interrupción 21H para imprimir el mensaje de bienvenida

    mov       BL, string[1]             ; Obtiene el primer byte de la cadena almacenada en string
    mov       string[BX+2], "$"         ; Añade el carácter '$' al final de la cadena ingresada por el usuario
    mov       DX, offset string + 2     ; Carga en DX la dirección de memoria de los primeros 2 bytes de string
    mov       AH, 09H                   ; Carga la función de servicio 09H del BIOS (imprimir cadena)
    INT       21H                       ; Llama al servicio de interrupción 21H para imprimir la cadena modificada

    LEA       DX, menu                  ; Carga en DX la dirección del mensaje menu para imprimirlo
    mov       AH, 09H                   ; Carga la función de servicio 09H del BIOS (imprimir cadena)
    ADD       xp, 02H                   ; Añade 2 a la posición X en la pantalla
    CALL      POINTPOSITION             ; Llama a POINTPOSITION para posicionar el cursor en pantalla

    ADD       xp, 02H                   ; Añade 2 a la posición X en la pantalla
    LEA       DX, msuma                 ; Carga en DX la dirección del mensaje msuma (opción 1: SUMA) para imprimirlo
    mov       AH, 09H                   ; Carga la función de servicio 09H del BIOS (imprimir cadena)
    INT       21H                       ; Llama al servicio de interrupción 21H para imprimir la opción de suma

    CALL      POINTPOSITION             ; Llama a POINTPOSITION para posicionar el cursor en pantalla
    ADD       xp, 02H                   ; Añade 2 a la posición X en la pantalla

    LEA       DX, mresta                ; Carga en DX la dirección del mensaje mresta (opción 2: RESTA) para imprimirlo
    mov       AH, 09H                   ; Carga la función de servicio 09H del BIOS (imprimir cadena)
    INT       21H                       ; Llama al servicio de interrupción 21H para imprimir la opción de resta

    CALL      POINTPOSITION             ; Llama a POINTPOSITION para posicionar el cursor en pantalla
    ADD       xp, 02H                   ; Añade 2 a la posición X en la pantalla

    LEA       DX, mmultiplicacion  ; Carga en DX la dirección del mensaje mmultiplicacion (opción 3: MULTIPLICACIÓN) para imprimirlo
    mov       AH, 09H         ; Carga la función de servicio 09H del BIOS (imprimir cadena)
    INT       21H             ; Llama al servicio de interrupción 21H para imprimir la opción de multiplicación

    CALL      POINTPOSITION  ; Llama a POINTPOSITION para posicionar el cursor en pantalla
    ADD       xp, 02H         ; Añade 2 a la posición X en la pantalla

    LEA       DX, mdivision   ; Carga en DX la dirección del mensaje mdivision (opción 4: DIVISIÓN) para imprimirlo
    mov       AH, 09H         ; Carga la función de servicio 09H del BIOS (imprimir cadena)
    INT       21H             ; Llama al servicio de interrupción 21H para imprimir la opción de división

    CALL      POINTPOSITION  ; Llama a POINTPOSITION para posicionar el cursor en pantalla
    ADD       xp, 02H         ; Añade 2 a la posición X en la pantalla

    LEA       DX, msalir      ; Carga en DX la dirección del mensaje msalir (opción 5: SALIR) para imprimirlo
    mov       AH, 09H         ; Carga la función de servicio 09H del BIOS (imprimir cadena)
    INT       21H             ; Llama al servicio de interrupción 21H para imprimir la opción de salir

    CALL      POINTPOSITION  ; Llama a POINTPOSITION para posicionar el cursor en pantalla
    ADD       xp, 02H         ; Añade 2 a la posición X en la pantalla

    LEA       DX, melige      ; Carga en DX la dirección del mensaje melige (mensaje: INGRESA TU OPCION >>>) para imprimirlo
    mov       AH, 09H         ; Carga la función de servicio 09H del BIOS (imprimir cadena)
    INT       21H             ; Llama al servicio de interrupción 21H para imprimir el mensaje de solicitud de opción

    mov       AH, 01H         ; Carga la función de servicio 01h del BIOS (leer un carácter desde la entrada estándar, sin eco)
    INT       21H             ; Llama al servicio de interrupción 21H para leer la opción ingresada por el usuario

    SUB       AX, 304         ; Convierte el carácter ASCII de la opción ingresada a su valor numérico (resta 30h)
    mov       opcion, AX      ; Guarda el valor numérico de la opción seleccionada en la variable opcion

    CALL      OPERATION      ; Llama a la función OPERATION para realizar la operación seleccionada

    MAIN      ENDP   ;FIN DEL PROCESO PRINCIPAL

    ;-------------------------------------------------------------- [*MAIN]

    INPUTS    PROC
    ;         Este procedimiento captura los números ingresados por el usuario
    ;         y los almacena en las variables n2, n3, n4, n5, y n6.

    ADD       xp, 02H         ; Incrementa la posición X en pantalla en 2
    CALL      POINTPOSITION  ; Llama a POINTPOSITION para posicionar el cursor en pantalla

    LEA       DX, numero1          ; Carga en DX la dirección del mensaje numero1 para imprimirlo
    mov       AH, 09H         ; Carga la función de servicio 09H del BIOS (imprimir cadena)
    INT       21H             ; Llama al servicio de interrupción 21H para imprimir el mensaje

    CALL      INPUTN         ; Llama al procedimiento INPUTN para capturar los números ingresados

    NC2:
    mov       AX, 0           ; Inicializa AX con 0
    mov       AX, NC          ; Mueve el contenido de la variable NC a AX
    mov       resultado, AX   ; Guarda el contenido de AX en la variable resultado
    mov       opcion, 5       ; Establece la opción como 5 (para salir)

    ADD       xp, 02H         ; Incrementa la posición X en pantalla en 2
    CALL      POINTPOSITION  ; Llama a POINTPOSITION para posicionar el cursor en pantalla

    LEA       DX, numero2          ; Carga en DX la dirección del mensaje numero2 para imprimirlo
    mov       AH, 09H         ; Carga la función de servicio 09H del BIOS (imprimir cadena)
    INT       21H             ; Llama al servicio de interrupción 21H para imprimir el mensaje

    CALL      INPUTN         ; Llama al procedimiento INPUTN para capturar los números ingresados

    RET       ; Retorna al punto de llamada (probablemente MAIN PROC)

    INPUTS    ENDP
    ;-------------------------------------------------------------- [INPUTS]

    INPUTN:
    ;         Este procedimiento captura un número ingresado por el usuario y lo convierte
    ;         de su forma ASCII a un número decimal, almacenándolo en las variables n2, n3, n4, n5, o n6.

    mov       AH, 01H         ; Carga la función de servicio 01h del BIOS (leer un carácter desde la entrada estándar, sin eco)
    INT       21H             ; Llama al servicio de interrupción 21H para leer un carácter

    SUB       AX, 304         ; Convierte el carácter ASCII a su valor numérico (resta 30h)
    mov       n2, AX          ; Guarda el valor numérico en la variable n2

    mov       AH, 01H         ; Lee el siguiente carácter
    INT       21H             ; Llama al servicio de interrupción 21H para leer un carácter

    SUB       AX, 304         ; Convierte el carácter ASCII a su valor numérico (resta 30h)
    mov       n3, AX          ; Guarda el valor numérico en la variable n3

    mov       AH, 01H         ; Lee el siguiente carácter
    INT       21H             ; Llama al servicio de interrupción 21H para leer un carácter

    SUB       AX, 304         ; Convierte el carácter ASCII a su valor numérico (resta 30h)
    mov       n4, AX          ; Guarda el valor numérico en la variable n4

    mov       AH, 01H         ; Lee el siguiente carácter
    INT       21H             ; Llama al servicio de interrupción 21H para leer un carácter

    SUB       AX, 304         ; Convierte el carácter ASCII a su valor numérico (resta 30h)
    mov       n5, AX          ; Guarda el valor numérico en la variable n5

    mov       AH, 01H         ; Lee el último carácter
    INT       21H             ; Llama al servicio de interrupción 21H para leer un carácter

    SUB       AX, 304         ; Convierte el carácter ASCII a su valor numérico (resta 30h)
    mov       n6, AX          ; Guarda el valor numérico en la variable n6

    CALL      JOINN          ; Llama al procedimiento JOINN para combinar los números ingresados

    RET       ; Retorna al punto de llamada (probablemente INPUTS PROC)

    ;-------------------------------------------------------------- {INPUTN:}
    JOINN:
    ;         Este procedimiento combina los números almacenados en n2, n3, n4, n5 y n6
    ;         en una sola variable NC, considerando su posición decimal.

    Mn2:
    XOR       AX, AX      ; Borra AX (registros temporales)
    CMP       n2, 0       ; Compara n2 con 0
    JZ        Mn3          ; Salta a Mn3 si n2 es igual a 0
    JL        Mn3          ; Salta a Mn3 si n2 es menor que 0 (no debería suceder aquí)
    mov       AX, 0       ; Borra AX (registros temporales)
    mov       AX, n2      ; Mueve n2 a AX
    mov       BX, 10000   ; Mueve 10000 a BX
    MUL       BX          ; Multiplica AX por BX (resultado en DX:AX)
    mov       n2, 0       ; Borra n2
    mov       n2, AX      ; Guarda el resultado en n2 (n2 ahora tiene el número convertido * 10000)

    Mn3:
    XOR       AX, AX      ; Borra AX (registros temporales)
    CMP       n3, 0       ; Compara n3 con 0
    JZ        Mn4          ; Salta a Mn4 si n3 es igual a 0
    mov       AX, 00       ; Borra AX (registros temporales)
    mov       AX, n3      ; Mueve n3 a AX
    mov       BX, 1000    ; Mueve 1000 a BX
    MUL       BX          ; Multiplica AX por BX (resultado en DX:AX)
    mov       n3, 0       ; Borra n3
    mov       n3, AX      ; Guarda el resultado en n3 (n3 ahora tiene el número convertido * 1000)

    Mn4:
    XOR       AX, AX      ; Borra AX (registros temporales)
    CMP       n4, 0       ; Compara n4 con 0
    JZ        Mn5          ; Salta a Mn5 si n4 es igual a 0
    mov       AX, 00       ; Borra AX (registros temporales)
    mov       AX, n4      ; Mueve n4 a AX
    mov       BX, 100     ; Mueve 100 a BX
    MUL       BX          ; Multiplica AX por BX (resultado en DX:AX)
    mov       n4, 0       ; Borra n4
    mov       n4, AX      ; Guarda el resultado en n4 (n4 ahora tiene el número convertido * 100)

    Mn5:
    XOR       AX, AX      ; Borra AX (registros temporales)
    CMP       n5, 0       ; Compara n5 con 0
    JZ        assembler    ; Salta a assembler si n5 es igual a 0
    mov       AX, 00       ; Borra AX (registros temporales)
    mov       AX, n5      ; Mueve n5 a AX
    mov       BX, 10      ; Mueve 10 a BX
    MUL       BX          ; Multiplica AX por BX (resultado en DX:AX)
    mov       n5, 0       ; Borra n5
    mov       n5, AX      ; Guarda el resultado en n5 (n5 ahora tiene el número convertido * 10)

    assembler:
    XOR       AX, AX      ; Borra AX (registros temporales)

    mov       AX, n2      ; Mueve n2 a AX
    mov       NC, 0        ; Inicializa NC a 0 (suma acumulada)
    CMP       n2, 0       ; Compara n2 con 0
    JL        pastTon3     ; Salta a pastTon3 si n2 es menor que 0
    ADD       NC, AX      ; Suma AX a NC (suma acumulada)
    mov       AX, 0       ; Borra AX (registros temporales)

    pastTon3:
    mov       AX, n3      ; Mueve n3 a AX
    ADD       NC, AX      ; Suma AX a NC (suma acumulada)
    mov       AX, 0       ; Borra AX (registros temporales)

    mov       AX, n4      ; Mueve n4 a AX
    ADD       NC, AX      ; Suma AX a NC (suma acumulada)
    mov       AX, 0       ; Borra AX (registros temporales)

    mov       AX, n5      ; Mueve n5 a AX
    ADD       NC, AX      ; Suma AX a NC (suma acumulada)
    mov       AX, 0       ; Borra AX (registros temporales)

    mov       AX, n6      ; Mueve n6 a AX
    ADD       NC, AX      ; Suma AX a NC (suma acumulada)
    XOR       AX, AX      ; Borra AX (registros temporales)

    mov       AX, n2      ; Mueve n2 a AX
    CMP       n2, 0       ; Compara n2 con 0
    JL        convertNegative  ; Salta a convertNegative si n2 es menor que 0

    mov       n2, 0       ; Borra n2
    mov       n3, 0       ; Borra n3
    mov       n4, 0       ; Borra n4
    mov       n5, 0       ; Borra n5
    mov       n6, 0       ; Borra n6

    RET       ; Retorna al punto de llamada (probablemente INPUTS PROC)

    convertNegative:
    mov       AX, n2      ; Mueve n2 a AX
    ADD       n2, 2       ; Suma 2 a n2 (para convertirlo en negativo)

    mov       AX, 0       ; Borra AX (registros temporales)
    mov       AX, n2      ; Mueve n2 a AX
    mov       BX, NC      ; Mueve NC a BX
    MUL       BX          ; Multiplica AX por BX (resultado en DX:AX)

    mov       NC, 0       ; Borra NC
    mov       NC, AX      ; Guarda el resultado en NC (NC ahora tiene el valor negativo)

    RET       ; Retorna al punto de llamada (probablemente INPUTS PROC)

    ;-------------------------------------------------------------- [JOINN:]

    CLEARSCREEN PROC
    ;         Este procedimiento limpia la pantalla del monitor de texto.

    mov       xp, 03H     ; Establece xp a 03H (posición X para posicionar el cursor)
    mov       AH, 0FH     ; Función AH=0FH del BIOS (obtener página actual y atributos del cursor)
    INT       10H         ; Llama al servicio de interrupción 10H del BIOS (video services)
    mov       AH, 0       ; Función AH=0 del BIOS (set video mode)
    INT       10H         ; Llama al servicio de interrupción 10H del BIOS (video services)
    RET       ; Retorna al punto de llamada

    CLEARSCREEN ENDP
    ;_________________________________________________________________ [CLEARSCREEN]

    STYLE     PROC NEAR
    ;         Este procedimiento establece el estilo de pantalla con 25 filas y 80 columnas.

    mov       AX, 0600H   ; Mueve 0600H a AX (código de video mode 3, 25x80 color)
    mov       BH, 00AH    ; Mueve 00AH a BH (color de fondo y atributos de visualización)
    mov       CX, 000H    ; Mueve 000H a CX (fila de inicio)
    mov       DX, 484FH   ; Mueve 484FH a DX (última fila y última columna)
    INT       10H         ; Llama al servicio de interrupción 10H del BIOS (video services)
    RET       ; Retorna al punto de llamada

    STYLE     ENDP
    ;-------------------------------------------------------------- [STYLE]

    STYLEERR  PROC NEAR
    ;         Este procedimiento establece el estilo de pantalla con 25 filas y 80 columnas,
    ;         pero con un color de fondo diferente para manejar errores.

    mov       AX, 0600H   ; Mueve 0600H a AX (código de video mode 3, 25x80 color)
    mov       BH, 004H    ; Mueve 004H a BH (color de fondo y atributos de visualización para errores)
    mov       CX, 000H    ; Mueve 000H a CX (fila de inicio)
    mov       DX, 484FH   ; Mueve 484FH a DX (última fila y última columna)
    INT       10H         ; Llama al servicio de interrupción 10H del BIOS (video services)
    RET       ; Retorna al punto de llamada

    STYLEERR  ENDP
    ;-------------------------------------------------------------- [STYLEERR]

    POINTPOSITION PROC
    ;         Este procedimiento posiciona el cursor en la pantalla de acuerdo a las coordenadas xp y yp.

    mov       AH, 02H     ; Función AH=02H del BIOS (set cursor position)
    mov       BH, 00H     ; Mueve 00H a BH (página de visualización)
    mov       DH, xp      ; Mueve xp a DH (posición vertical del cursor)
    mov       DL, yp      ; Mueve yp a DL (posición horizontal del cursor)
    INT       10H         ; Llama al servicio de interrupción 10H del BIOS (video services)
    RET       ; Retorna al punto de llamada

    POINTPOSITION ENDP

    ;-------------------------------------------------------------- [POINTPOSITION]

    OPERATION PROC
    ;         Este procedimiento determina la operación a realizar según la opción seleccionada por el usuario.

    CMP       opcion, 1    ; Compara opcion con 1
    JZ        SUMA         ; Salta a SUMA si opcion es igual a 1
    JL        verMENU      ; Salta a verMENU si opcion es menor que 1 (no debería suceder)
    CMP       opcion, 2    ; Compara opcion con 2
    JZ        RESTA        ; Salta a RESTA si opcion es igual a 2
    CMP       opcion, 3    ; Compara opcion con 3
    JZ        MULT         ; Salta a MULT si opcion es igual a 3
    CMP       opcion, 4    ; Compara opcion con 4
    JZ        DIVI         ; Salta a DIVI si opcion es igual a 4
    CMP       opcion, 5    ; Compara opcion con 5
    JZ        exit         ; Salta a exit si opcion es igual a 5
    JG        verMENU      ; Salta a verMENU si opcion es mayor que 5 (no debería suceder)

    OPERATION ENDP
    ;-------------------------------------------------------------- [OPERATION]

    SUMA      PROC
    ;         Este procedimiento realiza la operación de suma.

    CALL      CLEARSCREEN    ; Llama al procedimiento para limpiar la pantalla
    CALL      POINTPOSITION  ; Llama al procedimiento para posicionar el cursor
    LEA       DX, opcSuma          ; Carga la dirección del mensaje opcSuma en DX
    mov       AH, 09H         ; Establece AH=09H (función de impresión de cadena)
    INT       21H             ; Llama al servicio de interrupción 21H del DOS (imprimir cadena)
    S2:
    CALL      INPUTS         ; Llama al procedimiento para capturar los números de entrada
    mov       AX, NC          ; Mueve el contenido de NC a AX (suma acumulada)
    ADD       resultado, AX   ; Suma AX a resultado (suma total acumulada)
    ADD       xp, 02H         ; Suma 02H a xp (posición X para desplazamiento del cursor)
    CALL      POINTPOSITION  ; Llama al procedimiento para posicionar el cursor
    mov       AH, 9         ; Establece AH=09H (función de impresión de cadena)
    LEA       DX, verResultado         ; Carga la dirección del mensaje verResultado en DX
    INT       21H             ; Llama al servicio de interrupción 21H del DOS (imprimir cadena)
    CALL      CONVERTN       ; Llama al procedimiento para convertir el resultado a texto
    CALL      CLEARSCREEN    ; Llama al procedimiento para limpiar la pantalla
    CALL      TRYAGAIN       ; Llama al procedimiento para intentar nuevamente

    SUMA      ENDP
    ;-------------------------------------------------------------- [SUMA]

    RESTA     PROC
    ;         Este procedimiento realiza la operación de resta.

    CALL      CLEARSCREEN        ; Llama al procedimiento para limpiar la pantalla
    CALL      POINTPOSITION     ; Llama al procedimiento para posicionar el cursor
    LEA       DX, opcResta             ; Carga la dirección del mensaje opcResta en DX
    mov       AH, 09H            ; Establece AH=09H (función de impresión de cadena)
    INT       21H                ; Llama al servicio de interrupción 21H del DOS (imprimir cadena)
    CALL      POINTPOSITION     ; Llama al procedimiento para posicionar el cursor

    R2:
    CALL      INPUTS            ; Llama al procedimiento para capturar los números de entrada
    mov       AX, NC             ; Mueve el contenido de NC a AX (número a restar)
    SUB       resultado, AX      ; Resta AX de resultado (resta acumulada)
    ADD       xp, 02H            ; Suma 02H a xp (posición X para desplazamiento del cursor)
    CALL      POINTPOSITION     ; Llama al procedimiento para posicionar el cursor
    mov       AH, 9           ; Establece AH=09H (función de impresión de cadena)
    LEA       DX, verResultado            ; Carga la dirección del mensaje verResultado en DX
    INT       21H                ; Llama al servicio de interrupción 21H del DOS (imprimir cadena)
    CALL      CONVERTN          ; Llama al procedimiento para convertir el resultado a texto
    CALL      CLEARSCREEN       ; Llama al procedimiento para limpiar la pantalla
    CALL      TRYAGAIN          ; Llama al procedimiento para intentar nuevamente

    RESTA     ENDP
    ;-------------------------------------------------------------- [RESTA]

    MULT      PROC
    ;         Este procedimiento realiza la operación de multiplicación.

    CALL      CLEARSCREEN        ; Llama al procedimiento para limpiar la pantalla
    CALL      POINTPOSITION     ; Llama al procedimiento para posicionar el cursor
    LEA       DX, opcMultiplicacion            ; Carga la dirección del mensaje opcMultiplicacionen DX
    mov       AH, 09H            ; Establece AH=09H (función de impresión de cadena)
    INT       21H                ; Llama al servicio de interrupción 21H del DOS (imprimir cadena)
    ML2:
    CALL      INPUTS            ; Llama al procedimiento para capturar los números de entrada
    mov       AX, 0             ; Mueve el contenido de NC a AX (primer factor)
    mov       AX, NC             ; Mueve el contenido de NC a AX (primer factor)
    mov       BX, resultado      ; Mueve el contenido de resultado a BX (segundo factor)
    MUL       BX                 ; Multiplica AX por BX (resultado acumulado)
    mov       resultado, 0      ; Mueve el resultado de la multiplicación a resultado
    mov       resultado, AX      ; Mueve el resultado de la multiplicación a resultado
    ADD       xp, 02H            ; Suma 02H a xp (posición X para desplazamiento del cursor)
    CALL      POINTPOSITION     ; Llama al procedimiento para posicionar el cursor
    mov       AH, 9            ; Establece AH=09H (función de impresión de cadena)
    LEA       DX, verResultado            ; Carga la dirección del mensaje verResultado en DX
    INT       21H                ; Llama al servicio de interrupción 21H del DOS (imprimir cadena)
    CALL      CONVERTN          ; Llama al procedimiento para convertir el resultado a texto
    CALL      CLEARSCREEN       ; Llama al procedimiento para limpiar la pantalla
    CALL      TRYAGAIN          ; Llama al procedimiento para intentar nuevamente

    MULT      ENDP
    ;-------------------------------------------------------------- [MULT]

    DIVI      PROC
    ;         Este procedimiento realiza la operación de división.

    CALL      CLEARSCREEN        ; Llama al procedimiento para limpiar la pantalla
    CALL      POINTPOSITION     ; Llama al procedimiento para posicionar el cursor
    LEA       DX, opcDivision             ; Carga la dirección del mensaje opcDivision en DX
    mov       AH, 09H            ; Establece AH=09H (función de impresión de cadena)
    INT       21H                ; Llama al servicio de interrupción 21H del DOS (imprimir cadena)
    D2:
    CALL      INPUTS            ; Llama al procedimiento para capturar los números de entrada
    XOR       DX, DX             ; Borra DX (inicializa para división)
    mov       AX, resultado      ; Mueve el contenido de resultado a AX (dividendo)
    mov       BX, NC             ; Mueve el contenido de NC a BX (divisor)
    CMP       NC, 0              ; Compara NC con 0 para verificar división por cero
    JZ        ZEROERR             ; Salta a ZEROERR si NC es igual a 0 (error de división por cero)
    DIV       BX                 ; Divide AX por BX (resultado en AX, residuo en DX)
    mov       resultado, 0      ; Mueve el resultado de la división a resultado
    mov       resultado, AX      ; Mueve el resultado de la división a resultado
    ADD       xp, 02H            ; Suma 02H a xp (posición X para desplazamiento del cursor)
    CALL      POINTPOSITION     ; Llama al procedimiento para posicionar el cursor
    mov       AH, 9            ; Establece AH=09H (función de impresión de cadena)
    LEA       DX, verResultado            ; Carga la dirección del mensaje verResultado en DX
    INT       21H                ; Llama al servicio de interrupción 21H del DOS (imprimir cadena)
    CALL      CONVERTN          ; Llama al procedimiento para convertir el resultado a texto
    CALL      CLEARSCREEN       ; Llama al procedimiento para limpiar la pantalla
    CALL      TRYAGAIN          ; Llama al procedimiento para intentar nuevamente

    DIVI      ENDP

    ;-------------------------------------------------------------- [ZEROERR]

    ZEROERR   PROC
    ;         Este procedimiento maneja el error de división por cero.

    CALL      CLEARSCREEN       ; Llama al procedimiento para limpiar la pantalla
    CALL      POINTPOSITION     ; Llama al procedimiento para posicionar el cursor
    CALL      STYLEERR          ; Llama al procedimiento para aplicar estilo de error
    mov       AH, 9            ; Establece AH=09H (función de impresión de cadena)
    LEA       DX, errorDiv0          ; Carga la dirección del mensaje errorDiv0 en DX
    INT       21H                ; Llama al servicio de interrupción 21H del DOS (imprimir cadena)
    ADD       xp, 03H            ; Suma 03H a xp (posición X para desplazamiento del cursor)
    CALL      POINTPOSITION     ; Llama al procedimiento para posicionar el cursor
    mov       AH, 9            ; Establece AH=09H (función de impresión de cadena)
    LEA       DX, mc             ; Carga la dirección del mensaje mc en DX
    INT       21H                ; Llama al servicio de interrupción 21H del DOS (imprimir cadena)
    mov       AH, 01H            ; Establece AH=01h (función de lectura de teclado sin eco)
    INT       21H                ; Llama al servicio de interrupción 21H del DOS (espera entrada del usuario)
    mov       opcion, 4          ; Establece la opción como 4 (volver a la opción de división)
    mov       NC, 0              ; Reinicia NC a 0 (limpia la variable de control)
    mov       resultado, 0       ; Reinicia resultado a 0 (limpia el resultado anterior)
    CMP       resultado, 0       ; Compara resultado con 0 para determinar si es cero
    CALL      STYLE             ; Llama al procedimiento para aplicar estilo
    JZ        OPERATION           ; Salta a OPERATION si resultado es cero (usuario puede intentar operación de nuevo)

    ZEROERR   ENDP
    ;-------------------------------------------------------------- [ZEROERR]

    CONVERTN  PROC
    ;         Este procedimiento convierte el número en resultado en una cadena de caracteres.

    XOR       DX, DX             ; Borra DX (inicializa para división)
    mov       AX, resultado      ; Mueve el contenido de resultado a AX (número a convertir)
    mov       BX, 10             ; Establece BX=10 (divisor para la conversión decimal)
    DIV       BX                 ; Divide AX por BX (resultado en AX, residuo en DX)
    mov       resultado, 0       ; Reinicia resultado a 0 (prepara para el siguiente cálculo)
    mov       resultado, AX      ; Mueve el cociente de la división a resultado
    mov       z6, DL             ; Mueve el último dígito al almacenamiento temporal z6
    CMP       resultado, 0       ; Compara resultado con 0 para verificar si se ha terminado la conversión
    JZ        PRINT               ; Salta a PRINT si resultado es cero (fin de la conversión)

    XOR       DX, DX             ; Borra DX (inicializa para división)
    mov       AX, 0              ; Borra AX
    mov       AX, resultado      ; Mueve el contenido de resultado a AX (número a convertir)
    mov       BX, 10             ; Establece BX=10 (divisor para la conversión decimal)
    DIV       BX                 ; Divide AX por BX (resultado en AX, residuo en DX)
    mov       resultado, 0       ; Reinicia resultado a 0 (prepara para el siguiente cálculo)
    mov       resultado, AX      ; Mueve el cociente de la división a resultado
    mov       z5, DL             ; Mueve el siguiente dígito al almacenamiento temporal z5
    CMP       resultado, 0       ; Compara resultado con 0 para verificar si se ha terminado la conversión
    JZ        PRINT               ; Salta a PRINT si resultado es cero (fin de la conversión)

    XOR       DX, DX             ; Borra DX (inicializa para división)
    mov       AX, 0              ; Borra AX
    mov       AX, resultado      ; Mueve el contenido de resultado a AX (número a convertir)
    mov       BX, 10             ; Establece BX=10 (divisor para la conversión decimal)
    DIV       BX                 ; Divide AX por BX (resultado en AX, residuo en DX)
    mov       resultado, 0       ; Reinicia resultado a 0 (prepara para el siguiente cálculo)
    mov       resultado, AX      ; Mueve el cociente de la división a resultado
    mov       z4, DL             ; Mueve el siguiente dígito al almacenamiento temporal z4
    CMP       resultado, 0       ; Compara resultado con 0 para verificar si se ha terminado la conversión
    JZ        PRINT               ; Salta a PRINT si resultado es cero (fin de la conversión)

    XOR       DX, DX             ; Borra DX (inicializa para división)
    mov       AX, 0              ; Borra AX
    mov       AX, resultado      ; Mueve el contenido de resultado a AX (número a convertir)
    mov       BX, 10             ; Establece BX=10 (divisor para la conversión decimal)
    DIV       BX                 ; Divide AX por BX (resultado en AX, residuo en DX)
    mov       resultado, 0       ; Reinicia resultado a 0 (prepara para el siguiente cálculo)
    mov       resultado, AX      ; Mueve el cociente de la división a resultado
    mov       z3, DL             ; Mueve el siguiente dígito al almacenamiento temporal z3
    CMP       resultado, 0       ; Compara resultado con 0 para verificar si se ha terminado la conversión
    JZ        PRINT               ; Salta a PRINT si resultado es cero (fin de la conversión)

    XOR       DX, DX             ; Borra DX (inicializa para división)
    mov       AX, 0              ; Borra AX
    mov       AX, resultado      ; Mueve el contenido de resultado a AX (número a convertir)
    mov       BX, 10             ; Establece BX=10 (divisor para la conversión decimal)
    DIV       BX                 ; Divide AX por BX (resultado en AX, residuo en DX)
    mov       resultado, 0       ; Reinicia resultado a 0 (prepara para el siguiente cálculo)
    mov       resultado, AX      ; Mueve el cociente de la división a resultado
    mov       z2, DL             ; Mueve el siguiente dígito al almacenamiento temporal z2

    PRINT:
    ;         Este bloque imprime los dígitos convertidos en la pantalla.

    mov       DL, z2             ; Mueve el dígito z2 a DL (conversión a ASCII)
    ADD       DL, 48             ; Convierte el dígito a su equivalente ASCII
    mov       AH, 2              ; Establece AH=2 (función de impresión de un carácter)
    INT       21H                ; Llama al servicio de interrupción 21H del DOS (imprimir carácter)

    mov       DL, 0              ; Borra DL
    mov       DL, z3             ; Mueve el dígito z3 a DL (conversión a ASCII)
    ADD       DL, 48             ; Convierte el dígito a su equivalente ASCII
    mov       AH, 2              ; Establece AH=2 (función de impresión de un carácter)
    INT       21H                ; Llama al servicio de interrupción 21H del DOS (imprimir carácter)

    mov       DL, 0              ; Borra DL
    mov       DL, z4             ; Mueve el dígito z4 a DL (conversión a ASCII)
    ADD       DL, 48             ; Convierte el dígito a su equivalente ASCII
    mov       AH, 2              ; Establece AH=2 (función de impresión de un carácter)
    INT       21H                ; Llama al servicio de interrupción 21H del DOS (imprimir carácter)

    mov       DL, 0              ; Borra DL
    mov       DL, z5             ; Mueve el dígito z5 a DL (conversión a ASCII)
    ADD       DL, 48             ; Convierte el dígito a su equivalente ASCII
    mov       AH, 2              ; Establece AH=2 (función de impresión de un carácter)
    INT       21H                ; Llama al servicio de interrupción 21H del DOS (imprimir carácter)

    mov       DL, 0              ; Borra DL
    mov       DL, z6             ; Mueve el dígito z6 a DL (conversión a ASCII)
    ADD       DL, 48             ; Convierte el dígito a su equivalente ASCII
    mov       AH, 2              ; Establece AH=2 (función de impresión de un carácter)
    INT       21H                ; Llama al servicio de interrupción 21H del DOS (imprimir carácter)

    ADD       xp, 02H            ; Suma 02H a xp (posición X para desplazamiento del cursor)
    CALL      POINTPOSITION     ; Llama al procedimiento para posicionar el cursor

    mov       AH, 9            ; Establece AH=09H (función de impresión de cadena)
    LEA       DX, mc             ; Carga la dirección del mensaje mc en DX
    INT       21H                ; Llama al servicio de interrupción 21H del DOS (imprimir cadena)

    mov       AH, 01H            ; Establece AH=01h (función de lectura de teclado sin eco)
    INT       21H                ; Llama al servicio de interrupción 21H del DOS (espera entrada del usuario)

    RET       ; Retorna al punto de llamada

    ;         15250 /10, res=0, coc=1525
    ;         1525 /10, res=5, coc=152
    ;         152 /10, res=2, coc=15
    ;         15 /10, res=5, coc=1
    ;         1 /10, res=1, coc=0



    CONVERTN  ENDP
    ;-------------------------------------------------------------- [CONVERTN]
    ;-------------------------------------------------------------- [TRYAGAIN]

    TRYAGAIN  PROC
    ;         Este procedimiento maneja la lógica para preguntar al usuario si desea intentar de nuevo.

    CALL      CLEARSCREEN       ; Llama al procedimiento para limpiar la pantalla
    CALL      POINTPOSITION     ; Llama al procedimiento para posicionar el cursor
    mov       AX, 0              ; Limpia AX
    mov       AH, 9            ; Establece AH=09H (función de impresión de cadena)
    LEA       DX, mreturn        ; Carga la dirección del mensaje mreturn en DX
    INT       21H                ; Llama al servicio de interrupción 21H del DOS (imprimir cadena)
    ADD       xp, 02H            ; Suma 02H a xp (posición X para desplazamiento del cursor)
    CALL      POINTPOSITION     ; Llama al procedimiento para posicionar el cursor
    mov       AH, 9            ; Establece AH=09H (función de impresión de cadena)
    LEA       DX, yes            ; Carga la dirección del mensaje yes en DX
    INT       21H                ; Llama al servicio de interrupción 21H del DOS (imprimir cadena)
    ADD       xp, 02H            ; Suma 02H a xp (posición X para desplazamiento del cursor)
    CALL      POINTPOSITION     ; Llama al procedimiento para posicionar el cursor
    mov       AH, 9            ; Establece AH=09H (función de impresión de cadena)
    LEA       DX, no             ; Carga la dirección del mensaje no en DX
    INT       21H                ; Llama al servicio de interrupción 21H del DOS (imprimir cadena)
    ADD       xp, 02H            ; Suma 02H a xp (posición X para desplazamiento del cursor)
    CALL      POINTPOSITION     ; Llama al procedimiento para posicionar el cursor
    mov       AH, 9            ; Establece AH=09H (función de impresión de cadena)
    LEA       DX, melige         ; Carga la dirección del mensaje melige en DX
    INT       21H                ; Llama al servicio de interrupción 21H del DOS (imprimir cadena)

    mov       AH, 01H            ; Establece AH=01h (función de lectura de teclado sin eco)
    INT       21H                ; Llama al servicio de interrupción 21H del DOS (espera entrada del usuario)
    SUB       AX, 304            ; Convierte la entrada ASCII a un número (0 o 1)
    mov       z1, AX             ; Guarda el resultado en z1

    CMP       z1, 1              ; Compara z1 con 1 para determinar la elección del usuario
    JL        TRYAGAIN            ; Salta a TRYAGAIN si z1 es menor que 1 (volver a preguntar)
    JZ        verMENU             ; Salta a verMENU si z1 es igual a 1 (regresar al menú de opciones)
    CMP       z1, 2              ; Compara z1 con 2 para determinar la elección del usuario
    JG        TRYAGAIN            ; Salta a TRYAGAIN si z1 es mayor que 2 (volver a preguntar)
    JZ        exit                ; Salta a exit si z1 es igual a 2 (salir del programa)

    TRYAGAIN  ENDP
    ;-------------------------------------------------------------- [TRYAGAIN]

    exit:
    ;         Procedimiento para finalizar el programa

    CALL      CLEARSCREEN       ; Llama al procedimiento para limpiar la pantalla
    LEA       DX, despedida            ; Carga la dirección del mensaje despedida en DX
    mov       AH, 09H            ; Establece AH=09H (función de impresión de cadena)
    INT       21H                ; Llama al servicio de interrupción 21H del DOS (imprimir cadena)

    .EXIT     ; Termina el programa

    END       ; Finaliza el segmento de código

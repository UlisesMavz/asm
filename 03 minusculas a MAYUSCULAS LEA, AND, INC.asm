    COMMENT   *Realiza un programa que cambie tu nombre en minusculas a MAYUSCULAS y que lo muestre en pantalla.
    Utilice   un ciclo "loop" y directivas simplificadas. *


    .MODEL    small ;modelo de memoria

    .STACK    100H ;area de pila, tamano de 256 bytes

    .DATA     ;area de datos
    mensaje   db 'mi nombre en minusculas es ulises', 13, 10 ;asigna la variable de mensaje
    db        'y en mayusculas es $'
    nombre    db 'ulises'

    .CODE     ;area de codigo
    begin:
    ;inicio   de la ejecucion del programa

    mov       AX, @DATA ;asigna la direccion de datos a AX
    mov       DS, AX ;a traves de AX a DS

    mov       DX, offset mensaje ;asigna el nombre a DX
    mov       AH, 9 ;asigna la funcion 9 de la INT 21H a AH
    INT       21H

    LEA       BX, nombre ;transfiere la direccion de desplazamiento de nombre a BX
    mov       CX, 6 ;asigna el contador a 6 porque el nombre es de 6 letras

    repite:
    ;se       define la etiqueta repite
    mov       AH, [BX] ;asigna el contenido de la direccion de memoria [BX] a AH
    AND       AH, 11011111B ;asigna 11011111 binario a AH

    mov       DL, AH ;asigna el contenido de AH a DL(datos de 8 bits)
    mov       AH, 02H ;asigna la funcion 2 de la INT 21H a AH
    INT       21H ;aparece el mensaje en pantalla

    INC       BX ;incrementa el valor del registro BX en 1
    LOOP      repite ;ciclo LOOP con la etiqueta repite
    mov       AH, 4CH ;asigna la funcion 4C de la INT 21H a AH
    INT       21H

    end       begin ;fin del programa







    COMMENT   *

    LEA       (Load Effective Address) "Cargar la direccion efectiva"
    Transfiere la direccion del desplazamiento del operando fuente al operando destino, el cual el de destino debe ser un registro general de palabras.

    INC       (aritmetica) "increment" "incremento"
    Incrementos de 1 en el contenido del operando de un valor binario sin signo.
    *

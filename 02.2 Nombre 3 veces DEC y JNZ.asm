    COMMENT   * Realiza un programa que imprima tres tu nombre y cada que aparezca suene una campana,
    usando    los nemonicos DEC y JNZ *

    .MODEL    small ;modelo de memoria

    .STACK    100H ;area de pila, 256 bytes

    .DATA     ;area de datos
    mensaje   db 'ULISES', 07, 13, 10, '$' ;se define el mensaje

    .CODE     ;area de codigo
    begin:
    ;inicia   la ejecucion del programa

    mov       AX, @DATA ;direccion de datos a AX
    mov       DS, AX ;a traves de AX a DS

    mov       DX, offset mensaje ;asigna el mensaje a DX
    mov       CX, 3 ;asigna 3 a CX (contador)
    mov       AH, 9 ;asigna la funcion 09 de la INT 21H

    print:
    INT       21H ;etiqueta para imprimir en pantalla

    DEC       CX ;decrementa 1 el contador CX
    JNZ       print ;salta a print si CX no es cero

    mov       AX, 4C00H ;asigna la funcion 4C de la INT 21H
    INT       21H ;devuelve el control a DOS

    end       begin ;fin del programa



    COMMENT   *

    DEC       (aritmetica) "Decrement" "Disminuir"
    Decrementos de 1 el contenido del operando que es un valor binario sin signo.

    JNZ       (transferencia de control) "Jump on Not Zero" "Saltar en No Cero"
    Ocasiona  que la ejecucion de un programa se ramifique hacia la direccion del operando si la bandera de cero está limpia. *


    COMMENT   * Realiza un programa que imprima tres tu nombre y cada que aparezca suene una campana,
    usando    los nemonicos DEC, JCXZ y JMP *

    .MODEL    small ;modelo de memoria

    .STACK    100H ;area de pila que son 256 bytes

    .DATA     ;area de datos
    mensaje   db 'ULISES', 07, 13, 10, '$';se define la variable mensaje

    .CODE     ;area de codigo
    begin:
    ;inicia   la ejecucion del programa

    mov       AX, @DATA ;direccion de Datos a AX
    mov       DS, AX ;a traves de AX se asigna a DS

    mov       DX, offset mensaje ;asigna el mensaje a DX
    mov       CX, 3 ;asigna 3 a CX (contador a 3)
    mov       AH, 9 ;asigna la funcion 9 de la INT 21H a AH

    print:
    INT       21H ;etiqueta para imprimir mensaje en pantalla

    DEC       CX ;decrementa en 1 a CX en cada ciclo
    JCXZ      fin ;salta a la etiqueta fin si CX es CERO
    JMP       print ;salta a la etiqueta print si CX no es CERO

    fin:
    mov       AX, 4C00H ;etiqueta que contiene la funcion 4C de la INT 21H
    INT       21H ;devuelve el control a DOS

    end       begin ;fin del programa


    COMMENT   *

    DEC       (aritmetica) "Decrement" "Disminuir"
    Decrementos de 1 el contenido del operando que es un valor binario sin signo.

    JCXZ      (transferencia de control) "Jump if CX = 0" "Saltar si CX = 0"
    Ocasiona  que la ejecucion de un programa se ramifique hacia la direccion del operando si el valor de CX es 0.

    JMP       (transferencia de control) "Jump" "Saltar"
    Ocasiona  que la ejecucion de un programa comience en la direccion del operando designado. *

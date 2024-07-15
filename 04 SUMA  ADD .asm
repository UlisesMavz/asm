    COMMENT   * Sumar dos numeros inicilizados con las variables "VA" con 25 y "VB" con 12, guardar el resultado
    en        "VC" y mostrarlo en algun registro *


    .MODEL    small ;modelo de memoria

    .STACK    100H ;area de pila

    .DATA     ;area de datos
    ;inicializar las variables con los valores de palabras de 16 bits establecidos
    VA        dw 25
    VB        dw 12
    VC        dw ? ;variable para el resultado

    .CODE     ;area de codigo
    begin:
    ;inicia   la ejecucion del programa

    mov       AX, @DATA ;asigna la direccion de datos a AX
    mov       DS, AX ;a traves de AX a DS

    mov       AX, VA ;asigna VA a AX
    ADD       AX, VB ;añade o suma el contenido VB a AX en valores binarios

    mov       VC, AX ;asigna el contenido de la suma a la variable de resultado VC
    mov       CX, VC ;asigna VC a AX

    mov       AX, 4C00H ;asigna la funcion 4C de la INT 21H a AX
    INT       21H ;devuelve el control a DOS

    end       begin ;fin del programa


    COMMENT   *

    ADD       (aritmetica) "Suma"
    Añade     el contenido del operando fuente (y lo almacena) al operando de destino, valores binarios. *

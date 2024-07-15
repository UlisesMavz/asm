
    COMMENT   * Realiza un programa que imprima tu nombre tres veces en pantalla
    y         que suene una campana cada vez que este aparezca*

    .MODEL    small  ;define el modelo de memoria

    .STACK    64h ;define el area de pila a 64 bytes

    .DATA     ;define el area de datos
    mensaje   db 'ULISES', 07, 13, 10, '$' ;define la variable de mensaje

    .CODE     ; define el area de codigo
    begin:
    ;inica    la ejecucion del programa

    mov       AX, @DATA ;asigna la direccion de datos a AX
    mov       DS, AX ;a traves se asigna AX a DS

    mov       DX, offset mensaje ;asigna el mensaje a DX(puente para E/S para el acceso de datos de 16 bits)
    mov       CX, 3 ;asigna 3 a CX(contador de 16 bits)
    mov       AH, 9 ;asigna la funcion 9 de la int 21H a AH

    PRINT:
    int       21H ;aparece el mensaje en pantalla

    loop      PRINT ;ciclo loop con la etiqueta PRINT

    mov       AH, 4CH ;asigna la funcion 4C de la INT 21H a AH
    int       21H ;devuelve el control a DOS

    end       begin   ;fin del programa


    .model    small                    ;define el modelo de memoria

    .stack    ;define el area de pila

    .data     ;define el area de datos

    mensaje   db    'HOLA,  MUNDO$'   ; define la variable de mensaje

    .code     ;define el area del codigo

    begin:
    ;inicia   la ejecucion del programa

    mov       AX,     @DATA           ;asigna la direccion del segmento de DATOS a AX(AX:Acumulador - conserva el resultado temporal)
    mov       DS,     AX              ;a traves de AX se asigna la direccion de datos a DS(Segmento de Dato)

    mov       DX,     offset mensaje  ;asigna el mensaje a DX(puente para E/S para el acceso de datos de 16 bits)

    mov       AH,     9               ;asigna la funcion 09 de la INT 21H a AH
    int       21H                     ;aparece el mensaje en pantalla

    mov       AH,     4CH             ;asigna la funcion 4C de la INT 21H a AH
    int       21H                     ; int 21H a AH, devuelve el control al DOS(Sistema Operativo de Disco)

    end       begin                   ; fin del programa

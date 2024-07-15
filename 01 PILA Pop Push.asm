
    COMMENT   * Hacer un programa que almacene los valores de AX (1000h), BX (2000h),
    y         CX (3000h) en la pila.

    DESPUES   DE LOS PUSH:

    1000H     2000H           3000H
    AX        BX              CX

    1er       POP recuperar el valor original de CX almacenado en la pila y colocarlo en AX.
    2do       POP recuperar el valor original de BX y colocarlo en CX.
    3er       POP recuperar el valor original de AX y colocarlo en BX.

    DESPUES   DE LOS POP:

    3000H     1000H           2000H
    AX        BX              CX*

    COMMENT   *
    ------------------------------------------
    1000H     2000H           3000H
    AX        BX              CX
    ------------------------------------------
    1er       POP AX (valor de CX a AX):

    3000H     2000H           3000H
    AX        BX              CX
    ------------------------------------------
    2do       POP CX (valor de BX a CX):

    3000H     2000H           2000H
    AX        BX              CX
    ------------------------------------------
    3er       POP BX (valor de AX a CX):

    3000H     1000H           2000H
    AX        BX              CX
    ------------------------------------------ *

    .MODEL    small                 ;define el modelo de memoria

    .STACK    ;define el area de la pila

    .DATA     ;define el area de codigo

    A         equ 1000H             ;variable A es igual a 1000H
    B         equ 2000H             ;variable B es igual a 2000H
    C         equ 3000H             ;variable C es igual a 3000H

    .CODE     ;define el area de codigo
    begin:
    ;inicio   del programa


    mov       AX, @data   ;asigna la direccion de un DATO a AX(acumulador)
    mov       DS, AX      ;asigna la direccion AX a DS(Segmento de datos)

    mov       AX, A       ;asigna el contenido de A a AX(acumulador de 16 bits; conserva el resultado temporal)
    mov       BX, B       ;asigna el contenido de B a BX(base de 16 bits; conserva la direccion base de los datos)
    mov       CX, C       ;asigna el contenido de C a CX(contador de 16 bits; iterador que automaticamente crece o decrece)

    push      AX        ;guarda el contenido de A a AX,  regresa la palabra que se encuentra en la Pila en donde apunta el SP, lo envia a AX e incrementa el SP en dos con los bytes invertidos con los bytes invertidos
    push      BX        ;guarda el contenido de B a BX,  regresa la palabra que se encuentra en la Pila en donde apunta el SP, lo envia a BX e incrementa el SP en dos con los bytes invertidos con los bytes invertidos
    push      CX        ;guarda el contenido de C a CX,  regresa la palabra que se encuentra en la Pila en donde apunta el SP, lo envia a CX e incrementa el SP en dos con los bytes invertidos con los bytes invertidos

    pop       AX         ;asigna el contenido original de CX a AX, regresa la palabra que se encuentra en la Pila en donde apunta el SP, lo envia a AX e incrementa el SP en dos con los bytes invertidos
    pop       CX         ;asigna el contenido original de BX a CX, regresa la palabra que se encuentra en la Pila en donde apunta el SP, lo envia a CX e incrementa el SP en dos con los bytes invertidos
    pop       BX         ;asigna el contenido original de AX a BX, regresa la palabra que se encuentra en la Pila en donde apunta el SP, lo envia a BX e incrementa el SP en dos con los bytes invertidos

    mov       AH, 4CH    ;asigna la funcion 4C de la int 21H a AH
    int       21H        ;devuelve el control al DOS(Sistema Operativo de Disco)

    end       begin      ;fin del programa



    ;directivas no simplificadas
    PILA      segment para stack 'STACK'
    db        64 dup(0)
    PILA      ends

    DATOS     segment para 'DATA'
    A         equ 1000H
    B         equ 2000H
    C         equ 3000H
    DATOS     ends

    CODIGO    segment para 'CODE'
    assume    CS:CODIGO, DS:DATOS, SS:PILA
    BEGIN     PROC FAR

    MOV       AX, DATOS           ; Asigna la dirección del segmento de datos a AX
    MOV       DS, AX              ; Asigna la dirección de datos a DS a través de AX

    MOV       AX, A               ; Asigna el contenido de A a AX
    MOV       BX, B               ; Asigna el contenido de B a BX
    MOV       CX, C               ; Asigna el contenido de C a CX

    PUSH      AX                 ; Guarda el contenido de AX en la pila
    PUSH      BX                 ; Guarda el contenido de BX en la pila
    PUSH      CX                 ; Guarda el contenido de CX en la pila

    POP       AX                  ; Recupera el contenido original de CX en AX
    POP       CX                  ; Recupera el contenido original de BX en CX
    POP       BX                  ; Recupera el contenido original de AX en BX

    MOV       AH, 4CH             ; Asigna la función 4C de la INT 21H a AH
    INT       21H                 ; Devuelve el control al DOS
    BEGIN     ENDP

    CODIGO    ENDS

    END       BEGIN


    .MODEL    small ;modelo de memoria

    .STACK    100H ;area de pila

    .DATA     ;area de datos

    V         equ 1234h ;define una variable constante V
    B         equ 3099h ;define una variable constante B

    .CODE     ;area de codigo
    begin:
    ;inicio   de la ejecucion del programa


    mov       DX, V ;asigna el valor de V a DX
    mov       BX, B ;asigna el valor B a BX

    mov       AL, BL ;mueve el bit inferior de BX (99h) a AL
    SUB       AL, DL ;mueve el bit inferior de DX (34h) a AL
    DAS       ;ajusta AL después de una resta de números BCD empaquetados
    mov       CL, AL ;asigna el resultado de AL al bit inferior de CX (CL)

    mov       AL, BH ;mueve el bit superior de BX (30h) a AL
    mov       AL, DH ;mueve el bit superior de DX (12h) a AL
    DAS       ;ajusta AL después de una resta de números BCD empaquetados
    mov       CH, AL ;asigna el resultado de AL al bit superior de CX (CH)

    mov       AH, 4CH ;asigna la funcion 4C de la INT 21H a AH
    INT       21H ;devuelve el control a DOS

    end       begin ;fin del programa

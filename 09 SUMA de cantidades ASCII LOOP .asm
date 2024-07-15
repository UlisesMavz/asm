    COMMENT*Sumar 15 a cada numero de las siguientes cantidades
    20,28,15,26,19,27,16,29 utilizando el ciclo loop*


    .model    small              ; Define el modelo de memoria como 'small'
    .stack    ; Define el segmento de pila

    .data     ; Comienza el segmento de datos
    Num       db 20,28,15,26,19,27,16,29  ; Define una serie de números
    Num15     db 15                       ; Define la constante 15

    .code     ; Comienza el segmento de código
    inicio    proc far           ; Define el procedimiento 'inicio' como un procedimiento 'far'
    mov       ax,@data      ; Mueve la dirección de inicio del segmento de datos al registro AX
    mov       ds,ax         ; Mueve la dirección del segmento de datos (desde AX) al registro DS

    mov       cx,8          ; Inicializa CX con 8 (número de elementos en el array Num)
    mov       bx,offset Num ; Mueve la dirección de inicio del array Num al registro BX

    print:
    ;         Etiqueta del inicio del bucle
    mov       al,Num15      ; Mueve el valor de Num15 (15) al registro AL
    add       al,[bx]       ; Suma el valor en AL con el valor apuntado por BX
    aam       ; Ajusta AL y AH para representar el valor en AL en formato decimal ASCII
    add       ax,3030h      ; Convierte los dígitos decimales en sus valores ASCII

    mov       dl,ah         ; Mueve el dígito de decenas a DL
    mov       ah,2          ; Función DOS 02h para imprimir el carácter en DL
    int       21h           ; Llama a la interrupción DOS para imprimir el carácter

    mov       dl,al         ; Mueve el dígito de unidades a DL
    int       21h           ; Llama a la interrupción DOS para imprimir el carácter

    inc       bx            ; Incrementa BX para apuntar al siguiente número en el array
    loop      print        ; Decrementa CX y si no es cero, salta a la etiqueta 'print'

    mov       ah,4ch        ; Función DOS 4Ch para terminar el programa
    int       21h           ; Llama a la interrupción DOS para finalizar el programa
    end       inicio                ; Marca el final del procedimiento 'inicio'

    .model    small
    .stack
    .data
    Num       db 20,28,15,26,19,27,16,29
    Num15     db 15

    .code
    inicio    proc far
    mov       ax,@data
    mov       ds,ax

    mov       cx,8
    mov       bx,offset Num
    print:
    mov       al,Num15
    add       al,[bx]
    aam
    inc       bx
    mov       ax,0

    loop      print

    mov       ah,4ch
    int       21h
    end       inicio


    pila      segment para stack 'stack'
    db        dup 64 (0)
    pila      ends

    datos     segment para 'data'
    Num       db 20,28,15,26,19,27,16,29
    Num15     db 15
    datos     ends

    .code
    codigo    segment para 'code'
    begin     proc far
    assume    cs:codigo,ds:datos,ss:pila

    mov       ax,datos
    mov       ds,ax

    mov       cx,8
    mov       bx,offset Num

    print:
    mov       al,Num15
    add       al,[bx]
    inc       bx
    mov       ax,0
    loop      print

    mov       ah,4ch
    int       21h
    begin     endp
    end       begin

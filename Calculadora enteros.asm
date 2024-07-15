    name      "calc2"

    ;         Calculadora simple basada en el símbolo del sistema (+,-,*,/) para 8086.
    ;         Ejemplo de cálculo:
    ;         Entrada 1 <- número:   10
    ;         Entrada 2 <- operador: -
    ;         Entrada 3 <- número:   5
    ;         -------------------
    ;         10 - 5 = 5
    ;         Salida -> número:   5

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;;;       Este macro se copia de emu8086.inc   ;;;
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;         Este macro imprime un carácter en AL y avanza
    ;         la posición actual del cursor:
    PUTC      MACRO   char
    PUSH      AX
    MOV       AL, char
    MOV       AH, 0Eh
    INT       10h
    POP       AX
    ENDM
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    org       100h

    jmp       start


    ;         Definir variables:

    msg0      db "Nota: la calculadora funciona solo con valores enteros.",0Dh,0Ah
    db        "Para aprender a mostrar el resultado de una división de punto flotante, vea float.asm en ejemplos",0Dh,0Ah,'$'
    msg1      db 0Dh,0Ah, 0Dh,0Ah, 'Ingrese el primer número: $'
    msg2      db "Ingrese el operador:    +  -  *  /     : $"
    msg3      db "Ingrese el segundo número: $"
    msg4      db  0dh,0ah , 'El resultado aproximado de mis cálculos es: $'
    msg5      db  0dh,0ah ,'¡Gracias por usar la calculadora! Presione cualquier tecla... ', 0Dh,0Ah, '$'
    err1      db  "¡Operador incorrecto!", 0Dh,0Ah , '$'
    smth      db  " y algo más.... $"

    ;         El operador puede ser: '+','-','*','/' o 'q' para salir a la mitad.
    opr       db '?'

    ;         Primer y segundo número:
    num1      dw ?
    num2      dw ?


    start:
    mov       dx, offset msg0
    mov       ah, 9
    int       21h


    lea       dx, msg1
    mov       ah, 09h    ; imprime cadena en ds:dx
    int       21h


    ;         Obtener el número firmado de múltiples dígitos
    ;         desde el teclado y almacenar
    ;         el resultado en el registro cx:

    call      scan_num

    ;         almacenar primer número:
    mov       num1, cx



    ;         nueva línea:
    putc      0Dh
    putc      0Ah




    lea       dx, msg2
    mov       ah, 09h     ; imprime cadena en ds:dx
    int       21h


    ;         obtener operador:
    mov       ah, 1   ; entrada de un solo carácter a AL.
    int       21h
    mov       opr, al



    ;         nueva línea:
    putc      0Dh
    putc      0Ah


    cmp       opr, 'q'      ; q - salir a la mitad.
    je        exit

    cmp       opr, '*'
    jb        wrong_opr
    cmp       opr, '/'
    ja        wrong_opr






    ;         salida de una cadena en ds:dx
    lea       dx, msg3
    mov       ah, 09h
    int       21h


    ;         Obtener el número firmado de múltiples dígitos
    ;         desde el teclado y almacenar
    ;         el resultado en el registro cx:

    call      scan_num


    ;         almacenar segundo número:
    mov       num2, cx




    lea       dx, msg4
    mov       ah, 09h      ; imprime cadena en ds:dx
    int       21h




    ;         calcular:





    cmp       opr, '+'
    je        do_plus

    cmp       opr, '-'
    je        do_minus

    cmp       opr, '*'
    je        do_mult

    cmp       opr, '/'
    je        do_div


    ;         ninguno de los anteriores....
    wrong_opr:
    lea       dx, err1
    mov       ah, 09h     ; imprime cadena en ds:dx
    int       21h


    exit:
    ;         salida de una cadena en ds:dx
    lea       dx, msg5
    mov       ah, 09h
    int       21h


    ;         esperar cualquier tecla...
    mov       ah, 0
    int       16h


    ret       ; retorno al sistema operativo.

    do_plus:
    mov       ax, num1
    add       ax, num2
    call      print_num    ; imprime el valor de ax.

    jmp       exit



    do_minus:

    mov       ax, num1
    sub       ax, num2
    call      print_num    ; imprime el valor de ax.

    jmp       exit




    do_mult:

    mov       ax, num1
    imul      num2 ; (dx ax) = ax * num2.
    call      print_num    ; imprime el valor de ax.
    ;         dx se ignora (la calculadora funciona solo con números pequeños).

    jmp       exit




    do_div:
    ;         dx se ignora (la calculadora funciona solo con números enteros pequeños).
    mov       dx, 0
    mov       ax, num1
    idiv      num2  ; ax = (dx ax) / num2.
    cmp       dx, 0
    jnz       approx
    call      print_num    ; imprime el valor de ax.
    jmp       exit
    approx:
    call      print_num    ; imprime el valor de ax.
    lea       dx, smth
    mov       ah, 09h    ; imprime cadena en ds:dx
    int       21h
    jmp       exit


    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;;;       Estas funciones se copian de emu8086.inc    ;;;
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    ;         obtiene el número firmado de múltiples dígitos desde el teclado,
    ;         y almacena el resultado en el registro CX:
    SCAN_NUM  PROC    NEAR
    PUSH      DX
    PUSH      AX
    PUSH      SI

    MOV       CX, 0

    ;         reiniciar bandera:
    MOV       CS:make_minus, 0

    next_digit:

    ;         obtener char del teclado
    ;         en AL:
    MOV       AH, 00h
    INT       16h
    ;         y mostrarlo:
    MOV       AH, 0Eh
    INT       10h

    ;         verificar por MINUS:
    CMP       AL, '-'
    JE        set_minus

    ;         verificar por tecla ENTER:
    CMP       AL, 0Dh  ; retorno de carro?
    JNE       not_cr
    JMP       stop_input
    not_cr:


    CMP       AL, 8                   ; 'BACKSPACE' presionado?
    JNE       backspace_checked
    MOV       DX, 0                   ; quitar último dígito por
    MOV       AX, CX                  ; división:
    DIV       CS:ten                  ; AX = DX:AX / 10 (DX-resto).
    MOV       CX, AX
    PUTC      ' '                     ; posición clara.
    PUTC      8                       ; backspace de nuevo.
    JMP       next_digit
    backspace_checked:


    ;         permitir solo dígitos:
    CMP       AL, '0'
    JAE       ok_AE_0
    JMP       remove_not_digit
    ok_AE_0:
    CMP       AL, '9'
    JBE       ok_digit
    remove_not_digit:
    PUTC      8       ; backspace.
    PUTC      ' '     ; borrar último ingresado no dígito.
    PUTC      8       ; backspace de nuevo.
    JMP       next_digit ; esperar para la próxima entrada.
    ok_digit:


    ;         multiplicar CX por 10 (primera vez el resultado es cero)
    PUSH      AX
    MOV       AX, CX
    MUL       CS:ten                  ; DX:AX = AX*10
    MOV       CX, AX
    POP       AX

    ;         verificar si el número es demasiado grande
    ;         (el resultado debe ser de 16 bits)
    CMP       DX, 0
    JNE       too_big

    ;         convertir de código ASCII:
    SUB       AL, 30h

    ;         agregar AL a CX:
    MOV       AH, 0
    MOV       DX, CX      ; respaldo, en caso de que el resultado sea demasiado grande.
    ADD       CX, AX
    JC        too_big2    ; salta si el número es demasiado grande.

    JMP       next_digit

    set_minus:
    MOV       CS:make_minus, 1
    JMP       next_digit

    too_big2:
    MOV       CX, DX      ; restaurar el valor de respaldo antes de agregar.
    MOV       DX, 0       ; DX era cero antes de la copia de seguridad!
    too_big:
    MOV       AX, CX
    DIV       CS:ten  ; revertir el último DX:AX = AX*10, hacer AX = DX:AX / 10
    MOV       CX, AX
    PUTC      8       ; backspace.
    PUTC      ' '     ; borrar último dígito ingresado.
    PUTC      8       ; backspace de nuevo.
    JMP       next_digit ; esperar Enter/Backspace.


    stop_input:
    ;         verificar bandera:
    CMP       CS:make_minus, 0
    JE        not_minus
    NEG       CX
    not_minus:

    POP       SI
    POP       AX
    POP       DX
    RET
    make_minus DB      ?       ; utilizado como bandera.
    SCAN_NUM  ENDP





    ;         esta rutina imprime el número en AX,
    ;         utilizada con PRINT_NUM_UNS para imprimir números firmados:
    PRINT_NUM PROC    NEAR
    PUSH      DX
    PUSH      AX

    CMP       AX, 0
    JNZ       not_zero

    PUTC      '0'
    JMP       printed

    not_zero:
    ;         verificar SIGNO de AX,
    ;         hacerlo positivo si es negativo:
    CMP       AX, 0
    JNS       positive
    NEG       AX

    PUTC      '-'

    positive:
    CALL      PRINT_NUM_UNS
    printed:
    POP       AX
    POP       DX
    RET
    PRINT_NUM ENDP



    ;         esta rutina imprime un número no firmado
    ;         en AX (no solo un dígito)
    ;         valores permitidos van de 0 a 65535 (FFFF)
    PRINT_NUM_UNS PROC    NEAR
    PUSH      AX
    PUSH      BX
    PUSH      CX
    PUSH      DX

    ;         bandera para evitar imprimir ceros antes del número:
    MOV       CX, 1

    ;         (resultado de "/ 10000" siempre es menor o igual a 9).
    MOV       BX, 10000       ; 2710h - divisor.

    ;         ¿AX es cero?
    CMP       AX, 0
    JZ        print_zero

    begin_print:

    ;         verificar divisor (si es cero ir a end_print):
    CMP       BX,0
    JZ        end_print

    ;         evitar imprimir ceros antes del número:
    CMP       CX, 0
    JE        calc
    ;         si AX<BX entonces el resultado de DIV será cero:
    CMP       AX, BX
    JB        skip
    calc:
    MOV       CX, 0   ; establecer bandera.

    MOV       DX, 0
    DIV       BX      ; AX = DX:AX / BX   (DX=resto).

    ;         imprimir último dígito
    ;         AH siempre es CERO, así que se ignora
    ADD       AL, 30h    ; convertir a código ASCII.
    PUTC      AL


    MOV       AX, DX  ; obtener resto de la última división.

    skip:
    ;         calcular BX=BX/10
    PUSH      AX
    MOV       DX, 0
    MOV       AX, BX
    DIV       CS:ten  ; AX = DX:AX / 10   (DX=resto).
    MOV       BX, AX
    POP       AX

    JMP       begin_print

    print_zero:
    PUTC      '0'

    end_print:

    POP       DX
    POP       CX
    POP       BX
    POP       AX
    RET
    PRINT_NUM_UNS ENDP



    ten       DW      10      ; utilizado como multiplicador/divisor por SCAN_NUM & PRINT_NUM_UNS.







    GET_STRING PROC    NEAR
    PUSH      AX
    PUSH      CX
    PUSH      DI
    PUSH      DX

    MOV       CX, 0                   ; contador de caracteres.

    CMP       DX, 1                   ; ¿buffer demasiado pequeño?
    JBE       empty_buffer            ;

    DEC       DX                      ; reservar espacio para el último cero.


    ;============================
    ;         Bucle eterno para obtener
    ;         y procesar pulsaciones de teclas:

    wait_for_key:

    MOV       AH, 0                   ; obtener tecla presionada.
    INT       16h

    CMP       AL, 0Dh                  ; ¿'RETURN' presionado?
    JZ        exit_GET_STRING


    CMP       AL, 8                   ; ¿'BACKSPACE' presionado?
    JNE       add_to_buffer
    JCXZ      wait_for_key            ; ¡nada que quitar!
    DEC       CX
    DEC       DI
    PUTC      8                       ; retroceso.
    PUTC      ' '                     ; borrar posición.
    PUTC      8                       ; retroceso de nuevo.
    JMP       wait_for_key

    add_to_buffer:

    CMP       CX, DX          ; ¿el buffer está lleno?
    JAE       wait_for_key    ; si es así, esperar por 'BACKSPACE' o 'RETURN'...

    MOV       [DI], AL
    INC       DI
    INC       CX

    ;         imprimir la tecla:
    MOV       AH, 0Eh
    INT       10h

    JMP       wait_for_key
    ;============================

    exit_GET_STRING:

    ;         terminar con nulo:
    MOV       [DI], 0

    empty_buffer:

    POP       DX
    POP       DI
    POP       CX
    POP       AX
    RET
    GET_STRING ENDP

section .data
    blank_line: db " ", 0
    ;---------------------------------------------------------------------------
    ; state0 messages
    state0_msg1: db "press 1 to put item on the green belt",0

section .text

clearTerminal:
    push eax
    push ebx

    xor ebx, ebx
    _loopN:
        mov eax, blank_line ; newline char
        call sprintLF
        inc ebx
        cmp ebx, 30
        jnz _loopN
    _endLoopN:
    pop ebx
    pop eax

    ret

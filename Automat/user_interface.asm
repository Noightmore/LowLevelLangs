section .data

    ;---------------------------------------------------------------------------
    ; Text picture of the belt system
    ;---------------------------------------------------------------------------
    pt_start:   db "                                   $   ",10,0
    pt1:        db "                                ______ ",10,0
    pt2:        db "                               |      |",10,0
    pt3:        db "                               |      |",10,0
    pt4:        db "                               |      |",10,0
    pt5:        db " |-----------------------------|      |",10,0
    pt6:        db " |                             |      |",10,0
    pt7:        db "$|                             |      |",10,0
    pt8:        db " |                             |      |",10,0
    pt9:        db " |-----------------------------|      |",10,0
    pt10:       db "                               |      |",10,0
    pt11:       db "                               |      |",10,0
    pt12:       db "                               |______|",10,0
    pt_end:     db "                                   $   ",10,0

    belt_system: dd pt_start,pt1,pt2,pt3,pt4,pt5,pt6,pt7,pt8,pt9,pt10,pt11,pt12,pt_end
    belt_system_len equ $-belt_system

    ;---------------------------------------------------------------------------
    ; all possible item on belt positions
    ; their pointers
    pos1: dd pt7+3
    pos2: dd pt7+17
    pos3: dd pt7+31 ; at this position slowmode activates; end of green belt




    ;---------------------------------------------------------------------------
    ; general messages
    blank_line: db " ", 0

    ;---------------------------------------------------------------------------
    ; state0 messages

    ;---------------------------------------------------------------------------
    ; state1 messages
    state1_msg1: db "press 1 to put item on the green belt",0

section .text

clearTerminal:
    push eax
    push ebx

    xor ebx, ebx
    _loopN:
        mov eax, blank_line ; blank line with newline char
        call sprintLF
        inc ebx
        cmp ebx, 30
        jnz _loopN
    _endLoopN:
    pop ebx
    pop eax

    ret

loadUserInput:
    push eax
    push ebx
    push ecx
    push edx

    mov edx, 2
    mov ecx, user_choice ; empty 2 byte data buffer
    mov ebx, 0
    mov eax, 3

    int 80h

    ; removes the linefeed from the input
    mov al, 0
    mov [user_choice+1], al

    pop edx
    pop ecx
    pop ebx
    pop eax

    ret

printBeltSystem:
    push ebx
    push ecx
    push eax

    mov ebx, belt_system
    mov ecx, belt_system_len
    add ecx, ebx ; final address

    _printing:
        mov eax, [ebx]
        call sprint
        add ebx, 4
        cmp ebx, ecx
        jnz _printing

    pop eax
    pop ecx
    pop ebx
    ret

section .data

    ;---------------------------------------------------------------------------
    ; Text picture of the belt system
    ;---------------------------------------------------------------------------
    pt_start:   db "                                   $   ",10,0
    pt1:        db "                                ______ ",10,0
    pt2:        db "                               |      |",10,0
    pt3:        db "                               |      |",10,0
    pt4:        db "                               |      |",10,0
    pt5:        db " |-----------------------------|------|",10,0
    pt6:        db " |                             |      |",10,0
    pt7:        db "$|                             |      |",10,0
    pt8:        db " |                             |      |",10,0
    pt9:        db " |-----------------------------|------|",10,0
    pt10:       db "                               |      |",10,0
    pt11:       db "                               |      |",10,0
    pt12:       db "                               |______|",10,0
    pt_end:     db "                                   $   ",10,0

    belt_system: dd pt_start,pt1,pt2,pt3,pt4,pt5,pt6,pt7,pt8,pt9,pt10,pt11,pt12,pt_end
    belt_system_len equ $-belt_system

    ;---------------------------------------------------------------------------
    ; all possible item on belt positions
    ; their pointers
    ; todo rework this to reflect the amount of states + rework commentary
    pos1 equ pt7+3
    pos2 equ pt7+17 ; not used, only for visual effect maybe
    pos3 equ pt7+30 ; at this position slowmode activates; end of green belt
    pos4 equ pt7+35 ; at this position green belt stops

    pos5_left equ pt4+35
    pos6_left equ pt2+35 ; at this position blue belt slows down
    pos7_left equ pt1+35 ; at this position blue belt stops ; default_state is "_"

    pos5_right equ pt10+35
    pos6_right equ pt11+35 ; at this position blue belt slows down
    pos7_right equ pt12+35 ; at this position blue belt stops ; default_state is "_"


    ;---------------------------------------------------------------------------
    ; general data
    blank_line: db " ", 0
    ;---------------------------------------------------------------------------
    blank_space: db " ",0
    underscore: db "_",0
    item: db "X",0

    ;---------------------------------------------------------------------------
    ; state1 messages
    state1_msg1: db "press 1 to put item on the green belt",0

    ;---------------------------------------------------------------------------
    ; state6 messages
    state6_msg1: db "press 1 to take item from the left or press 2 to take item on the right",0

section .bss
    user_choice: resb 2

section .text

clearTerminal:
    push eax
    push ebx

    xor ebx, ebx
    _loopN:
        mov eax, blank_line ; blank line with newline char
        call sprintLF
        inc ebx
        cmp ebx, 100
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

; sets the item position based on the state and time that has passed
; pointer to the current state is to be stored in eax register (ptr to integer)
setItemPositionByState:
    ; if state is 0, then set all positions to empty
    cmp byte [eax], 0
    jz setBeltState0

    cmp byte [eax], 1
    jz setBeltState1

    cmp byte [eax], 2
    jz setBeltState2

    cmp byte [eax], 3
    jz setBeltState3

    cmp byte [eax], 4
    jz setBeltState4

    cmp byte [eax], 5
    jz setBeltState5

    cmp byte [eax], 6
    jz setBeltState6

    ret

setBeltState0:
    mov al, [blank_space]
    mov [pos1], al
    mov [pos2], al
    mov [pos3], al
    mov [pos4], al
    mov [pos5_left], al
    mov [pos6_left], al
    mov [pos5_right], al
    mov [pos6_right], al

    mov al, [underscore]
    mov [pos7_right], al
    mov [pos7_left], al
    ret

setBeltState1:
    mov al, [blank_space]
    mov [pos2], al
    mov [pos3], al
    mov [pos4], al
    mov [pos5_left], al
    mov [pos6_left], al
    mov [pos5_right], al
    mov [pos6_right], al

    mov al, [underscore]
    mov [pos7_right], al
    mov [pos7_left], al

    ; puts item on the green belt at pos1
    mov al, [item]
    mov [pos1], al
    ret

setBeltState2:
    mov al, [blank_space]
    mov [pos1], al
    mov [pos2], al
    mov [pos4], al
    mov [pos5_left], al
    mov [pos6_left], al
    mov [pos5_right], al
    mov [pos6_right], al

    mov al, [underscore]
    mov [pos7_right], al
    mov [pos7_left], al

    mov al, [item]
    mov [pos3], al
    ret

setBeltState3:
    mov al, [blank_space]
    mov [pos1], al
    mov [pos2], al
    mov [pos3], al
    mov [pos5_left], al
    mov [pos6_left], al
    mov [pos5_right], al
    mov [pos6_right], al

    mov al, [underscore]
    mov [pos7_right], al
    mov [pos7_left], al

    mov al, [item]
    mov [pos4], al
    ret

setBeltState4:
    ; reads direct data of automat...
    cmp byte [m_is_running_right], byte set_on
    jz setBeltState4_right
    jmp setBeltState4_left

setBeltState4_right:
    mov al, [blank_space]
    mov [pos1], al
    mov [pos2], al
    mov [pos3], al
    mov [pos4], al
    mov [pos5_left], al
    mov [pos6_left], al
    mov [pos6_right], al

    mov al, [underscore]
    mov [pos7_right], al
    mov [pos7_left], al

    mov al, [item]
    mov [pos5_right], al
    ret

setBeltState4_left:
    mov al, [blank_space]
    mov [pos1], al
    mov [pos2], al
    mov [pos3], al
    mov [pos4], al
    mov [pos5_right], al
    mov [pos6_left], al
    mov [pos5_right], al
    mov [pos6_right], al

    mov al, [underscore]
    mov [pos7_right], al
    mov [pos7_left], al

    mov al, [item]
    mov [pos5_left], al
    ret

setBeltState5:
    cmp byte [m_is_running_right], byte set_on
    jz setBeltState5_right
    jmp setBeltState5_left

setBeltState5_right:
    mov al, [blank_space]
    mov [pos1], al
    mov [pos2], al
    mov [pos3], al
    mov [pos4], al
    mov [pos5_right], al
    mov [pos5_left], al
    mov [pos6_left], al
    mov [pos6_right], al

    ;mov al, [underscore]
    ;mov [pos7_right], al
    ;mov [pos7_left], al

    mov al, [item]
    mov [pos7_right], al
    ret

setBeltState5_left:
    mov al, [blank_space]
    mov [pos1], al
    mov [pos2], al
    mov [pos3], al
    mov [pos4], al
    mov [pos5_left], al
    mov [pos6_left], al
    mov [pos5_right], al
    mov [pos6_right], al

    mov al, [underscore]
    mov [pos7_right], al

    mov al, [item]
    mov [pos7_left], al
    ret

setBeltState6:
    push eax
    mov eax, blank_line
    call sprintLF
    mov eax, state6_msg1
    call sprintLF
    pop eax
    ret
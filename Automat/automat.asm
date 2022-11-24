; Compile with: nasm -f elf automat.asm
; Link with (64 bit systems require elf_i386 option): ld -m elf_i386 automat.o -o automat
; Run with: ./automat

; This program is a simple implementation of a finite state machine.

%include "functions.asm"
%include "user_interface.asm"
%include "automat_data.asm"

section .data
    state_id: db 0

    ; half a second
    running_sleep_interval:
            tv_sec  dd 0
            tv_nsec dd 500000000
    ; a second
    slow_running_sleep_interval:
            tv_sec1  dd 1
            tv_nsec1 dd 0

section .text
    global _start

_start:
    ;---------------------------------------------------------------------------
    ; state 0
    ; initialises default states
    ; sets na_give to 1
    ;---------------------------------------------------------------------------
    state0:
        ; set current state to be 0
        xor al,al
        mov [state_id],al

        call _initialiseStates
        mov al, set_on
        mov [na_give], al

        ; print belt
        mov eax, state_id
        call clearTerminal
        call setItemPositionByState
        call printBeltSystem

        ; jmp state1

    ;---------------------------------------------------------------------------
    ; state 1
    ; waits for na_has_given_in to be set to 1
    ;---------------------------------------------------------------------------
    state1:
        ; increment state_id (whilst preserving the contents of al registry)
        xchg al, [state_id]
        inc al
        xchg [state_id], al

        ; maybe add this to automat_logic and wait for this async
        _waitForItemToBePutOnGreenBelt:
        mov eax, blank_line
        call sprintLF
        mov eax, state1_msg1
        call sprintLF

        ; todo: implement better method for reading user input
        ; possible implementation, reserve waay more bytes like 32 or even 128
        ; then only care if the first byte == ascii_codeof(1) and second byte == ascii_codeof(\n)

        call loadUserInput
        ; checkIfInputIsOne:
        mov al, [user_choice]
        sub al, 48
        cmp al, set_on
        jne _waitForItemToBePutOnGreenBelt

        ; if input == 1 (item is put on the green belt)
        ; set vars && jump to state2
        mov al, set_on
        mov [na_has_given_in], al

        ; print the current state
        mov eax, state_id
        call setItemPositionByState
        call clearTerminal
        call printBeltSystem
        ; jmp state2


    state2:
        xchg al, [state_id]
        inc al
        xchg [state_id], al

        ; set vars
        mov al, set_off
        mov ah, set_on
        mov [na_give], al ; off
        mov [z_is_running], ah ; on

        ; running state
        ; item will be near stop after .5 second at near stop, z_is_near_stop will be set to 1
        ; maybe add this to automat_logic and wait for this async
        mov eax, 162
        mov ebx, running_sleep_interval
        mov ecx, 0
        int 0x80

        ; item is near stop, so now we jump to state3
        mov [z_is_near_stop], byte set_on

        ; print the current state
        mov eax, state_id
        call setItemPositionByState
        call clearTerminal
        call printBeltSystem
        ; jmp state3

    state3:
        xchg al, [state_id]
        inc al
        xchg [state_id], al

        ; set vars
        mov al, set_off
        mov ah, set_on
        mov [z_is_running], al ; off
        mov [z_is_running_slowly], ah ; on

        ; near stop state
        ; after 1 second we will get to the z_stop state
        ; maybe add this to automat_logic and wait for this async
        mov eax, 162
        mov ebx, slow_running_sleep_interval
        mov ecx, 0
        int 0x80
        ; item is at the final position to be stopped
        mov [z_is_near_stop], byte set_on

        ; print the current state
        mov eax, state_id
        call setItemPositionByState
        call clearTerminal
        call printBeltSystem
        ; jmp state4

    state4:
        xchg al, [state_id]
        inc al
        xchg [state_id], al

        ; set vars
        ; 1) switch blue belt direction
        mov al, [m_is_running_right]
        xchg [m_is_running_left], al
        mov [m_is_running_right], al

        ; set blue belt to run
        mov al, set_on
        mov [m_is_running], al

        ; shut off green belt
        mov [z_is_running_slowly], byte set_off

        ; run blue belt until it reaches lnear or rnear
        ; heres a simulation that makes it take half a second
        mov eax, 162
        mov ebx, running_sleep_interval
        mov ecx, 0
        int 0x80

        cmp [m_is_running_left], byte set_on
        jz _m_is_running_left4

        _m_is_running_right4:
            mov [m_is_near_stop_right], byte set_on
            jmp _finally4
        _m_is_running_left4:
            mov [m_is_near_stop_left], byte set_on
            ;jmp _finally4

        _finally4:
            ; print the current state
            mov eax, state_id
            call setItemPositionByState
            call clearTerminal
            call printBeltSystem
            ;jmp state5
    state5:
        xchg al, [state_id]
        inc al
        xchg [state_id], al

        ; set vars
        mov [m_is_running], byte set_off
        mov [m_is_running_slowly], byte set_on

        ; run blue belt slowly until it reaches stop
        ; in this simulation it takes 1 second
        mov eax, 162
        mov ebx, slow_running_sleep_interval
        mov ecx, 0
        int 0x80

        cmp [m_is_running_left], byte set_on
        jz _m_is_running_left5

        _m_is_running_right5:
            mov [m_is_to_be_stopped_right], byte set_on
            jmp _finally5
        _m_is_running_left5:
            mov [m_is_to_be_stopped_left], byte set_on
            ;jmp _finally5

        _finally5:
        ; print the current state
        mov eax, state_id
        call setItemPositionByState
        call clearTerminal
        call printBeltSystem
        ; jmp state6

    state6:
        xchg al, [state_id]
        inc al
        xchg [state_id], al

        ; check direction
        cmp [m_is_to_be_stopped_right], byte set_on
        jnz checkLeftSignal
        mov [vy_take_right], byte set_on
        jmp finally6

        checkLeftSignal:
            cmp [m_is_to_be_stopped_left], byte set_on
            jnz quit ; fatal error?
            mov [vy_take_left], byte set_on
            ;call quit ; some fatal error occured if this is ever called, maybe jump to state5 instead?

        ; set vars
        finally6:
            ; shut off blue belt
            mov [m_is_running_slowly], byte set_off
            mov eax, state_id
            call setItemPositionByState
            _waitForUserToTakeTheItem:
                call loadUserInput
                mov al, [user_choice]
                sub al, 48
                cmp al, set_on
                jz _checkIfItemIsAtLeftPosition
                cmp al, 2
                jz _checkIfItemIsAtRightPosition
                jmp _waitForUserToTakeTheItem

            _checkIfItemIsAtLeftPosition:
                cmp [vy_take_left], byte set_on
                jz state0
                jmp _waitForUserToTakeTheItem
            _checkIfItemIsAtRightPosition:
                cmp [vy_take_right], byte set_on
                jz state0
                jmp _waitForUserToTakeTheItem
;call quit






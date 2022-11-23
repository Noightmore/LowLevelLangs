; Compile with: nasm -f elf automat.asm
; Link with (64 bit systems require elf_i386 option): ld -m elf_i386 automat.o -o automat
; Run with: ./automat

; This program is a simple implementation of a finite state machine.

%include "functions.asm"
%include "user_interface.asm"
%include "automat_data.asm"

section .text
    global _start

_start:
    ;---------------------------------------------------------------------------
    ; state 0
    ; initialises default states
    ; sets na_give to 1
    ; then waits for na_has_given_in to be set to 1
    ;---------------------------------------------------------------------------
    state0:
        call _initialiseStates
        mov al, set_on
        mov [na_give], al
        _waitForItemToBePutOnGreenBelt:
            call clearTerminal
            mov eax, state0_msg1
            call sprintLF




    call quit






_initialiseStates:
    xor al, al
    mov [z_is_running], al
    mov [z_is_running_slowly], al
    mov [z_is_near_stop], al
    mov [z_is_to_be_stopped], al

    mov [m_is_running], al
    mov [m_is_running_slowly], al
    mov [m_is_running_right], al
    mov [m_is_running_left], al
    mov [m_is_near_stop_right], al
    mov [m_is_near_stop_left], al
    mov [m_is_to_be_stopped_right], al
    mov [m_is_to_be_stopped_left], al

    mov [na_give], al
    mov [na_has_given_in], al

    mov [vy_take_right], al
    mov [vy_take_left], al
    mov [vy_has_taken_right], al
    mov [vy_has_taken_left], al

    ret

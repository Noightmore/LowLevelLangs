section .data
    ;---------------------------------------------------------------------------
    ; zeleny pas data
    z_is_running:             db 0  ; out
    z_is_running_slowly:      db 0  ; out
    z_is_near_stop:           db 0  ; in
    z_is_to_be_stopped:       db 0  ; in

    ;---------------------------------------------------------------------------
    ; modry pas data
    m_is_running:             db 0  ; out
    m_is_running_slowly:      db 0  ; out
    m_is_running_right:       db 0  ; out
    m_is_running_left:        db 1  ; out - initial state, belt goes to right first in state4
    m_is_near_stop_right:     db 0  ; in
    m_is_near_stop_left:      db 0  ; in
    m_is_to_be_stopped_right: db 0  ; in
    m_is_to_be_stopped_left:  db 0  ; in

    ;---------------------------------------------------------------------------
    ; nakladac data
    na_give:                  db 0  ; out
    na_has_given_in:          db 0  ; in

    ;---------------------------------------------------------------------------
    ; vykladac data
    vy_take_right:            db 0  ; out
    vy_take_left:             db 0  ; out
    vy_has_taken_right:       db 0  ; in
    vy_has_taken_left:        db 0  ; in

    ;---------------------------------------------------------------------------
    ; constants
    set_on equ 1
    set_off equ 0

section .text

_initialiseStates:
    xor al, al
    mov [z_is_running], al
    mov [z_is_running_slowly], al
    mov [z_is_near_stop], al
    mov [z_is_to_be_stopped], al

    mov [m_is_running], al
    mov [m_is_running_slowly], al
    ;mov [m_is_running_right], al
    ;mov [m_is_running_left], al
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
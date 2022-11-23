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
    m_is_running_left:        db 0  ; out
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

section .bss
    user_choice: resb 2
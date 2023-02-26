; General functions to use in main program

global assert_not_null
global assert_null
global sleep_ms
global exit

;------------------------------------------
; Assert the input is not null.
;
; @param rdi
;   Value to check is not null.
;
; @param rsi
;   Pointer to error message string.
;
assert_not_null:
    push rbp
    mov rbp, rsp

    cmp rdi, 0
    jne assert_not_null_end

    mov rdi, rsi
    call print

    mov rdi, 1
    call exit

assert_not_null_end:

    pop rbp
    ret

;------------------------------------------
; Assert the input is null.
;
; @param rdi
;   Value to check is null.
;
; @param rsi
;   Pointer to error message string.
;
assert_null:
    push rbp
    mov rbp, rsp

    cmp rdi, 0
    je assert_null_end

    mov rdi, rsi
    call print

    mov rdi, 1
    call exit

assert_null_end:

    leave
    ;pop rbp
    ret

;------------------------------------------
; Exit the program.
;
; @param rdi
;    Exit code.
exit:
    mov rax, 0x3c
    syscall
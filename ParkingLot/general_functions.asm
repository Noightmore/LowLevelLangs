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
; Sleep the current process for the supplied number of milliseconds.
;
; @param rdi
;   Number of milliseconds to sleep for.
;
sleep_ms:
    push rbp
    mov rbp, rsp

    imul rdi, rdi, 1000000 ; convert supplied ms to ns
    xor rax, rax
    ; recreate struct timepec on the stack
    push rdi ; tv_nsec
    push rax ; tv_sec

    ; nanosleep syscall
    mov rax, 35
    mov rdi, rsp
    mov rsi, 0x0
    syscall

    add rsp, 16

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
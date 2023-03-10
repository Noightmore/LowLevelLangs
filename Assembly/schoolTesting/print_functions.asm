; Functions that handle printing data to STDOUT

global print
global print_num

;------------------------------------------
; Print a string to STDOUT.
;
; @param rdi
;   Address of null terminated string to print.
;
; @returns
;   Number of bytes output.
;
print:
    push rbp ; prologue, save the state of RBX, RBP, & R12-R15.
    mov rbp, rsp

    mov r10, rdi ; save off string address
    mov r9, rdi ; iterator register for string
    movzx rax, byte [r9] ; load first byte
    mov rcx, 0x0 ; accumulator for string length

count_null_start:
    cmp rax, 0x0 ; are we at the null byte?
    je count_null_end

    inc rcx ; increment accumulator
    inc r9 ; move to next byte
    movzx rax, byte [r9] ; load byte
    jmp count_null_start

count_null_end:
    ; syscall to write string to stdout
    mov rax, 0x1
    mov rdi, 0x1;
    mov rsi, r10
    mov rdx, rcx
    syscall

    leave
    ;pop rbp
    ret

;------------------------------------------
; Print an integer to STDOUT (with a new line).
;
; @param rdi
;   Unsigned number to print.
;
print_num:
    push rbp
    mov rbp, rsp
    sub rsp, 0x15 ; get stack space for two buffers, one to convert the number into a string (in reverse order)]
                  ; and another to reverse the string into

    mov r9, rdi ; r9 will be the mutable copy of the input number
    mov rdx, rdi
    mov rcx, 0x0 ; accumulator for string length

    mov rdi, rsp ; set destination as start of first buffer

write_loop_start:

    mov rax, r9 ; load number to be divided
    mov rdx, 0 ; zero out remainder
    mov r10, 0xa ; divisor by 10
    div r10 ; rdx = remainder, rax = quotient

    mov r11, 0x30
    add rdx, r11 ; add 0x30 to remainder to get ASCII code for number

    mov [rdi], dl ; write ASCII byte to buffer
    inc rcx ; increment how many characters have been written

    cmp rax, 0x0 ; check if we have reached the end
    je write_loop_end

    inc rdi
    mov r9, rax ; load remainder into r9 so it can be divided again
    jmp write_loop_start

write_loop_end:

    mov rsi, rdi ; move destination into source so we can reverse it
    mov rdi, rsp
    add rdi, 0xa ; set destination to start of second buffer

reverse_loop_start:
    cmp rcx, 0x0
    je reverse_loop_end

    movzx rax, byte [rsi]
    mov [rdi], al ; write ascii character into second buffer
    dec rsi
    inc rdi

    dec rcx; ; keep track of how many characters we've reversed
    jmp reverse_loop_start
reverse_loop_end:

    mov rax, 0xa
    mov [rdi], al ; write newline character into the end

    mov rdi, rsp
    add rdi, 0xa ; print second buffer
    call print

    leave
    ret

;------------------------------------------
; compute modulus
; @param rdi
;   dividend
; @param rsi
;   divisor
; @return rax = rdi % rsi
get_modulus:
    push rbp
    mov rbp, rsp

    mov rax, rdi
    mov rcx, rsi
    xor rdx, rdx
    div rcx
    mov rax, rdx

    leave
    ret



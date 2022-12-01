; compile with: nasm -f elf64 main.asm -o main.o
; link with: ld main.o -o main
; run with: ./main

%include "print_functions.asm"

section .rodata
    ascii_conversion_vec: db 48, 48, 48, 48
    num_conversion_vec: db 100, 10, 1, 0

    input_msg: db "Enter a number", 10, 0
    warning_msg: db "Must be of 3 digit format (for example 1 would be written as 001): ", 0
    ; note: if value that is higher than 255 or lower than 0 is entered, it will just overflow
    ; valid msg format is 3 digits, 0-255, for example 001, 255, 100, etc. and line feed at the end (10)
section .bss
    user_msg: resb 4
    parsed_num: resb 1


section .text
global _start

_start:

    state1:

    ; read serial input instead

    mov rdi, input_msg
    call print
    mov rdi, warning_msg
    call print

    ; read 4 bytes from stdin
    mov rax, 0
    mov rdi, 0
    mov rsi, user_msg
    mov rdx, 4
    syscall

    ; TODO: normalize the input to be of standard 001, 012, 123, etc.

    state2:
    ; parse input

    ; neat vector trick to convert all chars to numbers
    movd mm0, dword [user_msg]
    movd mm1, dword [ascii_conversion_vec]
    psubb mm0, mm1

    movd mm1, dword [num_conversion_vec]
    pmaddubsw mm0, mm1

    ; store the result in parsed_num
    movd eax, mm0
    mov bl, al
    add bl, ah
    shr eax, 16
    add bl, al
    add bl, ah
    mov byte [parsed_num], bl

    ; save result to user_msg
    ;movd dword [user_msg], mm0

    state3:
    ; print result to the serial output
    xor rdi, rdi
    mov rdi, [parsed_num]
    call print_num


; debug
;    ; print numbers
;    xor rbx, rbx
;    ;mov rax, user_msg ;ptr
;    mov bl, [user_msg]
;    mov rdi, rbx
;    call print_num
;
;    mov bl, [user_msg+1]
;    mov rdi, rbx
;    call print_num
;
;    mov bl, [user_msg+2]
;    mov rdi, rbx
;    call print_num

    ; exit
    mov rax, 60
    mov rdi, 0
    syscall
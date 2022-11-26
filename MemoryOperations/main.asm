; memory subroutines tester

; compile with: nasm -f elf64 main.asm -o main.o
; link with: ld main.o -o main
; run with: ./main

; written for 64-bit mode
%include "print_functions.asm"
%include "general_functions.asm"
%include "malloc.asm"
%include "free.asm"

section .rodata
    hello_world: db "Hello, world!", 0
    newline: db 10, 0
    number_7: db 7

section .text
    global _start

    extern print
    extern print_num
    extern malloc
    extern mmap

_start:

;    mov rdi, hello_world ; load input arguments for the function
;    call print ; call the function
;    xor rax, rax ; clear return value
;
;    mov rdi, newline
;    call print
;    xor rax, rax
;
;    mov rdi, [number_7]
;    call print_num
;    xor rax, rax

    ; min allocation size is page size which is 4096 bytes
    ; bruh moment
    ; https://www.man7.org/linux/man-pages/man2/mmap.2.html

    mov rdi, 0x10
    ; mmap 10 bytes of memory
    call malloc
    push rax

    ; fill the memory with its own address
    mov [rax], rax
    mov [rax + 8], rax

    mov rdi, [rax]
    call print_num

    pop rax
    mov rdi, [rax + 8]
    push rax
    call print_num
    pop rax

    ; mlock 10 bytes of memory starting at rax
    ; https://www.man7.org/linux/man-pages/man3/mlock.3p.html
    mov rdi, rax
    mov rsi, 4
    mov rax, 149
    syscall

;    mov rdi, 4096
;    push rdi
;    xor rdi, rdi
;
;    pop rsi
;    mov rdx, 0x3
;    mov r10, 0x22
;    mov r8, 0x0
;    mov r9, 0x0
;    mov rax, 9
;    syscall

    ; populate the memory
;    mov rbx, 0x0
;    mov byte [rax], 49
;    mov byte [rax+1], 49
;    mov byte [rax+2], 50
;    mov byte [rax+3], 51
;    mov byte [rax+4], 52
;    mov byte [rax+5], 53
;    mov byte [rax+6], 54
;    mov byte [rax+7], 55
;    mov byte [rax+8], 56
;    mov byte [rax+9], 57
;    mov byte [rax+10], 58
;    mov byte [rax+11], 59
;    mov byte [rax+12], 60
;    mov byte [rax+13], 61
;    mov byte [rax+14], 62
;    mov byte [rax+15], 63
;    mov byte [rax+16], 64
;    mov byte [rax+17], 65
;    mov byte [rax+18], 65
;    mov byte [rax+19], 65
;    mov byte [rax+20], 65
;    mov byte [rax+21], 65
;    mov byte [rax+22], 65
;    mov byte [rax+23], 65
;    mov byte [rax+24], 65
;    mov byte [rax+25], 65
;    mov byte [rax+26], 65
;    mov byte [rax+27], 65
;    mov byte [rax+28], 65
;    mov byte [rax+39], 65
;
;    mov [rax + 30], rbx ; set next to be null
;
;    mov rdi, rax
;    call print
;
;    mov rdi, newline
;    call print
;
;    mov rdi, 4096
;    push rdi
;    xor rdi, rdi
;
;    pop rsi
;    mov rdx, 0x3
;    mov r10, 0x22
;    mov r8, 0x0
;    mov r9, 0x0
;    mov rax, 9
;    syscall
;
;    mov rbx, 0x0
;    mov byte [rax], 50
;    mov [rax + 1], rbx ; set next to be null
;    mov rdi, rax
;    call print
;
;    mov rdi, newline
;    call print
;
;    ; munmap memory at rax
;    mov rdi, rax
;    mov rsi, 4096
;    mov rax, 11
;    syscall

    call exit

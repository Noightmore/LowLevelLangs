; compile with: nasm -f elf64 main.asm -o main.o
; link with: ld main.o -o main
; run with: ./main

%include "print_functions.asm"
%include "memory_functions.asm"
%include "general_functions.asm"
;extern malloc

section .data
    thread_id: db 1
    thread_spawn_count: dq 4

    sleep_interval:
        tv_sec  dd 1
        tv_nsec dd 500000000

    newline: db 10, 0

section .bss
    parkingLotMemPTR: resq 1
section .text
    global _start


;    extern print
_start:

    ; Allocate memory for parking lot
    mov rdi, [thread_spawn_count]
    inc rdi ; for null byte terminator
    call malloc
    mov qword [parkingLotMemPTR], rax
    ; dynamically spawn threads
    ; sys_clone with shared virtual memory with parent

    ; intialize memory:
    mov rdi, parkingLotMemPTR
    mov rcx, [thread_spawn_count]
    add rcx, rdi ; address of the end of parking lot

    _populate:
        mov byte [rdi], 48
        inc rdi
        cmp rdi, rcx
        jne _populate

    ;inc rdi ; for null byte terminator
    mov byte [rdi], 0

    ;sys_fork
    _thread_spawner:
<<<<<<< HEAD
;        mov rax, 2
;        int 0x80
;
;        cmp rax, 0
;        jz child
         mov rdi, thread_id
         call print
=======
        mov rax, 2
        int 0x80

        cmp rax, 0
        jz child
>>>>>>> 6a49fc20bb40c7db623a3e9060311aacaead484e

    parent:
        mov rax, [thread_id]
        inc rax
        xchg [thread_id], rax

        cmp rax, [thread_spawn_count]
        jne _thread_spawner

        call exit

    child:
       mov rax, 162
       mov rbx, sleep_interval
       mov rcx, 0
       int 0x80

       ; write into parking lot at thread id
       mov rax, [thread_id]
       mov byte [parkingLotMemPTR], al

       ; print parking lot
       mov rdi, parkingLotMemPTR
       call print
       mov rdi, newline
       call print
       call exit

    ; mmx registry, nice
    ;movq mm0, 0x0000000000000000









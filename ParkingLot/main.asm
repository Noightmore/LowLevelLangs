; compile with: nasm -f elf64 main.asm -o main.o
; link with: ld main.o -o main
; run with: ./main

%include "print_functions.asm"
%include "malloc.asm"
%include "general_functions.asm"

section .data
    thread_id: db 1
    thread_spawn_count: dq 4

    running_sleep_interval:
        tv_sec  dd 1
        tv_nsec dd 500000000

    newline: db 10, 0

section .bss
    parkingLotMemPTR: resq 1
section .text
    global _start

;    extern malloc
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
    ;_thread_spawner:
        mov rax, 2
        int 0x80

        cmp rax, 0
        jz child

    parent:
        mov rax, [thread_id]
        inc rax
        mov [thread_id], rax

        ;cmp rax, [thread_spawn_count]
        ;jne _thread_spawner

        call exit

    child:
       mov eax, 162
       mov ebx, running_sleep_interval
       mov ecx, 0
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






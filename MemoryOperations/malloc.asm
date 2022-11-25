; simple implementation of malloc
; just allocates more memory pages

global mmap
global malloc

extern assert_not_null

; Map new pages into the process.
;
; @param rdi
;   Number of bytes to map.
;
; @returns
;   Address of allocated memory.
;
section .data
    malloc_init: dq 0
    malloc_memory: dq 0

section .rodata
    mmap_failed: db "mmap failed", 10, 0

mmap:
    push rbp
    mov rbp, rsp

    push rdi

    mov rax, 0x9
    mov rdi, 0x0 ; kernel chooses address
    pop rsi ; number of bytes to map
    mov rdx, 0x3 ; PROT_READ | PROT_WRITE
    mov r10, 0x22 ; MAP_PRIVATE | MAP_ANONYMOUS
    mov r8, 0x0 ; no backing file
    mov r9, 0x0 ; no offset

    syscall

    push rax

    mov rdi, rax
    sub rdi, 0xffffffffffffffff ; check MAP_FAILED was not returned
    lea rsi, [mmap_failed]
    call assert_not_null
    pop rax

    pop rbp
    ret


;------------------------------------------------------------------
; Simple implementation of malloc.
;
; Note that there is no equivalent of free, this just allocates memory from a large static buffer.
;
; @param rdi
;   Number of bytes to allocate.
;
; @returns
;   Address of allocated memory in rax
;
malloc:
    push rbp
    mov rbp, rsp

    push rdi

    ; if this is the first call then allocate a large fixed size buffer to "malloc" from
    mov rax, [malloc_init]
    cmp rax, 0x0
    jne malloc_do_init_done

    mov rdi, 4096000 ; 4MB
    call mmap

    mov [malloc_memory], rax
    mov rax, 0x1
    mov [malloc_init], rax

malloc_do_init_done:

    pop rdi

    mov rax, [malloc_memory] ; get address from head of buffer
    mov rbx, rax
    add rbx, rdi ; advance buffer by requested size
    mov [malloc_memory], rbx

    leave
    ;pop rbp
    ret

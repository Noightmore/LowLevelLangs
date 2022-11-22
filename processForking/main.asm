%include "macros.asm"
; include c library for malloc
%include "clib.asm"
extern malloc
extern free

section .data

    tv_sec: dq 1
    tv_nsec: dq 0
    delay: dq tv_sec, tv_nsec ; 1 second delay 0 nanoseconds

    ;current_time: dq 1
    thread_count: dq 4
    thread_index: dq 0

    hello: db "Hello, World!", 0x0a, 0x00
    num_to_print: dq num,10,0

section .bss
    num: resq 1

section .text
    global _start
_start:
    ;
    _threadSpawnStart:
        ; SYS_fork
        mov rax, 2
        int 0x80

        cmp rax, 0
        jz _newThread
        jmp _parent

    _threadSpawnEnd:
        xor rax,rax
        mov [thread_index], rax
        jmp _threadSpawnStart

_parent:
   mov rax, [thread_index]
   mov rbx, [thread_count]
   inc rbx
   cmp rax, rbx ; not(thread_index == thread_count+1)
   jne _threadSpawnStart

   ;exit
       mov rax, 60
       mov rdi, 0
       syscall


_newThread:
    mov  rdi, 1000          ; Allocate a block (mov $1000, %rdi).
    call malloc
   mov rax, 35
   mov rdi, delay
   mov rsi, 0
   syscall

   ; printing thread number
;   mov rax, [thread_index]
;   add rax, 48
;   mov qword [num], rax
   mov rax, [thread_index]

   call iprintLF

   mov rax, [thread_index]
   add rax, 1
   mov [thread_index], rax

   ;mov rax, [tv_sec]
   ;add rax, 2
   ;mov [tv_sec], rax

    ;exit
    mov rax, 60
    mov rdi, 0
    syscall



;------------------------------------------
                            ; void iprintLF(Integer number)
                            ; Integer printing function with linefeed (itoa)
                            iprintLF:
                                call    iprint          ; call our integer printing function

                                push    rax             ; push eax onto the stack to preserve it while we use the eax register in this function
                                mov     rax, 0Ah        ; move 0Ah into eax - 0Ah is the ascii character for a linefeed
                                push    rax             ; push the linefeed onto the stack so we can get the address
                                mov     rax, rsp        ; move the address of the current stack pointer into eax for sprint
                                call    sprint          ; call our sprint function
                                pop     rax             ; remove our linefeed character from the stack
                                pop     rax             ; restore the original value of eax before our function was called
                                ret

 ;------------------------------------------
                            ; void iprint(Integer number)
                            ; Integer printing function (itoa)
                            iprint:
                                push    rax             ; preserve eax on the stack to be restored after function runs
                                push    rcx             ; preserve ecx on the stack to be restored after function runs
                                push    rdx             ; preserve edx on the stack to be restored after function runs
                                push    rsi             ; preserve esi on the stack to be restored after function runs
                                mov     rcx, 0          ; counter of how many bytes we need to print in the end

                            divideLoop:
                                inc     rcx             ; count each byte to print - number of characters
                                mov     rdx, 0          ; empty edx
                                mov     rsi, 10         ; mov 10 into esi
                                idiv    rsi             ; divide eax by esi
                                add     rdx, 48         ; convert edx to it's ascii representation - edx holds the remainder after a divide instruction
                                push    rdx             ; push edx (string representation of an intger) onto the stack
                                cmp     rax, 0          ; can the integer be divided anymore?
                                jnz     divideLoop      ; jump if not zero to the label divideLoop

                            printLoop:
                                dec     rcx             ; count down each byte that we put on the stack
                                mov     rax, rsp        ; mov the stack pointer into eax for printing
                                call    sprint          ; call our string print function
                                pop     rax             ; remove last character from the stack to move esp forward
                                cmp     rcx, 0          ; have we printed all bytes we pushed onto the stack?
                                jnz     printLoop       ; jump is not zero to the label printLoop

                                pop     rsi             ; restore esi from the value we pushed onto the stack at the start
                                pop     rdx             ; restore edx from the value we pushed onto the stack at the start
                                pop     rcx             ; restore ecx from the value we pushed onto the stack at the start
                                pop     rax             ; restore eax from the value we pushed onto the stack at the start
                                ret
                                ;------------------------------------------
                                                            ; void sprint(String message)
                                                            ; String printing function
                                                            sprint:
                                                                push    rdx
                                                                push    rcx
                                                                push    rbx
                                                                push    rax
                                                                call    slen

                                                                mov     rdx, rax
                                                                pop     rax

                                                                mov     rcx, rax
                                                                mov     rbx, 1
                                                                mov     rax, 4
                                                                int     80h

                                                                pop     rbx
                                                                pop     rcx
                                                                pop     rdx
                                                                ret

 ;------------------------------------------
                            ; int slen(String message)
                            ; String length calculation function
                            slen:
                                push    rbx
                                mov     rbx, rax

                            nextchar:
                                cmp     byte [rax], 0
                                jz      finished
                                inc     rax
                                jmp     nextchar

                            finished:
                                sub     rax, rbx
                                pop     rbx
                                ret

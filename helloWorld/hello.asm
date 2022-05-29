global _start

; to execute the program: ./hello

section .data ; a used data section
  message: db "Hello, world!", 0xA, 0x00 ; ten is the ascii code for new line, then null terminator
  length equ $ - message

; text part - all code that is being executed
section .text

_start:             
    mov EAX, 4 ; sys_write function - more on official docs: http://asm.sourceforge.net/syscall.html
    mov EBX, 1 ; file descriptor - first argument passed to the function
    mov ECX, message ; char - second argument that gets passed to the function
    mov EDX, length ; length - third argument that gets passed to the function
    int 0x80
    mov EAX, 1 ; sys_exit
    mov EBX, 1
    int 0x80


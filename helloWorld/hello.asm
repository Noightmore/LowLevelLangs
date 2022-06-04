; to execute the program: ./hello
; useful pastebin: https://pastebin.com/N1ZdmhLw

%include "linux_consts.asm"
%include "macros.asm"

section .data ; a used data section
  nameQuestionMSG db "What is your name? ", 10, 0
  greetByNameMSG db "Hello, ", 0

section .bss
    name resb 16  ; reserves bytes

section .text
    global _start

    _start:
        print nameQuestionMSG
        call _getUserName
        print greetByNameMSG
        print name
        exit ; a macro for exiting the program

    _getUserName:
        mov rax, 0
        mov rdi, 0
        mov rsi, name
        mov rdx, 16
        syscall
        ret
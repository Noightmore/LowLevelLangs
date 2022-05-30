; to execute the program: ./hello

section .data ; a used data section
  nameQuestionMSG db "What is your name? ", 10, 0
  greetByNameMSG db "Hello, ", 0

section .bss
    name resb 16  ; reserves bytes

section .text
    global _start

    _start:
        mov rax, nameQuestionMSG
        call _printText
        call _getUserName
        mov rax, greetByNameMSG
        call _printText
        mov rax, name
        call _printText

        mov rax, 60
        mov rdi, 0
        syscall

    _getUserName:
        mov rax, 0
        mov rdi, 0
        mov rsi, name
        mov rdx, 16
        syscall
        ret

    ; input: rax is a pointer to string
    ; output: prints string located at rax
    _printText:
        push rax
        mov rbx, 0
        ; doFor in assembly #komedie
        _doFor:
            inc rax
            inc rbx
            mov cl, [rax]
            cmp cl, 0
            jne _doFor
        mov rax, 1
        mov rdi, 1
        pop rsi
        mov rdx, rbx
        syscall

        ret
; Compile with: nasm -f elf pointerTest.asm
; Link with (64 bit systems require elf_i386 option): ld -m elf_i386 pointerTest.o -o pointerTest
; Run with: ./pointerTest

%include "functions.asm"

section .data
    pole_longu: dd 21,3,1,46,443,23
    delka_pole: dd 24 ; (4 * 6) (there are 4 bytes six times)

section .text
    global _start
_start:
    mov esi, dword pole_longu
    _longPrint:
    mov eax, [esi]
    call iprintLF

    mov eax, dword [delka_pole]
    ;call iprintLF
    add eax, dword pole_longu
    ;call iprintLF
    ;mov eax, esi
    ;call iprintLF

    add esi, 4
    cmp eax, esi
    jz _end

    ;mov eax, esi
    ;call iprintLF
    jmp _longPrint

    _end:
    ; exit
    mov eax, 1
    mov ebx, 0
    int 0x80

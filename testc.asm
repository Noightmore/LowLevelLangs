; Compile with: nasm -f elf testc.asm
; Link with (64 bit systems require elf_i386 option): ld -m elf_i386 testc.o -o testc
; Run with: ./testc

; program je psan ve 32bitovem modu

; jako funguje, kdyz se do pole longu daji mala cisla napr. 1,2,3 a pouzije se licha maska
; tak vysledek jsou nuly, protoze se vymazou prave strany longu...

%include "functions.asm"

section .data
    ; neresime zde dynamickou alokaci

    pole_longu: dd 2123,31111,15554,46,443,23 ; pole pointeru na 32bitova cisla
    delka_pole: dd 24 ; delka pole (6 * sizeof(long)), sizeof(long) == 4 bytes
    delka_pole_intu: dd 12 ; delka pole (6 * sizeof(int)), sizeof(int) == 2 bytes

    ; u me v testu to bylo 2D pole plne pointeru bud na maska_licha, nebo maska_suda
    ; pocet pointeru na masku == pocet prvku v poli pole_longu
    ; maska mela byt nezavisla na zbytku programu, proto byla takto implementovana v testu

    maska_suda: db 0h, 0xFF, 0h, 0xFF ; maska pro sude bity
    maska_licha: db 0xFF, 0h, 0xFF, 0h ; maska pro liche bity

    ; id masky, ktera se ma pouzit 0 = suda, 1 (nebo cokoliv jineho) = licha,
    ; idealnejsi by bylo, kdyby to zadaval uzivatel, pro jednoduchost nastaveno staticky v programu
    prave_pouzivana_maska_id: dd 0

section .bss
    pole_intu16: resw 6 ; pointer na pole pro 16bitova cisla
    pouzivana_maska_ptr: resd 1 ; pointer na prave pouzivanou masku

section .text
    global _start
_start:
    ;
    ; nacteni adresy prave pouzivane masky do pouzivana_maska_ptr
    mov ebx, [prave_pouzivana_maska_id]
    cmp ebx, 0
    je suda
    ; jmp licha

    licha:
        mov eax, maska_licha
        mov [pouzivana_maska_ptr], eax
        jmp aplikace_masky
    suda:
        mov eax, maska_suda
        mov [pouzivana_maska_ptr], eax
        ;jmp aplikace_masky

    ; projde se cyklicky kazdy long, nejdrive prvni, pak druha cast, a vymaskuji se byty,
    ; ty se rovnou nahraji do pole intu16
    aplikace_masky:
        ; nacteni pointeru
        mov esi, pole_longu ; ptr na zacatek pole longu
        mov edi, pole_intu16 ; ptr na zacatek reservovanych mist pro pole intu16

        foreachLong:
            mov ecx, [pouzivana_maska_ptr] ; ptr na zacatek pole masky

            ; vymaskovani jednotlivych bytu
            mov ax, [esi]
            and ah, [ecx]

            inc ecx
            and al, [ecx]
            ; store higher long part to stack
            push ax

            ; zpracovani druhe casti longu
            next_part:
            add esi, 2 ; posunuti na dalsi 2byte (pravou stranu longu)
            inc ecx
            and ah, [ecx]
            inc ecx
            and al, [ecx]
            ; store lower long part to stack
            push ax

            ; popnou se, nejdriv ty, co byly v longu nejvic na pravo (princip zasobniku/LIFO)
            ; po te ty, co byly nejvice v levo, cili byly v algoritmu zpracovavany nejdrive
            nacteni_platnych_bajtu:
            pop ax
            pop bx
            cmp al, 0
            jz load_lower_bytes

            load_upper_bytes:
            mov ah, bh
            jmp store

            load_lower_bytes:
            mov al, bl
            ;jmp store

            store: ; zapise vymaskovana data do pole intu16
            mov [edi], ax

            increment:
            ; posunuti pointeru na dalsi long a dalsi ulozny prostor pro int16
            add esi, 2
            add edi, 2
            ; zjisteni konce pole, prosli vsechny longy
            mov eax, [delka_pole]
            add eax, pole_longu
            cmp eax, esi ;(ptr == ptr_konec_pole)
            jne foreachLong
            ;jmp intPrinting

    intPrinting:
        mov esi, dword pole_intu16 ; ptr na zacatek pole intu16

        _intPrint:
        mov eax, [esi]
        call iprintLF

        mov eax, dword [delka_pole_intu] ; sizeof(int16) * 6
        add eax, dword pole_intu16 ; PTR !!!!

        add esi, 2
        cmp eax, esi
        jnz _intPrint
        ;jmp _end
    _end:
        ; konec programu
        mov eax, 1
        mov ebx, 0
        int 0x80
